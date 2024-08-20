import Foundation

// 최소한의 Timestamp 클래스
class TimeStamp {
    private let date: Date

    // 날짜 문자열을 파싱하여 Date 객체를 생성하거나, 인자가 없으면 현재 날짜를 사용
    init(dateString: String? = nil) {
        let dateFormatter = DateFormatter()
        
        if let dateString = dateString {
            // 날짜 문자열을 ISO 8601 형식으로 파싱
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            
            if let parsedDate = dateFormatter.date(from: dateString) {
                self.date = parsedDate
            } else {
                // 날짜 문자열이 유효하지 않은 경우 현재 날짜를 사용
                self.date = Date()
            }
        } else {
            // 날짜 문자열이 제공되지 않은 경우 현재 날짜를 사용
            self.date = Date()
        }
    }

    // UTC 형식으로 날짜를 반환하는 함수
    func UTC() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS '+0000 UTC'"
        formatter.timeZone = TimeZone(abbreviation: "UTC") // UTC 시간대 설정
        return formatter.string(from: date)
    }

    // ISO 형식으로 날짜를 반환하는 함수
    func ISO() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(abbreviation: "UTC") // UTC 시간대 설정
        return formatter.string(from: date)
    }
}