<fieldValidatorList>

<fieldValidator>
    <fieldName>custrecord_2663_bank_num</fieldName>
    <validatorList>
    <validator type='len'>
        <param name='minLength'>9</param>
        <param name='maxLength'>9</param>
    </validator>
    <validator type='custom' />
    </validatorList>
</fieldValidator>

<fieldValidator>
    <fieldName>custrecord_2663_bank_comp_id</fieldName>
    <validatorList>
    <validator type='len'>
        <param name='minLength'>9</param>
        <param name='maxLength'>10</param>
    </validator>
    <validator type="alpha">
	    <param name="specialChars">0-9</param>
    </validator>
</validatorList>
</fieldValidator>

<fieldValidator>
    <fieldName>custrecord_2663_issuer_num</fieldName>
    <validatorList>
    <validator type='len'>
        <param name='minLength'>10</param>
        <param name='maxLength'>10</param>
    </validator>
    <validator type="alpha">
	    <param name="specialChars">0-9</param>
    </validator>
</validatorList>
</fieldValidator>

<fieldValidator>
    <fieldName>custrecord_2663_acct_num</fieldName>
    <validatorList>
    <validator type='len'>
        <param name='maxLength'>17</param>
    </validator>
    <validator type="alpha">
        <param name="specialChars">!&quot;#$%&amp;&apos;()*+,-.\/:;&lt;=&gt;?@\[\\\]^_`\{|\}~0-9</param>
    </validator>
</validatorList>
</fieldValidator>

<fieldValidator>
    <fieldName>custrecord_2663_bank_name</fieldName>
    <validatorList>
    <validator type='len'>
        <param name='maxLength'>23</param>
    </validator>
    <validator type="alpha">
        <param name="specialChars">!&quot;#$%&amp;&apos;()*+,-.\/:;&lt;=&gt;?@\[\\\]^_`\{|\}~0-9</param>
    </validator>
</validatorList>
</fieldValidator>

<fieldValidator>
    <fieldName>custrecord_2663_legal_name</fieldName>
    <validatorList>
    <validator type='len'>
        <param name='maxLength'>16</param>
    </validator>
    <validator type="alpha">
        <param name="specialChars">!&quot;#$%&amp;&apos;()*+,-.\/:;&lt;=&gt;?@\[\\\]^_`\{|\}~0-9</param>
    </validator>
</validatorList>
</fieldValidator>

<fieldValidator>
    <fieldName>custrecord_2663_entity_bank_no</fieldName>
    <validatorList>
    <validator type='len'>
        <param name='minLength'>9</param>
        <param name='maxLength'>9</param>
    </validator>
    <validator type='custom' />
    </validatorList>
</fieldValidator>

<fieldValidator>
    <fieldName>custrecord_2663_entity_acct_no</fieldName>
    <validatorList>
    <validator type='len'>
        <param name='maxLength'>17</param>
    </validator>
    <validator type="alpha">
        <param name="specialChars">!&quot;#$%&amp;&apos;()*+,-.\/:;&lt;=&gt;?@\[\\\]^_`\{|\}~0-9</param>
    </validator>
</validatorList>
</fieldValidator>

</fieldValidatorList>