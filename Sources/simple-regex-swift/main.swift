func match(regexp: Substring, text: Substring) -> Bool {
    if regexp.first == "^" {
        return matchhere(regexp: regexp.dropFirst(1), text: text)
    }
    var text = text
    while true {
        if matchhere(regexp: regexp, text: text) {
            return true
        }
        if text.isEmpty {
            return false
        }
        text.removeFirst(1)
    }
}

func matchhere(regexp: Substring, text: Substring) -> Bool {
    if regexp.isEmpty {
        return true
    }
    if regexp.count > 1 && regexp[regexp.index(after: regexp.startIndex)] == "*" {
        return matchstar(c: regexp.first!, regexp: regexp.dropFirst(2), text: text)
    }
    if regexp.first == "$" && regexp.count == 1 {
        return text.isEmpty
    }
    if !text.isEmpty && (regexp.first == "." || regexp.first == text.first) {
        return matchhere(regexp: regexp.dropFirst(1), text: text.dropFirst(1))
    }
    return false
}

func matchstar(c: Character, regexp: Substring, text: Substring) -> Bool {
    var text = text
    while true {
        if matchhere(regexp: regexp, text: text) {
            return true
        }
        if text.isEmpty { return false }
        let theChar = text.first!
        text.removeFirst(1)
        if c != "." && theChar != c { return false }
    }
}

assert(match(regexp: "^a*3$", text: "aaa3"))
assert(match(regexp: "a*3", text: "hello3"))
