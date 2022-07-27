<#-- format specific processing -->

    <#function isBalanceLine>
        <#return cbank.custpage_eft_custrecord_2663_balance_line >
    </#function>

    <#function getBankServiceClassCode>
        <#if isBalanceLine() >
            <#assign value = "200">
        <#else>
            <#assign value = "220">
        </#if>
        <#return value>
    </#function>
    
    <#function getEntityBankAccountType bankAccount>
        <#if bankAccount == "Savings" >
            <#assign value = "32">
        <#else>
            <#assign value = "22">
        </#if>
        <#return value>
    </#function>    
    
    <#function computeTotalDebitAmt batchPayments>
        <#if isBalanceLine() >
            <#assign value = 0>
            <#list batchPayments as payment>
                <#assign value = value + getAmount(payment)>
            </#list>
        <#else>
            <#assign value = 0>
        </#if>
        <#return value>    
    </#function>
    
    <#function computeTotalRecords recordCount>
        <#assign value = (recordCount / 10) >
        <#assign value = value?ceiling >    
        <#return value>
    </#function>
    
    <#function getBalanceLineTransactionCode ebanks>
        <#assign value = "">
        <#if isBalanceLine() >
            <#assign cbankAcctType = cbank.custpage_eft_custrecord_2663_bank_acct_type>
            <#if cbankAcctType == "Savings">
                <#assign value = "32">
            <#else>
                <#assign value = "22">
            </#if>            
            <#list ebanks as ebank>
                <#assign bankAccount = ebank.custrecord_2663_entity_bank_acct_type >
                <#assign ebankAcctType = getEntityBankAccountType(bankAccount) >
                <#if ebankAcctType == "22" || ebankAcctType == "32" >
                    <#if cbankAcctType == "Savings">
                        <#assign value = "37">
                    <#else>
                        <#assign value = "27">
                    </#if>
                    <#break>
                </#if>
            </#list>
        </#if>
        <#return value>    
    </#function>

    <#-- Divide Payments, Entities, and Entity Banks into two groups (CCD, PPD) -->
    <#assign ccdPaymentsStr = "">
    <#assign ccdEbanksStr = "">
	<#assign ccdEbankAccNumsStr = "">
    <#assign ccdEntitiesStr = "">
    <#assign ppdPaymentsStr = "">
    <#assign ppdEbanksStr = "">
    <#assign ppdEntitiesStr = "">    
	<#assign ppdEbankAccNumsStr = "">
    <#-- avoid sequence concatenation, use sequence strings instead -->
    <#list payments as payment>
        <#assign ebank = ebanks[payment_index]>    
		<#assign ebankAccNum = ebank_accountnums.list[payment_index]>
        <#assign entity = entities[payment_index]>
        <#if ebank.custrecord_2663_parent_vendor == payment.entity || ebank.custrecord_2663_parent_cust_ref == payment.entity>
            <#assign ccdPaymentsStr = ccdPaymentsStr + "payments[" + payment_index?c?string + "],">
            <#assign ccdEbanksStr = ccdEbanksStr + "ebanks[" + payment_index?c?string + "],">
            <#assign ccdEntitiesStr = ccdEntitiesStr + "entities[" + payment_index?c?string + "],">
			<#assign ccdEbankAccNumsStr = ccdEbankAccNumsStr + "ebank_accountnums.list[" + payment_index?c?string + "],">
        </#if>
        <#if ebank.custrecord_2663_parent_employee == payment.entity>
            <#assign ppdPaymentsStr = ppdPaymentsStr + "payments[" + payment_index?c?string + "],">
            <#assign ppdEbanksStr = ppdEbanksStr + "ebanks[" + payment_index?c?string + "],">
            <#assign ppdEntitiesStr = ppdEntitiesStr + "entities[" + payment_index?c?string + "],">
			<#assign ppdEbankAccNumsStr = ppdEbankAccNumsStr + "ebank_accountnums.list[" + payment_index?c?string + "],">
        </#if>    
    </#list>
    <#-- convert from strings to sequences -->
    <#assign ccdPayments = ("[" + removeEnding(ccdPaymentsStr, ",") + "]")?eval>
    <#assign ccdEbanks = ("[" + removeEnding(ccdEbanksStr, ",") + "]")?eval>
    <#assign ccdEntities = ("[" + removeEnding(ccdEntitiesStr, ",") + "]")?eval>
	<#assign ccdEbankAccNums = ("[" + removeEnding(ccdEbankAccNumsStr, ",") + "]")?eval>
    <#assign ppdPayments = ("[" + removeEnding(ppdPaymentsStr, ",") + "]")?eval>
    <#assign ppdEbanks = ("[" + removeEnding(ppdEbanksStr, ",") + "]")?eval>
    <#assign ppdEntities = ("[" + removeEnding(ppdEntitiesStr, ",") + "]")?eval>
	<#assign ppdEbankAccNums = ("[" + removeEnding(ppdEbankAccNumsStr, ",") + "]")?eval>

    <#function computeSequenceId>
        <#assign lastSeqId = getSequenceId(true)>
        
        <#-- store new sequence id to be returned later -->
        <#assign newSeqId = lastSeqId + 1>        

        <#-- do char code to character conversion -->
        <#assign seqId = (lastSeqId % 26) + 65>
        <#assign seqId = seqId?string?replace("65","A")>
        <#assign seqId = seqId?string?replace("66","B")>
        <#assign seqId = seqId?string?replace("67","C")>
        <#assign seqId = seqId?string?replace("68","D")>
        <#assign seqId = seqId?string?replace("69","E")>
        <#assign seqId = seqId?string?replace("70","F")>
        <#assign seqId = seqId?string?replace("71","G")>
        <#assign seqId = seqId?string?replace("72","H")>
        <#assign seqId = seqId?string?replace("73","I")>
        <#assign seqId = seqId?string?replace("74","J")>
        <#assign seqId = seqId?string?replace("75","K")>
        <#assign seqId = seqId?string?replace("76","L")>
        <#assign seqId = seqId?string?replace("77","M")>
        <#assign seqId = seqId?string?replace("78","N")>
        <#assign seqId = seqId?string?replace("79","O")>
        <#assign seqId = seqId?string?replace("80","P")>
        <#assign seqId = seqId?string?replace("81","Q")>
        <#assign seqId = seqId?string?replace("82","R")>
        <#assign seqId = seqId?string?replace("83","S")>
        <#assign seqId = seqId?string?replace("84","T")>
        <#assign seqId = seqId?string?replace("85","U")>
        <#assign seqId = seqId?string?replace("86","V")>
        <#assign seqId = seqId?string?replace("87","W")>
        <#assign seqId = seqId?string?replace("88","X")>
        <#assign seqId = seqId?string?replace("89","Y")>
        <#assign seqId = seqId?string?replace("90","Z")>
        <#return seqId>        
    </#function>
    
