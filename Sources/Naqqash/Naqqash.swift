import Foundation

public class Naqqash {
    
    public enum ContextualForm {
        case Isolated
        case Final
        case Initial
        case Medial
    }
    
    enum NaqqashError: Error {
        case UnknownCharacter
        case LetterDoesNotHaveRequestedForm
        case CharacterIsNotDecomposable
    }
    
    enum DiacriticType {
        case All
        case Essential
        case NonEssential
    }
    
    static let letters: Set = [
        0x0621, // ARABIC LETTER HAMZA
        0x0622, // ARABIC LETTER ALEF WITH MADDA ABOVE
        0x0623, // ARABIC LETTER ALEF WITH HAMZA ABOVE
        0x0624, // ARABIC LETTER WAW WITH HAMZA ABOVE
        0x0625, // ARABIC LETTER ALEF WITH HAMZA BELOW
        0x0626, // ARABIC LETTER YEH WITH HAMZA ABOVE
        0x0627, // ARABIC LETTER ALEF
        0x0628, // ARABIC LETTER BEH
        0x0629, // ARABIC LETTER TEH MARBUTA
        0x062A, // ARABIC LETTER TEH
        0x062B, // ARABIC LETTER THEH
        0x062C, // ARABIC LETTER JEEM
        0x062D, // ARABIC LETTER HAH
        0x062E, // ARABIC LETTER KHAH
        0x062F, // ARABIC LETTER DAL
        0x0630, // ARABIC LETTER THAL
        0x0631, // ARABIC LETTER EH
        0x0632, // ARABIC LETTER ZAIN
        0x0633, // ARABIC LETTER SEEN
        0x0634, // ARABIC LETTER SHEEN
        0x0635, // ARABIC LETTER SAD
        0x0636, // ARABIC LETTER DAD
        0x0637, // ARABIC LETTER TAH
        0x0638, // ARABIC LETTER ZAH
        0x0639, // ARABIC LETTER AIN
        0x063A, // ARABIC LETTER GHAIN
        0x063B, // ARABIC LETTER KEHEH WITH TWO DOTS ABOVE
        0x063C, // ARABIC LETTER KEHEH WITH THREE DOTS BELOW
        0x063D, // ARABIC LETTER FARSI YEH WITH INVERTED V
        0x063E, // ARABIC LETTER FARSI YEH WITH TWO DOTS ABOVE
        0x063F, // ARABIC LETTER FARSI YEH WITH THREE DOTS ABOVE
        0x0641, // ARABIC LETTER FEH
        0x0642, // ARABIC LETTER QAF
        0x0643, // ARABIC LETTER KAF
        0x0644, // ARABIC LETTER LAM
        0x0645, // ARABIC LETTER MEEM
        0x0646, // ARABIC LETTER NOON
        0x0647, // ARABIC LETTER HEH
        0x0648, // ARABIC LETTER WAW
        0x0649, // ARABIC LETTER ALEF MAKSURA
        0x064A, // ARABIC LETTER YEH
        0x066E, // ARABIC LETTER DOTLESS BEH
        0x066F, // ARABIC LETTER DOTLESS QAF
        0x0671, // ARABIC LETTER ALEF WASLA
        0x0672, // ARABIC LETTER ALEF WITH WAVY HAMZA ABOVE
        0x0673, // ARABIC LETTER ALEF WITH WAVY HAMZA BELOW
        0x0674, // ARABIC LETTER HIGH HAMZA
        0x0675, // ARABIC LETTER HIGH HAMZA ALEF
        0x0676, // ARABIC LETTER HIGH HAMZA WAW
        0x0677, // ARABIC LETTER U WITH HAMZA ABOVE
        0x0678, // ARABIC LETTER HIGH HAMZA YEH
        0x0679, // ARABIC LETTER TTEH
        0x067A, // ARABIC LETTER TTEHEH
        0x067B, // ARABIC LETTER BEEH
        0x067C, // ARABIC LETTER TEH WITH RING
        0x067D, // ARABIC LETTER TEH WITH THREE DOTS ABOVE DOWNWARDS
        0x067E, // ARABIC LETTER PEH
        0x067F, // ARABIC LETTER TEHEH
        0x0680, // ARABIC LETTER BEHEH
        0x0681, // ARABIC LETTER HAH WITH HAMZA ABOVE
        0x0682, // ARABIC LETTER HAH WITH TWO DOTS VERTICAL ABOVE
        0x0683, // ARABIC LETTER NYEH
        0x0684, // ARABIC LETTER DYEH
        0x0685, // ARABIC LETTER HAH WITH THREE DOTS ABOVE
        0x0686, // ARABIC LETTER TCHEH
        0x0687, // ARABIC LETTER TCHEHEH
        0x0688, // ARABIC LETTER DDAL
        0x0689, // ARABIC LETTER DAL WITH RING
        0x068A, // ARABIC LETTER DAL WITH DOT ABOVE
        0x068B, // ARABIC LETTER DAL WITH DOT BELLOW AND SMALL TAH
        0x068C, // ARABIC LETTER DAHAL
        0x068D, // ARABIC LETTER DDAHAL
        0x068E, // ARABIC LETTER DUL
        0x068F, // ARABIC LETTER DAL WITH THREE DOTS ABOVE DOWNWARDS
        0x0690, // ARABIC LETTER DAL WITH FOUR DOTS ABOVE
        0x0691, // ARABIC LETTER RREH
        0x0692, // ARABIC LETTER REH WITH SMALL V
        0x0693, // ARABIC LETTER REH WITH RING
        0x0694, // ARABIC LETTER REH WITH DOT BELOW
        0x0695, // ARABIC LETTER WITH SMALL V BELOW
        0x0696, // ARABIC LETTER REH WITH DOT BELOW AND DOT ABOVE
        0x0697, // ARABIC LETTER REH WITH TWO DOTS ABOVE
        0x0698, // ARABIC LETTER JEH
        0x0699, // ARABIC LETTER REH WITH FOUR DOTS ABOVE
        0x0691, // ARABIC LETTER SEEN WITH DOT BELOW AND DOT ABOVE
        0x069B, // ARABIC LETTER SEEN WITH THREE DOTS BELOW
        0x069C, // ARABIC LETTER SEEN WITH THREE DOTS BELOW AND THREE DOTS ABOVE
        0x069D, // ARABIC LETTER SAD WITH THWO DOTS BELOW
        0x069E, // ARABIC LETTER SAD WITH THREE DOTS ABOVE
        0x069F, // ARABIC LETTER TAH WITH THREE DOTS ABOVE
        0x06A0, // ARABIC LETTER AIN WITH THREE DOTS ABOVE
        0x06A1, // ARABIC LETTER DOTLESS FEH
        0x06A2, // ARABIC LETTER FEH WITH DOT MOVED BELOW
        0x06A3, // ARABIC LETTER FEH WITH DOT BELOW
        0x06A4, // ARABIC LETTER VEH
        0x06A5, // ARABIC LETTER FEH WITH THREE DOTS BELOW
        0x06A6, // ARABIC LETTER PEHEH
        0x06A7, // ARABIC LETTER QAF WITH DOT ABOVE
        0x06A8, // ARABIC LETTER QAF WITH THREE DOTS ABOVE
        0x06A9, // ARABIC LETTER KEHEH
        0x06AA, // ARABIC LETTER SWASH KAF
        0x06AB, // ARABIC LETTER KAF WITH RING
        0x06AC, // ARABIC LETTER KAF WITH DOT ABOVE
        0x06AD, // ARABIC LETTER NG
        0x06AE, // ARABIC LETTER KAF WITH THREE DOTS BELOW
        0x06AF, // ARABIC LETTER GAF
        0x06B0, // ARABIC LETTER GAF WITH RING
        0x06B1, // ARABIC LETTER NGOEH
        0x06B2, // ARABIC LETTER FAF WITH TWO DOTS BELOW
        0x06B3, // ARABIC LETTER GUEH
        0x06B4, // ARABIC LETTER GAF WITH THREE DOTS ABOVE
        0x06B5, // ARABIC LETTER LAM WITH SMALL V
        0x06B6, // ARABIC LETTER LAM WITH DOT ABOVE
        0x06B7, // ARABIC LETTER LAM WITH THREE DOTS ABOVE
        0x06B8, // ARABIC LETTER LAM WITH THREE DOTS BELOW
        0x06B9, // ARABIC LETTER NOON WITH DOT BELOW
        0x06BA, // ARABIC LETTER NOON GHUNNA
        0x06BB, // ARABIC LETTER RNOON
        0x06BC, // ARABIC LETTER NOON WITH RING
        0x06BD, // ARABIC LETTER NOON WITH THREE DOTS ABOVE
        0x06BE, // ARABIC LETTER HEH DOACHASHMEE
        0x06BF, // ARABIC LETTER TCHEH WITH DOT ABOVE
        0x06C0, // ARABIC LETTER HEH WITH YEH ABOVE
        0x06C1, // ARABIC LETTER HEH GOAL
        0x06C2, // ARABIC LETTER HEH GOAL WITH HAMZA ABOVE
        0x06C3, // ARABIC LETTER TEH MARBUTA GOAL
        0x06C4, // ARABIC LETTER WAW WITH RING
        0x06C5, // ARABIC LETTER KIRGHIZ OE
        0x06C6, // ARABIC LETTER OE
        0x06C7, // ARABIC LETTER U
        0x06C8, // ARABIC LETTER YU
        0x06C9, // ARABIC LETTER KIRGHIZ YU
        0x06CA, // ARABIC LETTER WAW WITH TWO DOTS ABOVE
        0x06CB, // ARABIC LETTER VE
        0x06CC, // ARABIC LETTER FARSI YEH
        0x06CD, // ARABIC LETTER YEH WITH TAIL
        0x06CE, // ARABIC LETTER YEH WITH SMALL V
        0x06CF, // ARABIC LETTER WAW WITH DOT ABOVE
        0x06D0, // ARABIC LETTER E
        0x06D1, // ARABIC LETTER YEH WITH THREE DOTS BELOW
        0x06D2, // ARABIC LETTER YEH BARREE
        0x06D3, // ARABIC LETTER YEH BARREE WITH HAMZA ABOVE
        0x06D5, // ARABIC LETTER AE
        0x06EE, // ARABIC LETTER DAL WITH INVERTED V
        0x06EF, // ARABIC LETTER REH WITH INVERTED V
        0x06FA, // ARABIC LETTER SHEEN WITH DOT BELOW
        0x06FB, // ARABIC LETTER DAD WITH DOT BELOW
        0x06FC, // ARABIC LETTER GHAIN WITH DOT BELOW
        0x06FF, // ARABIC LETTER HEH WITH INVERTED V
        0x0750, // ARABIC LETTER BEH WITH THREE DOTS HORIZONTALLY BELOW
        0x0751, // ARABIC LETTER BEH WITH DOT BELOW AND THREE DOTS ABOVE
        0x0752, // ARABIC LETTER BEH WITH THREE DOTS POINTING UPWARDS BELOW
        0x0753, // ARABIC LETTER BEH WITH THREE DOTS POINTING UPWARDS BELOW AND TWO DOTS ABOVE
        0x0754, // ARABIC LETTER BEH WITH TWO DOTS BELOW AND DOT ABOVE
        0x0755, // ARABIC LETTER BEH WITH INVERTED SMALL V BELOW
        0x0756, // ARABIC LETTER BEH WITH SMALL V
        0x0757, // ARABIC LETTER HAH WITH TWO DOTS ABOVE
        0x0758, // ARABIC LETTER HAH WITH THREE DOTS POINTING UPWARDS BELOW
        0x0759, // ARABIC LETTER DAR WITH TWO DOTS VERTICALLY BELOW AND SMALL TAH
        0x075A, // ARABIC LETTER DAL WITH INVERTED SMALL V BELOW
        0x075B, // ARABIC LETTER REH WITH STROKE
        0x075C, // ARABIC LETTER SEEN WITH FOUR DOUTS ABOVE
        0x075D, // ARABIC LETTER AIN WITH TWO DOTS ABOVE
        0x0754, // ARABIC LETTER AIN WITH THREE DOTS POINTING DOWNWARDS ABOVE
        0x0760, // ARABIC LETTER FEH WITH TWO DOTS BELOW
        0x0761, // ARABIC LETTER FEH WITH THREE DOTS POINTING UPWARDS BELOW
        0x0762, // ARABIC LETTER KEHEH WITH DOT ABOVE
        0x0763, // ARABIC LETTER KEHEH WITH THREE DOTS ABOVE
        0x0764, // ARABIC LETTER KEHEH WITH THREE DOTS POINTING UPWARDS BELOW
        0x0765, // ARABIC LETTER MEEM WITH DOT ABOVE
        0x0766, // ARABIC LETTER MEEM WITH DOT BELOW
        0x0767, // ARABIC LETTER NOON WITH TWO DOTS BELOW
        0x0768, // ARABIC LETTER NOON WITH SMALL TAH
        0x0769, // ARABIC LETTER NOON WITH SMALL V
        0x076A, // ARABIC LETTER LAM WITH BAR
        0x076B, // ARABIC LETTER REH WITH TWO DOTS VERTICALLY ABOVE
        0x076C, // ARABIC LETTER REH WITH HAMZA ABOVE
        0x076D, // ARABIC LETTER SEEN WITH TWO DOTS VERTICALLY ABOVE
        0x076E, // ARABIC LETTER HAH WITH SMALL ARABIC LETTER TAH BELOW
        0x076F, // ARABIC LETTER HAH WITH SMALL ARABIC LETTER TAH AND TWO DOTS
        0x0770, // ARABIC LETTER SEEN WITH SMALL ARABIC LETTER TAH AND TWO DOTS
        0x0771, // ARABIC LETTER REH WITH SMALL ARABIC LETTER TAH AND TWO DOTS
        0x0772, // ARABIC LETTER HAH WITH SMALL ARABIC LETTER TAH ABOVE
        0x0773, // ARABIC LETTER ALEF WITH EXTENDED ARABIC-INDIC DIGIT TWO ABOVE
        0x0774, // ARABIC LETTER ALEF WITH EXTENDED ARABIC-INDIC DIGIT THREE ABOVE
        0x0775, // ARABIC LETTER FARSI YEH WITH EXTENDED ARABIC-INDIC DIGIT TWO ABOVE
        0x0776, // ARABIC LETTER FARSI YEH WITH EXTENDED ARABIC-INDIC THREE ABOVE
        0x0777, // ARABIC LETTER FARSI YEH WITH EXTENDED ARABIC-INDIC DIGIT FOUR BELOW
        0x0778, // ARABIC LETTER WAW WITH EXTENDED ARABIC-INDIC DIGIT TWO ABOVE
        0x0779, // ARABIC LETTER WAW WITH EXTENDED ARABIC-INDIC DIGIT THREE ABOVE
        0x077A, // ARABIC LETTER YEH BARREE WITH EXTENDED ARABIC-INDIC DIGIT TWO ABOVE
        0x077B, // ARABIC LETTER YEH BARREE WITH EXTENDED ARABIC-INDIC DIGIT THREE ABOVE
        0x077C, // ARABIC LETTER HAH WITH WITH EXTENDED ARABIC-INDIC DIGIT FOUR BELOW
        0x077D, // ARABIC LETTER SEEN WITH EXTENDED ARABIC-INDIC DIGIT FOUR ABOVE
        0x077E, // ARABIC LETTER SEEN WITH INVERTED V
        0x077F, // ARABIC LETTER KAF WITH TWO DOTS ABOVE
        0x08A0, // ARABIC LETTER BEH WITH SMALL V BELOW
        0x08A1, // ARABIC LETTER BEH WITH HAMZA ABOVE
        0x08A2, // ARABIC LETTER JEEM WITH TWO DOTS ABOVE
        0x08A3, // ARABIC LETTER TAH WITH TWO DOTS ABOVE
        0x08A4, // ARABIC LETTER FEH WITH DOT BELOW AND THREE DOTS ABOVE
        0x08A5, // ARABIC LETTER QAF WITH DOT BELOW
        0x08A6, // ARABIC LETTER LAM WITH DOUBLE BAR
        0x08A7, // ARABIC LETTER MEEM WITH THREE DOTS ABOVE
        0x08A8, // ARABIC LETTER YEH WITH TWO DOTS BELOW AND HAMZA ABOVE
        0x08A9, // ARABIC LETTER YEH WITH TWO DOTS BELOW AND DOT ABOVE
        0x08AA, // ARABIC LETTER REH WITH LOOP
        0x08AB, // ARABIC LETTER WAW WITH DOT WITHIN
        0x08AC, // ARABIC LETTER ROHINGYA YEH
        0x08AD, // ARABIC LETTER LOW ALEF
        0x08AE, // ARABIC LETTER DAL WITH THREE DOTS BELOW
        0x08AF, // ARABIC LETTER SAD WITH THREE DOTS BELOW
        0x08B0, // ARABIC LETTER GAF WITH INVERTED STROKE
        0x08B1, // ARABIC LETTER STRAIGHT WAW
        0x08B2, // ARABIC LETTER ZAIN WITH INVERTED V ABOVE
        0x08B3, // ARABIC LETTER AIN WITH THREE DOTS BELOW
        0x08B4, // ARABIC LETTER KAF WITH DOT BELOW
        0x08B6, // ARABIC LETTER BEH WITH SMALL MEEM ABOVE
        0x08B7, // ARABIC LETTER PEH WITH SMALL MEEM ABOVE
        0x08B8, // ARABIC LETTER TEH WITH SMALL TEH ABOVE
        0x08B9, // ARABIC LETTER REH WITH SMALL NOON ABOVE
        0x08BA, // ARABIC LETTER YEH WITH TWO DOTS BELOW AND SMALL NOON ABOVE
        0x08BB, // ARABIC LETTER AFRICAN FEH
        0x08BC, // ARABIC LETTER AFRICAN QAF
        0x08BD  // ARABIC LETTER AFRICAN NOON
    ]
    
