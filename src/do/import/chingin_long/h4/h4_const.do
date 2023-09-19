/*----------------------------------------------------------------------
    <README>
    This do-file is generated from the python program provided by [URL].
        _const.do:    Import fixed-length data
        _var.do:      Put variable labels
        _val.do:      Put value labels
        _validate.do: Check if the data seems correctly imported
        _rename.do: Rename variable names to append several data

    WARNING:
        1. The generated do-files do not necessarily correct.
           If you find something wrong regarding the program or
           the resulting do-file(s), please send email to [Email Address].

        2. All variables are assumed to be numeric, if there is a variable
           with non-missing string value, modify _const.do and _val.do

        3. _validate.do checks if each variable has the values that it is
           supposed to have. (Categorical variables only)

        4. _rename.do is generated by finding a variable with a similar
           variable description and, if any, a similar variable name from
           the base data. So it is quite likely that some variables are
           renamed incorrectly. Please check and modify _rename.do.

        5. In addition, there is no file to make variable values consistent
           across different data.


    Source: 平成01年〜04年_賃金福祉基本統計調査_符号表(個人票).xlsx
    Date: 2019/03/12 16:13:38
----------------------------------------------------------------------*/


#delimit ;
    quietly infix
        str var1 1-4
        str var2 5-6
        str var3 7-9
        str var4 10-11
        str var5 12-17
        str var6 18-19
        str var7 20-21
        str var8 22-24
        str var9 25-30
        str var10 31-34
        str var11 39-41
        str var12 42-42
        str var13 43-43
        str var14 44-46
        str var15 47-47
        str var16 48-48
        str var17 49-49
        str var18 50-52
        str var19 53-54
        str var20 55-59
        str var21 60-60
        str var22 61-61
        str var23 62-66
        str var24 67-71
        str var25 73-73
        str var26 74-75
        str var27 76-76
        str var28 79-79
        str var29 80-80
        str var30 81-81
        str var31 82-82
        str var32 83-83
        str var33 84-85
        str var34 86-87
        str var35 88-90
        str var36 91-91
        str var37 92-93
        str var38 94-96
        str var39 97-99
        str var40 100-104
        str var41 105-108
        str var42 109-113
        str var43 114-116
        str var44 117-119
        str var45 120-122
        str var46 123-128
    using "${path_data}/WageCensus/raw/調査票情報/h01-29_k-chin/h04_k-chin.txt";
#delimit cr
