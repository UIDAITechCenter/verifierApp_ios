
import Foundation
import BigInt

class BigIntConverter {
    
    // MARK: - BigInt to XML String Conversion
    
    /// Converts a BigInt Base10 string to an XML string
    func bigIntToXMLString(base10String: String) -> String? {
        guard let compressedData = base10StringToBigIntData(base10String: base10String),
              let decompressedData = gunzip(data: compressedData) else {
            print("Failed to convert BigInt to Data")
            return nil
        }
        
        let cleanData = removeDelimiter(from: decompressedData)
        return iso88591BytesToXMLString(data: cleanData)
    }
    
    /// Converts a Base10 string to compressed Data
    private func base10StringToBigIntData(base10String: String) -> Data? {
        guard let bigint = BigInt(base10String) else { return nil }
        
        var byteArray = [UInt8]()
        var value = bigint
        
        while value > 0 {
            byteArray.append(UInt8(value % 256))
            value /= 256
        }
        
        return Data(byteArray.reversed())
    }
    
    /// Decompresses Data using GZIP
    private func gunzip(data: Data) -> Data? {
        return try? data.gunzipped()
    }
    
    /// Removes delimiter (if present)
    private func removeDelimiter(from data: Data) -> Data {
        if data.last == 0xFF {
            return data.dropLast()
        }
        return data
    }
    
    /// Converts Data encoded in ISO-8859-1 to an XML string
    private func iso88591BytesToXMLString(data: Data) -> String? {
        return String(data: data, encoding: .isoLatin1)
    }
    
    // MARK: - XML String to BigInt Conversion
    
    /// Converts an XML string back to a BigInt Base10 string
    func xmlStringToBigIntBase10(xmlString: String) -> String? {
        guard let cleanData = xmlStringToISO88591Bytes(xmlString: xmlString) else {
            print("Failed to convert XML string to Data")
            return nil
        }
        
        let dataWithDelimiter = addDelimiter(to: cleanData)
        
        guard let compressedData = gzip(data: dataWithDelimiter) else {
            print("Failed to gzip data")
            return nil
        }
        
        // Convert compressed Data back to BigInt
        return bigIntFromCompressedData(compressedData: compressedData)
    }

    /// Converts an XML string to Data encoded in ISO-8859-1
    private func xmlStringToISO88591Bytes(xmlString: String) -> Data? {
        return xmlString.data(using: .isoLatin1)
    }

    /// Appends a delimiter to the Data
    private func addDelimiter(to data: Data) -> Data {
        return data + Data([0xFF]) // Add 0xFF at the end
    }

    /// Compresses Data using GZIP
    private func gzip(data: Data) -> Data? {
        return try? data.gzipped()
    }

    /// Converts compressed Data back to a BigInt Base10 string
    private func bigIntFromCompressedData(compressedData: Data) -> String? {
        var bigint = BigInt(0)
        
        for byte in compressedData {
            bigint = (bigint << 8) | BigInt(byte)
        }
        
        return bigint.description
    }

}

