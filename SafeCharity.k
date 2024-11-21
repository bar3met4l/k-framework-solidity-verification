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
        <sender> 0 </sender>

    // Constructor
    syntax Contract ::= "constructor" ()
    rule <k> constructor() => . </k>
         <sender> MSG_SENDER </sender>
         <owner> _ => MSG_SENDER </owner>

    // Deposit Function
    syntax Contract ::= "deposit" (Int)
    rule <k> deposit(AMOUNT:Int) => . </k>
         <balance> BAL => BAL +Int AMOUNT </balance>
    requires AMOUNT >Int 0

    // Withdraw Function
    syntax Contract ::= "withdraw" (Int)
    rule <k> withdraw(AMOUNT:Int) => . </k>
         <balance> BAL => BAL -Int AMOUNT </balance>
         <owner> OWNER </owner>
         <sender> MSG_SENDER </sender>
    requires BAL >=Int AMOUNT
    andBool AMOUNT >Int 0
    andBool MSG_SENDER ==Int OWNER

endmodule
