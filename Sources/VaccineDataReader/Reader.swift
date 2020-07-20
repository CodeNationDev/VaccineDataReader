//
import Foundation
import Kanna

private var table:[Vaccine] = []

public struct Vaccine {
    var name: String?
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

public enum CCAA {
    case madrid,
    clamancha,
    andalucia,
    aragon,
    asturias,
    cyleon,
    cat,
    ceuta,
    extremadura,
    galicia,
    baleares,
    canarias,
    larioja,
    melilla,
    murcia,
    navarra,
    paisvasco,
    valencia
    
    public var url: String {
        let urlbase = "https://vacunasaep.org/profesionales/calendario-vacunas/"
        switch self {
        case .madrid: return urlbase + "madrid"
        case .clamancha: return urlbase + "castilla-la-mancha"
        case .andalucia: return urlbase + "andalucía"
        case .aragon: return urlbase + "aragón"
        case .asturias: return urlbase + "asturias"
        case .cyleon: return urlbase + "castilla-y-león"
        case .cat: return urlbase + "cataluña"
        case .ceuta: return urlbase + "ceuta"
        case .extremadura: return urlbase + "extremadura"
        case .galicia: return urlbase + "galicia"
        case .baleares: return urlbase + "islas-baleares"
        case .canarias: return urlbase + "islas-canarias"
        case .larioja: return urlbase + "la-rioja"
        case .melilla: return urlbase + "melilla"
        case .murcia: return urlbase + "murcia"
        case .navarra: return urlbase + "navarra"
        case .paisvasco: return urlbase + "país-vasco"
        case .valencia: return urlbase + "navarra"
        }
    }
}

public func loadScheduledVaccines(ccaa: CCAA) -> [Vaccine]? {
    let myURLString = ccaa.url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? ""
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
                        var vaccine = Vaccine()
                        vaccine.name = first.trimmingCharacters(in: .whitespacesAndNewlines)
                        data.forEach {
                            if !$0.trimmingCharacters(in: .whitespacesAndNewlines).elementsEqual("") {
                                vaccine.shortname = $0.trimmingCharacters(in: .whitespacesAndNewlines)
                            }
                        }
                        table.append(vaccine)
                    }
                }
            }
        }
    }
    if table.count > 0 { table.remove(at: 0) }
    return table
}
