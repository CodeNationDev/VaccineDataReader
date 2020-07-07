//
import Foundation
import Kanna

private var table:[Vaccine] = []

public struct Vaccine {
    var name: String?
    var age: [ages]?
    var shortname: String?
}

public enum ages: String, Codable {
    case _2m = "2m",
    _4m = "4m",
    _11m = "11m",
    _12m = "12m",
    _15m = "15m",
    _24m = "24m",
    _3a = "3a",
    _6a = "6a",
    _12a = "12a",
    _14a = "14a"
}

public func loadScheduledVaccines() -> [Vaccine]? {
    let myURLString = "https://vacunasaep.org/profesionales/calendario-vacunas/castilla-la-mancha"
    guard let myURL = URL(string: myURLString) else {
        print("Error: \(myURLString) doesn't seem to be a valid URL")
        return nil
    }
    if let doc = try? Kanna.HTML(url: myURL , encoding: .utf8) {
        for element in doc.css("div") {
            if let className = element.className, className.elementsEqual("views-field-item views-field-field-autonomy-calendar-table-value") {
                for item in element.css("tr") {
                    if let data = item.content?.split(separator: "\n"), let first =
                        data.first {
                        print(data)
                        var vaccine = Vaccine()
                        var auxAges:[ages] = []
                        vaccine.name = first.trimmingCharacters(in: .whitespacesAndNewlines)
                        if data.count >= 10 {
                            if !data[1].trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual("") {
                                auxAges.append(._2m)
                                vaccine.shortname = data[1].trimmingCharacters(in: .whitespacesAndNewlines)
                                
                            }
                            if !data[2].trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual("") {
                                auxAges.append(._4m)
                                vaccine.shortname = data[2].trimmingCharacters(in: .whitespacesAndNewlines)
                                vaccine.shortname = data[2].trimmingCharacters(in: .whitespacesAndNewlines)
                            }
                            if !data[3].trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual("") {
                                auxAges.append(._11m)
                                vaccine.shortname = data[3].trimmingCharacters(in: .whitespacesAndNewlines)
                            }
                            if !data[4].trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual("") {
                                auxAges.append(._12m)
                                vaccine.shortname = data[4].trimmingCharacters(in: .whitespacesAndNewlines)
                            }
                            if !data[5].trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual("") {
                                auxAges.append(._15m)
                                vaccine.shortname = data[5].trimmingCharacters(in: .whitespacesAndNewlines)
                            }
                            if !data[6].trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual("") {
                                auxAges.append(._24m)
                                vaccine.shortname = data[6].trimmingCharacters(in: .whitespacesAndNewlines)
                            }
                            if !data[7].trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual("") {
                                auxAges.append(._3a)
                                vaccine.shortname = data[7].trimmingCharacters(in: .whitespacesAndNewlines)
                            }
                            if !data[8].trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual("") {
                                auxAges.append(._6a)
                                vaccine.shortname = data[8].trimmingCharacters(in: .whitespacesAndNewlines)
                            }
                            if !data[9].trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual("") {
                                auxAges.append(._12a)
                                vaccine.shortname = data[9].trimmingCharacters(in: .whitespacesAndNewlines)
                            }
                            if data.count > 10 && !data[10].trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual("") {
                                auxAges.append(._14a)
                                vaccine.shortname = data[10].trimmingCharacters(in: .whitespacesAndNewlines)
                            }
                        }
                        vaccine.age = auxAges
                        table.append(vaccine)
                    }
                }
            }
        }
    }
    if table.count > 0 { table.remove(at: 0) }
    return table
}