<#-- cached values -->
<#assign totalAmount = computeTotalAmount(payments)>    
    
<#-- template building -->
#OUTPUT START#
<#assign recordCount = 0>
<#assign batchCount = 0>
<#assign lineCount = 0>
<#assign batchLineNum = 0>
<#assign padBlocksString = "">
<#assign ccdBankNumberHash = 0>
<#assign ppdBankNumberHash = 0>
<#assign totalBankNumberHash = 0>
101 ${setLength(cbank.custpage_eft_custrecord_2663_bank_num, 9)}
${setLength(cbank.custpage_eft_custrecord_2663_bank_comp_id, 10)}
${setLength(pfa.custrecord_2663_file_creation_timestamp?date?string("yyMMdd"),6)}${setLength(pfa.custrecord_2663_file_creation_timestamp?time?string("HHmm"),4)}${setLength(computeSequenceId(),1)}094101${setLength(cbank.custpage_eft_custrecord_2663_bank_name, 23)}${setLength(cbank.custrecord_2663_legal_name, 23)}        
<#assign recordCount = recordCount + 1>
<#if (ccdPayments?size > 0) >
    <#assign batchCount = batchCount + 1>    
5${getBankServiceClassCode()}${setLength(cbank.custrecord_2663_legal_name,16)}                    
${setLength(cbank.custpage_eft_custrecord_2663_issuer_num,10)}CCDPayment   ${pfa.custrecord_2663_process_date?string("yyMMdd")}${pfa.custrecord_2663_process_date?string("yyMMdd")}   1${setLength(cbank.custpage_eft_custrecord_2663_processor_code,4)}${setLength(cbank.custpage_eft_custrecord_2663_bank_code,4)}${setPadding(batchCount,"left","0",7)}
    <#assign recordCount = recordCount + 1>
    <#list ccdPayments as payment>
        <#assign batchLineNum = batchLineNum + 1>
        <#assign ebank = ccdEbanks[payment_index]>    
		<#assign ebankAccNum = ccdEbankAccNums[payment_index]>
        <#assign entity = ccdEntities[payment_index]> 
        <#assign ccdBankNumberHash = ccdBankNumberHash + ebank.custrecord_2663_entity_bank_no?substring(0,8)?number>   
