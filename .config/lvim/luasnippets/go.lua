return {
    s({ trig = "ife", name = "If Err Wrapped", dscr = "Insert a if err not nil statement with statement" }, {
        t("if err != nil {"),
        t({ "", "\t" }),
        i(1, "statement"),
        t({ "", "}" })
    }),
}