    static let diacritics: Set = [
        0x0610, // ARABIC SIGN SALLALLAHOU ALAYHE WASSALLAM
        0x0611, // ARABIC SIGN ALAYHE ASSALLAM
        0x0612, // ARABIC SIGN RAHMATULLAH ALAYHE
        0x0613, // ARABIC SIGN RADI ALLAHOU ANHU
        0x0614, // ARABIC SIGN TAKHALLUS
        0x0615, // ARABIC SMALL HIGH TAH
        0x0616, // ARABIC SMALL HIGH LIGATURE ALEF WITH LAM WITH YEH
        0x0617, // ARABIC SMALL HIGH ZAIN
        0x0618, // ARABIC SMALL FATHA
        0x0619, // ARABIC SMALL DAMMA
        0x061A, // ARABIC SMALL KASRA
        0x0640, // ARABIC TATWEEL
        0x064B, // ARABIC FATHATAN
        0x064C, // ARABIC DAMMATAN
        0x064D, // ARABIC KASRATAN
        0x064E, // ARABIC FATHA
        0x064F, // ARABIC DAMMA
        0x0650, // ARABIC KASRA
        0x0651, // ARABIC SHADDA
        0x0652, // ARABIC SUKUN
        0x0653, // ARABIC MADDAH ABOVE
        0x0654, // ARABIC HAMZA ABOVE
        0x0655, // ARABIC HAMZA BELOW
        0x0656, // ARABIC SUBSCRIPT ALEF
        0x0657, // ARABIC INVERTED DAMMA
        0x0658, // ARABIC MARK NOON GHUNNA
        0x0659, // ARABIC ZWARAKAY
        0x065A, // ARABIC VOWEL SIGN SMALL V ABOVE
        0x065B, // ARABIC VOWEL SIGN INVERTED SMALL V ABOVE
        0x065C, // ARABIC VOWEL SIGN DOT BELOW
        0x065D, // ARABIC REVERSED DAMMA
        0x065E, // ARABIC FATHA WITH TWO DOTS
        0x065F, // ARABIC WAVY HAMZA BELOW
        0x0670, // ARABIC LETTER SUPERSCRIPT ALEF
        0x08D3, // ARABIC SMALL LOW WAW
        0x08D4, // ARABIC SMALL HIGH WORD AR-RUB
        0x08D5, // ARABIC SMALL HIGH SAD
        0x08D6, // ARABIC SMALL HIGH AIN
        0x08D7, // ARABIC SMALL HIGH QAF
        0x08D8, // ARABIC SMALL HIGH NOON WITH KASRA
        0x08D9, // ARABIC SMALL LOW NOON WITH KASRA
        0x08DA, // ARABIC SMALL HIGH WORD ATH-THALATHA
        0x08DB, // ARABIC SMALL HIGH WORD AS-SAJDA
        0x0BDC, // ARABIC SMALL HIGH WORD AN-NISF
        0x08DD, // ARABIC SMALL HIGH WORD SAKTA
        0x08DE, // ARABIC SMALL HIGH WORD QIF
        0x08DF, // ARABIC SMALL HIGH WORD WAQFA
        0x08E0, // ARABIC SMALL HIGH FOOTNOTE MARKER
        0x08E1, // ARABIC SMALL HIGH SIGN SAFHA
        0x08E3, // ARABIC TURNED DAMMA BELOW
        0x08E4, // ARABIC CURLY FATHA
        0x08E5, // ARABIC CURLY DAMMA
        0x08E6, // ARABIC CURLY KASRA
        0x08E7, // ARABIC CURLY FATHATAN
        0x08E8, // ARABIC CURLY DAMMATAN
        0x08E9, // ARABIC CURLY KASRATAN
        0x08EA, // ARABIC TONE ONE DOT ABOVE
        0x08EB, // ARABIC TONE TWO DOTS ABOVE
        0x08EC, // ARABIC TONE LOOP ABOVE
        0x08ED, // ARABIC TONE ONE DOT BELOW
        0x08EE, // ARABIC TONE TWO DOTS BELOW
        0x08EF, // ARABIC TONE LOOP BELOW
        0x08F0, // ARABIC OPEN FATHATAN
        0x08F1, // ARABIC OPEN DAMMATAN
        0x08F2, // ARABIC OPEN KASRATAN
        0x08F3, // ARABIC SMALL HIGH WAW
        0x08F4, // ARABIC FATHA WITH RING
        0x08F5, // ARABIC FATHA WITH DOT ABOVE
        0x08F6, // ARABIC KASRA WITH DOT BELOW
        0x08F7, // ARABIC LEFT ARROWHEAD ABOVE
        0x08F8, // ARABIC RIGHT ARROWHEAD ABOVE
        0x08F9, // ARABIC LEFT ARROWHEAD BELOW
        0x08FA, // ARABIC RIGHT ARROWHEAD BELOW
        0x08FB, // ARABIC DOUBLE RIGHT ARROWHEAD ABOVE
        0x08FC, // ARABIC DOUBLE RIGHT ARROWHEAD ABOVE WITH DOT
        0x08FD, // ARABIC RIGHT ARROWHEAD ABOVE WITH DOT
        0x08FE, // ARABIC DAMMA WITH DOT
        0x08FF  // ARABIC MARK SIDEWAYS NOON GHUNNA
    ]
    