6${getEntityBankAccountType(ebank.custrecord_2663_entity_bank_acct_type)}${setLength(ebank.custrecord_2663_entity_bank_no,8)}${setLength(ebank.custrecord_2663_entity_country_check,1)}${setLength(ebankAccNum.custrecord_2663_entity_acct_no,17)}${setPadding(formatAmount(getAmount(payment)),"left","0",10)}${setLength(ebank.custrecord_2663_parent_vendor.internalId,15)}${setLength(buildEntityName(entity),22)}  0${setLength(cbank.custpage_eft_custrecord_2663_processor_code,4)}${setLength(cbank.custpage_eft_custrecord_2663_bank_code,4)}${setPadding(batchLineNum,"left","0",7)}
        <#assign recordCount = recordCount + 1>
    </#list>
    <#if isBalanceLine()>
    <#assign batchLineNum = batchLineNum + 1>
    <#assign ccdBankNumberHash = ccdBankNumberHash + cbank.custpage_eft_custrecord_2663_bank_num?substring(0,8)?number>
6${getBalanceLineTransactionCode(ccdEbanks)}${setLength(cbank.custpage_eft_custrecord_2663_bank_num,9)}${setLength(cbank.custpage_eft_custrecord_2663_acct_num,17)}${setPadding(formatAmount(computeTotalAmount(ccdPayments)),"left","0",10)}               ${setLength(cbank.custrecord_2663_print_company_name,22)}  0${setLength(cbank.custpage_eft_custrecord_2663_processor_code,4)}${setLength(cbank.custpage_eft_custrecord_2663_bank_code,4)}${setPadding(batchLineNum,"left","0",7)}
    <#assign recordCount = recordCount + 1>
    </#if>
    <#assign lineCount = lineCount + batchLineNum>
    <#assign totalBankNumberHash = totalBankNumberHash + ccdBankNumberHash>
8${getBankServiceClassCode()}${setPadding(batchLineNum,"left","0",6)}${setPadding(ccdBankNumberHash,"left","0",10)}${setPadding(formatAmount(computeTotalDebitAmt(ccdPayments)),"left","0",12)}${setPadding(formatAmount(computeTotalAmount(ccdPayments)),"left","0",12)}${setLength(cbank.custpage_eft_custrecord_2663_issuer_num,10)}                         ${setLength(cbank.custpage_eft_custrecord_2663_bank_num, 8)}${setPadding(batchCount,"left","0",7)}
<#assign recordCount = recordCount + 1>
</#if>
<#assign batchLineNum = 0>
<#if (ppdPayments?size > 0) >
    <#assign batchCount = batchCount + 1>    
