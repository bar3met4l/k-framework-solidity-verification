requires "safecharity.k"

module SAFECHARITY-SPEC
    imports SAFECHARITY

    claim [deposit-increases-balance]:
        <k> deposit AMOUNT:Int => .K </k>
        <balance> BAL => BAL +Int AMOUNT </balance>
        <owner> OWNER => OWNER </owner>
        <sender> SENDER => SENDER </sender>
    requires AMOUNT >Int 0

    claim [withdraw-success]:
        <k> withdraw AMOUNT:Int => .K </k>
        <balance> BAL => BAL -Int AMOUNT </balance>
        <owner> OWNER </owner>
        <sender> OWNER </sender>
    requires AMOUNT >Int 0
    andBool BAL >=Int AMOUNT

    claim [withdraw-owner-only]:
        <k> withdraw AMOUNT:Int => withdraw AMOUNT:Int </k>
        <balance> BAL => BAL </balance>
        <owner> OWNER </owner>
        <sender> SENDER </sender>
    requires AMOUNT >Int 0
    andBool BAL >=Int AMOUNT
    andBool SENDER =/=Int OWNER

    claim [constructor-sets-owner]:
        <k> constructor => .K </k>
        <owner> 0 => MSG_SENDER </owner>
        <sender> MSG_SENDER </sender>

    claim [balance-stays-positive]:
        <k> withdraw AMOUNT:Int => .K </k>
        <balance> BAL => (BAL -Int AMOUNT) </balance>
        <owner> OWNER </owner>
        <sender> OWNER </sender>
    requires AMOUNT >Int 0
    andBool BAL >=Int AMOUNT
    ensures (BAL -Int AMOUNT) >=Int 0

endmodule