    static let decompositions = [
        0x0622: [0x0627, 0x0653], // ARABIC LETTER ALEF WITH MADDA ABOVE
        0x0623: [0x0627, 0x0654], // ARABIC LETTER ALEF WITH HAMZA ABOVE
        0x0624: [0x0648, 0x0654], // ARABIC LETTER WAW WITH HAMZA ABOVE
        0x0625: [0x0627, 0x0655], // ARABIC LETTER ALEF WITH HAMZA BELOW
        0x0626: [0x064A, 0x0654], // ARABIC LETTER YEH WITH HAMZA ABOVE
        0x06C0: [0x06D5, 0x0654], // ARABIC LETTER HEH WITH YEH ABOVE
        0x06C2: [0x06C1, 0x0654], // ARABIC LETTER HEH GOAL WITH HAMZA ABOVE
        0x06D3: [0x06D2, 0x0654], // ARABIC LETTER YEH BARREE WITH HAMZA ABOVE
    ]
    
    static let essentialDiacritics: Set = [
        0x0653, // ARABIC MADDAH ABOVE
        0x0670, // ARABIC LETTER SUPERSCRIPT ALEF
        0x0654, // ARABIC HAMZA ABOVE
    ]
    
    public class func getCharacter(_ scalar: UnicodeScalar, inContextualForm form: ContextualForm) throws -> Character {
        let scalarValue = scalar.value
        var result: UInt32
        switch scalarValue {
        // ARABIC LETTER ALEF WASLA
        case 0x0671:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB50
            case ContextualForm.Final:
                result = 0xfb51
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER BEEH
        case 0x067B:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB52
            case ContextualForm.Final:
                result = 0xFB53
            case ContextualForm.Initial:
                result = 0xFB54
            case ContextualForm.Medial:
                result = 0xFB55
            }
        // ARABIC LETTER PEH
        case 0x067E:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB56
            case ContextualForm.Final:
                result = 0xFB57
            case ContextualForm.Initial:
                result = 0xFB58
            case ContextualForm.Medial:
                result = 0xFB59
            }
        // ARABIC LETTER BEHEH
        case 0x0680:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB5A
            case ContextualForm.Final:
                result = 0xFB5B
            case ContextualForm.Initial:
                result = 0xFB5C
            case ContextualForm.Medial:
                result = 0xFB5D
            }
        // ARABIC LETTER TTEHEH
        case 0x067A:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB5E
            case ContextualForm.Final:
                result = 0xFB5F
            case ContextualForm.Initial:
                result = 0xFB60
            case ContextualForm.Medial:
                result = 0xFB61
            }
        // ARABIC LETTER TEHEH
        case 0x067F:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB62
            case ContextualForm.Final:
                result = 0xFB63
            case ContextualForm.Initial:
                result = 0xFB64
            case ContextualForm.Medial:
                result = 0xFB65
            }
        // ARABIC LETTER TTEH
        case 0x0679:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB66
            case ContextualForm.Final:
                result = 0xFB67
            case ContextualForm.Initial:
                result = 0xFB68
            case ContextualForm.Medial:
                result = 0xFB69
            }
        // ARABIC LETTER VEH
        case 0x06A4:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB6A
            case ContextualForm.Final:
                result = 0xFB6B
            case ContextualForm.Initial:
                result = 0xFB6C
            case ContextualForm.Medial:
                result = 0xFB6D
            }
        // ARABIC LETTER PEHEH
        case 0x06A6:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB6E
            case ContextualForm.Final:
                result = 0xFB6F
            case ContextualForm.Initial:
                result = 0xFB70
            case ContextualForm.Medial:
                result = 0xFB71
            }
        // ARABIC LETTER DYEH
        case 0x0684:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB72
            case ContextualForm.Final:
                result = 0xFB73
            case ContextualForm.Initial:
                result = 0xFB74
            case ContextualForm.Medial:
                result = 0xFB75
            }
        // ARABIC LETTER NYEH
        case 0x0683:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB76
            case ContextualForm.Final:
                result = 0xFB77
            case ContextualForm.Initial:
                result = 0xFB78
            case ContextualForm.Medial:
                result = 0xFB79
            }
        // ARABIC LETTER TCHEH
        case 0x0686:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB7A
            case ContextualForm.Final:
                result = 0xFB7B
            case ContextualForm.Initial:
                result = 0xFB7C
            case ContextualForm.Medial:
                result = 0xFB7E
            }
        // ARABIC LETTER TCHEHEH
        case 0x0687:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB7E
            case ContextualForm.Final:
                result = 0xFB7F
            case ContextualForm.Initial:
                result = 0xFB80
            case ContextualForm.Medial:
                result = 0xFB81
            }
        // ARABIC LETTER DDAHAL
        case 0x068D:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB82
            case ContextualForm.Final:
                result = 0xFB83
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER DAHAL
        case 0x068C:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB84
            case ContextualForm.Final:
                result = 0xFB85
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER DUL
        case 0x068E:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB86
            case ContextualForm.Final:
                result = 0xFB87
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER DDAL
        case 0x0688:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB88
            case ContextualForm.Final:
                result = 0xFB89
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER JEH
        case 0x0698:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB8A
            case ContextualForm.Final:
                result = 0xFB8B
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER RREH
        case 0x0691:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB8C
            case ContextualForm.Final:
                result = 0xFB8D
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER KEHEH
        case 0x06A9:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB8E
            case ContextualForm.Final:
                result = 0xFB8F
            case ContextualForm.Initial:
                result = 0xFB90
            case ContextualForm.Medial:
                result = 0xFB91
            }
        // ARABIC LETTER GAF
        case 0x06AF:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB92
            case ContextualForm.Final:
                result = 0xFB93
            case ContextualForm.Initial:
                result = 0xFB94
            case ContextualForm.Medial:
                result = 0xFB95
            }
        // ARABIC LETTER GUEH
        case 0x06B3:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB96
            case ContextualForm.Final:
                result = 0xFB97
            case ContextualForm.Initial:
                result = 0xFB98
            case ContextualForm.Medial:
                result = 0xFB99
            }
        // ARABIC LETTER NGOEH
        case 0x06B1:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB9A
            case ContextualForm.Final:
                result = 0xFB9B
            case ContextualForm.Initial:
                result = 0xFB9C
            case ContextualForm.Medial:
                result = 0xFB9D
            }
        // ARABIC LETTER NOON GHUNNA
        case 0x06BA:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFB9E
            case ContextualForm.Final:
                result = 0xFB9F
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER RNOON
        case 0x06BB:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFBA0
            case ContextualForm.Final:
                result = 0xFBA1
            case ContextualForm.Initial:
                result = 0xFBA2
            case ContextualForm.Medial:
                result = 0xFBA3
            }
        // ARABIC LETTER HEH WITH YEH ABOVE
        case 0x06C0:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFBA4
            case ContextualForm.Final:
                result = 0xFBA5
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER HEH GOAL
        case 0x06C1:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFBA6
            case ContextualForm.Final:
                result = 0xFBA7
            case ContextualForm.Initial:
                result = 0xFBA8
            case ContextualForm.Medial:
                result = 0xFBA9
            }
        // ARABIC LETTER HEH DOACHASHMEE
        case 0x06BE:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFBAA
            case ContextualForm.Final:
                result = 0xFBAB
            case ContextualForm.Initial:
                result = 0xFBAC
            case ContextualForm.Medial:
                result = 0xFBAD
            }
        // ARABIC LETTER YEH BARREE
        case 0x06D2:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFBAE
            case ContextualForm.Final:
                result = 0xFBAF
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER YEH BARREE WITH HAMZA ABOVE
        case 0x06D3:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFBB0
            case ContextualForm.Final:
                result = 0xFBB1
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER NG
        case 0x06AD:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFBD3
            case ContextualForm.Final:
                result = 0xFBD4
            case ContextualForm.Initial:
                result = 0xFBD5
            case ContextualForm.Medial:
                result = 0xFBD6
            }
        // ARABIC LETTER U
        case 0x06C7:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFBD7
            case ContextualForm.Final:
                result = 0xFBD8
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER OE
        case 0x06C6:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFBD9
            case ContextualForm.Final:
                result = 0xFBDA
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER YU
        case 0x06C8:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFBDB
            case ContextualForm.Final:
                result = 0xFBDC
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER U WITH HAMZA ABOVE ISOLATED FORM
        case 0x0677:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFBDD
            case ContextualForm.Final:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER VE
        case 0x06CB:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFBDE
            case ContextualForm.Final:
                result = 0xFBDF
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER KIRGHIZ OE
        case 0x06C5:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFBE0
            case ContextualForm.Final:
                result = 0xFBE1
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER KIRGHIZ YU
        case 0x06C9:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFBE2
            case ContextualForm.Final:
                result = 0xFBE3
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER E
        case 0x06D0:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFBE4
            case ContextualForm.Final:
                result = 0xFBE5
            case ContextualForm.Initial:
                result = 0xFBE6
            case ContextualForm.Medial:
                result = 0xFBE7
            }
        // ARABIC LETTER UIGHUR KAZAKH KIRGHIZ ALEF MAKSURA
        // ARABIC LETTER ALEF MAKSURA
        // Duplicate Definitions in Arabic Presentation Forms-A and B
        case 0x0649:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEEF
            case ContextualForm.Final:
                result = 0xFEF0
            case ContextualForm.Initial:
                result = 0xFBE8
            case ContextualForm.Medial:
                result = 0xFBE9
            }
        // ARABIC FATHATAN
        case 0x064B:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE70
            case ContextualForm.Final:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC DAMMATAN
        case 0x064C:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE72
            case ContextualForm.Final:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC KASRATAN
        case 0x064D:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE74
            case ContextualForm.Final:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC FATHA
        case 0x064E:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE76
            case ContextualForm.Final:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                result = 0xFE77
            }
        // ARABIC DAMMA
        case 0x064F:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE78
            case ContextualForm.Final:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                result = 0xFE79
            }
        // ARABIC KASRA
        case 0x0650:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE7A
            case ContextualForm.Final:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                result = 0xFE7B
            }
        // ARABIC SHADDA
        case 0x0651:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE7C
            case ContextualForm.Final:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                result = 0xFE7D
            }
        // ARABIC SUKUN
        case 0x0652:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE7E
            case ContextualForm.Final:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                result = 0xFE7F
            }
        // ARABIC LETTER HAMZA
        case 0x0621:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE80
            case ContextualForm.Final:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER ALEF WITH MADDA ABOVE
        case 0x0622:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE81
            case ContextualForm.Final:
                result = 0xFE82
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER ALEF WITH HAMZA ABOVE
        case 0x0623:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE83
            case ContextualForm.Final:
                result = 0xFE84
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER WAW WITH HAMZA ABOVE
        case 0x0624:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE85
            case ContextualForm.Final:
                result = 0xFE86
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER ALEF WITH HAMZA BELOW
        case 0x0625:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE87
            case ContextualForm.Final:
                result = 0xFE88
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER YEH WITH HAMZA ABOVE
        case 0x0626:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE89
            case ContextualForm.Final:
                result = 0xFE8A
            case ContextualForm.Initial:
                result = 0xFE8B
            case ContextualForm.Medial:
                result = 0xFE8C
            }
        // ARABIC LETTER ALEF
        case 0x0627:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE8D
            case ContextualForm.Final:
                result = 0xFE8E
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER BEH
        case 0x0628:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE8F
            case ContextualForm.Final:
                result = 0xFE90
            case ContextualForm.Initial:
                result = 0xFE91
            case ContextualForm.Medial:
                result = 0xFE92
            }
        // ARABIC LETTER TEH MARBUTA
        case 0x0629:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE93
            case ContextualForm.Final:
                result = 0xFE94
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER TEH
        case 0x062A:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE95
            case ContextualForm.Final:
                result = 0xFE96
            case ContextualForm.Initial:
                result = 0xFE97
            case ContextualForm.Medial:
                result = 0xFE98
            }
        // ARABIC LETTER THEH
        case 0x062B:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE99
            case ContextualForm.Final:
                result = 0xFE9A
            case ContextualForm.Initial:
                result = 0xFE9B
            case ContextualForm.Medial:
                result = 0xFE9C
            }
        // ARABIC LETTER JEEM
        case 0x062C:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFE9D
            case ContextualForm.Final:
                result = 0xFE9E
            case ContextualForm.Initial:
                result = 0xFE9F
            case ContextualForm.Medial:
                result = 0xFEA0
            }
        // ARABIC LETTER HAH
        case 0x062D:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEA1
            case ContextualForm.Final:
                result = 0xFEA2
            case ContextualForm.Initial:
                result = 0xFEA3
            case ContextualForm.Medial:
                result = 0xFEA4
            }
        // ARABIC LETTER KHAH
        case 0x062E:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEA5
            case ContextualForm.Final:
                result = 0xFEA6
            case ContextualForm.Initial:
                result = 0xFEA7
            case ContextualForm.Medial:
                result = 0xFEA8
            }
        // ARABIC LETTER DAL
        case 0x062F:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEA9
            case ContextualForm.Final:
                result = 0xFEAA
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER THAL
        case 0x0630:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEAB
            case ContextualForm.Final:
                result = 0xFEAC
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER REH
        case 0x0631:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEAD
            case ContextualForm.Final:
                result = 0xFEAE
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER ZAIN
        case 0x0632:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEAF
            case ContextualForm.Final:
                result = 0xFEB0
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER SEEN
        case 0x0633:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEB1
            case ContextualForm.Final:
                result = 0xFEB2
            case ContextualForm.Initial:
                result = 0xFEB3
            case ContextualForm.Medial:
                result = 0xFEB4
            }
        // ARABIC LETTER SHEEN
        case 0x0634:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEB5
            case ContextualForm.Final:
                result = 0xFEB6
            case ContextualForm.Initial:
                result = 0xFEB7
            case ContextualForm.Medial:
                result = 0xFEB8
            }
        // ARABIC LETTER SAD
        case 0x0635:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEB9
            case ContextualForm.Final:
                result = 0xFEBA
            case ContextualForm.Initial:
                result = 0xFEBB
            case ContextualForm.Medial:
                result = 0xFEBC
            }
        // ARABIC LETTER DAD
        case 0x0636:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEBD
            case ContextualForm.Final:
                result = 0xFEBE
            case ContextualForm.Initial:
                result = 0xFEBF
            case ContextualForm.Medial:
                result = 0xFEC0
            }
        // ARABIC LETTER TAH
        case 0x0637:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEC1
            case ContextualForm.Final:
                result = 0xFEC2
            case ContextualForm.Initial:
                result = 0xFEC3
            case ContextualForm.Medial:
                result = 0xFEC4
            }
        // ARABIC LETTER ZAH
        case 0x0638:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEC5
            case ContextualForm.Final:
                result = 0xFEC6
            case ContextualForm.Initial:
                result = 0xFEC7
            case ContextualForm.Medial:
                result = 0xFEC8
            }
        // ARABIC LETTER AIN
        case 0x0639:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEC9
            case ContextualForm.Final:
                result = 0xFECA
            case ContextualForm.Initial:
                result = 0xFECB
            case ContextualForm.Medial:
                result = 0xFECC
            }
        // ARABIC LETTER GHAIN
        case 0x063A:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFECD
            case ContextualForm.Final:
                result = 0xFECE
            case ContextualForm.Initial:
                result = 0xFECF
            case ContextualForm.Medial:
                result = 0xFED0
            }
        // ARABIC LETTER FEH
        case 0x0641:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFED1
            case ContextualForm.Final:
                result = 0xFED2
            case ContextualForm.Initial:
                result = 0xFED3
            case ContextualForm.Medial:
                result = 0xFED4
            }
        // ARABIC LETTER QAF
        case 0x0642:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFED5
            case ContextualForm.Final:
                result = 0xFED6
            case ContextualForm.Initial:
                result = 0xFED7
            case ContextualForm.Medial:
                result = 0xFED8
            }
        // ARABIC LETTER KAF
        case 0x0643:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFED9
            case ContextualForm.Final:
                result = 0xFEDA
            case ContextualForm.Initial:
                result = 0xFEDB
            case ContextualForm.Medial:
                result = 0xFEDC
            }
        // ARABIC LETTER LAM
        case 0x0644:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEDD
            case ContextualForm.Final:
                result = 0xFEDE
            case ContextualForm.Initial:
                result = 0xFEDF
            case ContextualForm.Medial:
                result = 0xFEE0
            }
        // ARABIC LETTER MEEM
        case 0x0645:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEE1
            case ContextualForm.Final:
                result = 0xFEE2
            case ContextualForm.Initial:
                result = 0xFEE3
            case ContextualForm.Medial:
                result = 0xFEE4
            }
        // ARABIC LETTER NOON
        case 0x0646:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEE5
            case ContextualForm.Final:
                result = 0xFEE6
            case ContextualForm.Initial:
                result = 0xFEE7
            case ContextualForm.Medial:
                result = 0xFEE8
            }
        // ARABIC LETTER HEH
        case 0x0647:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEE9
            case ContextualForm.Final:
                result = 0xFEEA
            case ContextualForm.Initial:
                result = 0xFEEB
            case ContextualForm.Medial:
                result = 0xFEEC
            }
        // ARABIC LETTER WAW
        case 0x0648:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEED
            case ContextualForm.Final:
                result = 0xFEEE
            case ContextualForm.Initial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            case ContextualForm.Medial:
                throw NaqqashError.LetterDoesNotHaveRequestedForm
            }
        // ARABIC LETTER YEH
        case 0x064A:
            switch form {
            case ContextualForm.Isolated:
                result = 0xFEF1
            case ContextualForm.Final:
                result = 0xFEF2
            case ContextualForm.Initial:
                result = 0xFEF3
            case ContextualForm.Medial:
                result = 0xFEF4
            }
        default:
            throw NaqqashError.UnknownCharacter
        }
        return Character(UnicodeScalar(result)!)
    }
    
    public class func isForwardJoining(_ char: Character) -> Bool {
        if !isLetter(char) {
            return false
        }
        // special casing to fix errors in Unicode
        // Noon Ghunna has no medial form in San Francisco
        if char == "ں" && self.isNastaliqEnabled() {
            return true
        }
        // Farsi Yeh has no contextual forms in Unicode
        else if char == "ی" {
            return true
        } else {
            let scalars = self.removeDiacritics(String(char)).unicodeScalars
            let scalar = UnicodeScalar(scalars[scalars.startIndex].value)!
            let isolated = try? getCharacter(scalar, inContextualForm: ContextualForm.Isolated)
            let final = try? getCharacter(scalar, inContextualForm: ContextualForm.Final)
            let initial = try? getCharacter(scalar, inContextualForm: ContextualForm.Initial)
            let medial = try? getCharacter(scalar, inContextualForm: ContextualForm.Medial)
            return (isolated != nil && final != nil && initial != nil && medial != nil)
        }
    }
    
    public class func isLetter(_ char: Character) -> Bool {
        let scalars = self.removeDiacritics(String(char)).unicodeScalars
        if scalars.count == 0 { return false }
        let scalar = UnicodeScalar(scalars[scalars.startIndex].value)!
        return isLetter(scalar)
    }
    
    public class func isLetter(_ scalar: UnicodeScalar) -> Bool {
        return self.letters.contains(Int(scalar.value))
    }
    
    public class func isDiacritic(_ scalar: UnicodeScalar) -> Bool {
        return self.diacritics.contains(Int(scalar.value))
    }
    
    public class func isEssentialDiacritic(_ scalar: UnicodeScalar) -> Bool {
        return self.essentialDiacritics.contains(Int(scalar.value))
    }
    
    public class func isNonEssentialDiacritic(_ scalar: UnicodeScalar) -> Bool {
        return self.diacritics.contains(Int(scalar.value)) && !self.essentialDiacritics.contains(Int(scalar.value))
    }
    
    public class func removeDiacritics(_ string: String, ofType type: DiacriticType = DiacriticType.All) -> String {
        let scalars = string.unicodeScalars
        var resultScalars: [UnicodeScalar] = []
        var result = ""
        for scalar in scalars {
            var keep = true
            switch type {
            case DiacriticType.All:
                if isDiacritic(scalar) { keep = false }
            case DiacriticType.Essential:
                if isEssentialDiacritic(scalar) { keep = false }
            case DiacriticType.NonEssential:
                if isNonEssentialDiacritic(scalar) { keep = false }
            }
            if keep { resultScalars.append(scalar) }
        }
        result.unicodeScalars.append(contentsOf: resultScalars)
        return result
    }
    
    public class func isDecomposable(_ char: Character) -> Bool {
        let scalars = self.removeDiacritics(String(char)).unicodeScalars
        for s in scalars {
            if self.isDecomposable(s) { return true }
        }
        return false
    }
    
    public class func isDecomposable(_ scalar: UnicodeScalar) -> Bool {
        return self.decompositions[Int(scalar.value)] != nil
    }

    public class func decompose(_ char: Character) -> Character {
        
        // base case
        let scalars = char.unicodeScalars
        let decomposedScalars = self.decompose(char.unicodeScalars)
        if scalars.count == decomposedScalars.count { return char }
        
        // recurse
        else {
            var s = ""
            s.unicodeScalars.append(contentsOf: decomposedScalars)
            return self.decompose(s.first!)
        }
    }
    
    public class func decompose(_ scalars: Character.UnicodeScalarView) -> [UnicodeScalar] {
        var result: [UnicodeScalar] = []
        for scalar in scalars {
            result.append(contentsOf: self.decompose(scalar))
        }
        return result
    }
    
    public class func decompose(_ scalar: UnicodeScalar) -> [UnicodeScalar] {
        var result: [UnicodeScalar] = []
        let decomposition = self.decompositions[Int(scalar.value)]
        if decomposition == nil { result.append(scalar) }
        else {
            for d in decomposition! {
                let ds = UnicodeScalar(d)!
                result.append(ds)
            }
        }
        return result
    }
    
    public class func addTatweelTo(_ string: String, toDisplay form: ContextualForm) -> String {
        let tatweel = "ـ"
        var suffix = ""
        if self.isForwardJoining(string.last!) {
            suffix = tatweel
        }
        switch form {
        case ContextualForm.Isolated:
            return string
        case ContextualForm.Initial:
            return string + suffix
        case ContextualForm.Medial:
            return tatweel + string + suffix
        case ContextualForm.Final:
            return tatweel + string
        }
    }
    
    public class func isUrduPreferredLanguage() -> Bool {
        let preferredLanguages = NSLocale.preferredLanguages
        for lang in preferredLanguages {
            if lang.contains("ur") {
                return true
            }
        }
        return false
    }
    
    public class func isNastaliqEnabled() -> Bool {
        return isUrduPreferredLanguage()
    }
}
