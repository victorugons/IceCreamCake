enum StoreType: String {
    case salgados
    case doces
    case bebidas
    
    public var name: String {
        return rawValue.capitalized
    }
}