5${getBankServiceClassCode()}${setLength(cbank.custrecord_2663_legal_name,16)}                    ${setLength(cbank.custpage_eft_custrecord_2663_issuer_num,10)}PPDPayment   ${pfa.custrecord_2663_process_date?string("yyMMdd")}${pfa.custrecord_2663_process_date?string("yyMMdd")}   1${setLength(cbank.custpage_eft_custrecord_2663_processor_code,4)}${setLength(cbank.custpage_eft_custrecord_2663_bank_code,4)}${setPadding(batchCount,"left","0",7)}
    <#assign recordCount = recordCount + 1>
    <#list ppdPayments as payment>
        <#assign batchLineNum = batchLineNum + 1>
        <#assign ebank = ppdEbanks[payment_index]>    
		<#assign ebankAccNum = ppdEbankAccNums[payment_index]>
        <#assign entity = ppdEntities[payment_index]>
        <#assign ppdBankNumberHash = ppdBankNumberHash + ebank.custrecord_2663_entity_bank_no?substring(0,8)?number>
6${getEntityBankAccountType(ebank.custrecord_2663_entity_bank_acct_type)}${setLength(ebank.custrecord_2663_entity_bank_no,8)}${setLength(ebank.custrecord_2663_entity_country_check,1)}${setLength(ebankAccNum.custrecord_2663_entity_acct_no,17)}${setPadding(formatAmount(getAmount(payment)),"left","0",10)}${setLength(ebank.custrecord_2663_parent_employee.internalId,15)}${setLength(buildEntityName(entity),22)}  0${setLength(cbank.custpage_eft_custrecord_2663_processor_code,4)}${setLength(cbank.custpage_eft_custrecord_2663_bank_code,4)}${setPadding(batchLineNum,"left","0",7)}    
        <#assign recordCount = recordCount + 1>
    </#list>
    <#if isBalanceLine()>
    <#assign batchLineNum = batchLineNum + 1>
    <#assign ppdBankNumberHash = ppdBankNumberHash + cbank.custpage_eft_custrecord_2663_bank_num?substring(0,8)?number>
6${getBalanceLineTransactionCode(ppdEbanks)}${setLength(cbank.custpage_eft_custrecord_2663_bank_num,9)}${setLength(cbank.custpage_eft_custrecord_2663_acct_num,17)}${setPadding(formatAmount(computeTotalAmount(ppdPayments)),"left","0",10)}               ${setLength(cbank.custrecord_2663_print_company_name,22)}  0${setLength(cbank.custpage_eft_custrecord_2663_processor_code,4)}${setLength(cbank.custpage_eft_custrecord_2663_bank_code,4)}${setPadding(batchLineNum,"left","0",7)}
    <#assign recordCount = recordCount + 1>
    </#if>
    <#assign lineCount = lineCount + batchLineNum>
    <#assign totalBankNumberHash = totalBankNumberHash + ppdBankNumberHash>
8${getBankServiceClassCode()}${setPadding(batchLineNum,"left","0",6)}${setPadding(ppdBankNumberHash,"left","0",10)}${setPadding(formatAmount(computeTotalDebitAmt(ppdPayments)),"left","0",12)}${setPadding(formatAmount(computeTotalAmount(ppdPayments)),"left","0",12)}${setLength(cbank.custpage_eft_custrecord_2663_issuer_num,10)}                         ${setLength(cbank.custpage_eft_custrecord_2663_bank_num, 8)}${setPadding(batchCount,"left","0",7)}
<#assign recordCount = recordCount + 1>
</#if>
<#assign recordCount = recordCount + 1>
<#if cbank.custpage_eft_custrecord_2663_pad_blocks && (recordCount % 10 > 0)>    
    <#assign padBlocksString = "\n">
    <#assign numBlocks = 10 - (recordCount % 10) >
    <#assign padding = "9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999">    
    <#list 1..numBlocks as i>
        <#assign padBlocksString = padBlocksString + padding + "\n">
    </#list>
</#if>
9${setPadding(batchCount,"left","0",6)}${setPadding(computeTotalRecords(recordCount),"left","0",6)}${setPadding(lineCount,"left","0",8)}${setPadding(totalBankNumberHash,"left","0",10)}${setPadding(formatAmount(computeTotalDebitAmt(payments)),"left","0",12)}${setPadding(formatAmount(totalAmount),"left","0",12)}                                       ${padBlocksString}<#rt>
#OUTPUT END#
#RETURN START#
sequenceId:${newSeqId}
#RETURN END#