module SAFECHARITY-SYNTAX
    imports INT-SYNTAX
    imports BOOL-SYNTAX

    syntax Contract ::= "SafeCharity"
    | "constructor"
    | "deposit" Int
    | "withdraw" Int

endmodule

module SAFECHARITY
    imports SAFECHARITY-SYNTAX
    imports INT
    imports BOOL

    syntax Int ::= "balance" [function]
    syntax Address ::= "owner" [function]

    configuration
        <k> $PGM:Contract </k>
        <owner> 0 </owner>
        <balance> 0 </balance>
        <sender> 0 </sender>

    // Constructor
    rule <k> constructor => .K </k>
         <sender> MSG_SENDER </sender>
         <owner> _ => MSG_SENDER </owner>

    // Deposit Function
    rule <k> deposit AMOUNT:Int => .K </k>
         <balance> BAL => BAL +Int AMOUNT </balance>
    requires AMOUNT >Int 0

    // Withdraw Function
    rule <k> withdraw AMOUNT:Int => .K </k>
         <balance> BAL => BAL -Int AMOUNT </balance>
         <owner> OWNER </owner>
         <sender> MSG_SENDER </sender>
    requires BAL >=Int AMOUNT
    andBool AMOUNT >Int 0
    andBool MSG_SENDER ==Int OWNER

endmodule
