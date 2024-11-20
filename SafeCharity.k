module SAFECHARITY
    imports INT
    imports BOOL

    syntax Contract ::= "SafeCharity"
    syntax Int ::= "balance" [function]
    syntax Address ::= "owner" [function]

    configuration
        <k> . </k>
        <owner> 0 </owner>
        <balance> 0 </balance>

    // Constructor
    syntax Contract ::= "constructor" ()
    rule <k> constructor() => . </k>
         <owner> _ => msg.sender </owner>

    // Deposit Function
    syntax Contract ::= "deposit" (Int)
    rule <k> deposit(AMOUNT:Int) => . </k>
         <balance> BAL => BAL +Int AMOUNT </balance>

    // Withdraw Function
    syntax Contract ::= "withdraw" (Int)
    rule <k> withdraw(AMOUNT:Int) => . </k>
         <balance> BAL => BAL -Int AMOUNT </balance>
         requires BAL >=Int AMOUNT

endmodule
