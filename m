Message-ID: <4F8421F7.50807@domain.hid>
Date: Tue, 10 Apr 2012 14:05:11 +0200
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid>
	<4F55C306.8020307@domain.hid>	<4F55D765.7040705@domain.hid>
	<4F55E390.8090706@domain.hid>	<4F55FE81.6000904@domain.hid>
	<4F560A6C.2080306@domain.hid>	<4F560B76.5080606@domain.hid>
	<4F5629D2.50304@domain.hid>	<4F562B53.7070400@domain.hid>
	<4F562EC2.6040604@domain.hid>	<4F56387B.40702@domain.hid>
	<4F575BA3.7060404@domain.hid>	<4F576622.1030509@domain.hid>
	<4F57A567.7030008@domain.hid>	<4F7C127D.2010400@domain.hid>
	<4F7C1484.5090406@domain.hid>	<4F7C183F.5040009@domain.hid>
	<4F7F0D4E.8080906@domain.hid>	<4F7F0E8A.70702@domain.hid>
	<4F7F20F0.9070007@domain.hid>	<4F80BD10.2060200@domain.hid>
	<4F83F2C3.50704@domain.hid>	<4F83F321.2030300@domain.hid>
	<4F83F645.7040402@domain.hid> <4F83F828.4000508@domain.hid>
	<4F83F929.5000300@domain.hid> <4F83FBAB.7040301@domain.hid>
	<4F83FF49.90608@domain.hid> <4F840DD8.2030407@domain.hid>
	<4F8418C4.400@domain.hid>
In-Reply-To: <4F8418C4.400@domain.hid>
Content-Type: multipart/mixed; boundary="------------080608070001090107000302"
Subject: Re: [Xenomai-core] preemptive doesn't work
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------080608070001090107000302
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gilles,

i added this in configure of xenomai so i pass --enable-arm-mach=imx25

imx25)        arch=5
             tsc_type=__XN_TSC_TYPE_FREERUNNING;;

Furthermore in plat-mxc/include/mach/mxc.h explain which are cpumx2 and 
imx25 is NOT mx2
#define cpu_is_mx2()    (cpu_is_mx21() || cpu_is_mx27())

i don't understand a things.
Does the tsc necessary to calculate correct timer period, or can i 
disable tsc and xenomai continue work correctly ?

However i cannot use tsc in my simple application. I resend the simple C 
application that doesn't work.


Il 10/04/2012 13:25, Gilles Chanteperdrix ha scritto:
> On 04/10/2012 12:39 PM, Roberto Bielli wrote:
>> Hi Gilles,
>>
>> i tried your code but th behavior is the same.
>>
>> Then i tried a linux base app and works correctly.
> The tsc physical address passed to user-space looks wrong.
>
> void __ipipe_mach_get_tscinfo(struct __ipipe_tscinfo *info)
> {
> 	info->type = IPIPE_TSC_TYPE_FREERUNNING;
> 	if (cpu_is_mx1()) {
> #ifdef CONFIG_ARCH_MX1
> 		info->u.fr.counter = (unsigned *) (TIM1_BASE_ADDR + MX1_2_TCN);
> #endif
> 	} else if (cpu_is_mx2()) {
> #ifdef CONFIG_ARCH_MX2
> 		info->u.fr.counter = (unsigned *) (GPT1_BASE_ADDR + MX1_2_TCN);
> #endif
> 	} else if (cpu_is_mx3() || cpu_is_mx25() ) {
> #if defined CONFIG_ARCH_MX3 || defined CONFIG_ARCH_MX25
> 		info->u.fr.counter = (unsigned *) (GPT1_BASE_ADDR + MX3_TCN);
> #endif
> 	}
> 	info->u.fr.mask = 0xffffffff;
> 	info->u.fr.tsc =&tsc->full;
> }
>
> Here cpu_is_mx2() will return true, and we will not go to cpu_is_mx25().
>
> Are you using the tsc in user-space?
>
> If you are passing --enable-arm-mach=mx2 to xenomai configure
> script, you are using the tsc in user-space, and it is a wonder
> how it works.
>


-- 
+------------------------------------------------------------------------------------------------+
							
Roberto Bielli
Sviluppo Software					
Axel S.r.l.					
							
Via Del Cannino, 3 				
21020 Crosio Della Valle			
Varese - Italy					
							
Telefono: +39 0332 949600			
Fax:      +39 0332 969315			
							
E-mail:   roberto.bielli@domain.hid	
Web Site: www.axelsw.it

+------------------------------------------------------------------------------------------------+

Si precisa che le informazioni contenute in questo messaggio sono riservate e ad uso esclusivo del destinatario.
Qualora il messaggio in parola Le fosse pervenuto per errore, La preghiamo di eliminarlo senza copiarlo e di non inoltrarlo a terzi,
dandocene gentilmente comunicazione. Grazie.
Informativa sul trattamento dei dati personali (D. Lgs. 196/2003).
I dati utilizzati per la spedizione del presente messaggio sono utilizzati da Axel S.r.l., titolare del trattamento,
per l'invio delle comunicazioni dei diversi settori aziendali, non essendo autorizzata la divulgazione a terzi.
Potrete rivolgere alla seguente mail richieste di verifica, rettifica o cancellazione dei Vostri dati: info@domain.hid

This e-mail and any attachments is confidential and may contain privileged information
intended for the addressee(s) only. Dissemination, copying, printing or use by anybody
else is unauthorised. If you are not the intended recipient,
please delete this message and any attachments and advise the sender
by return e-mail.Thank you.  			
							
+------------------------------------------------------------------------------------------------+


--------------080608070001090107000302
Content-Type: text/plain; charset=windows-1252;
 name="testpreempt.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="testpreempt.c"

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3RkaW50Lmg+DQojaW5jbHVkZSA8ZmNu
dGwuaD4NCiNpbmNsdWRlIDxzeXMvaW9jdGwuaD4NCiNpbmNsdWRlIDxzdHJpbmcuaD4NCg0K
I2luY2x1ZGUgPHN0ZGxpYi5oPg0KI2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8c3lz
L21tYW4uaD4JLyogZm9yIE1DTF9DVVJSRU5UIGFuZCBNQ0xfRlVUVVJFICovDQojaW5jbHVk
ZSA8cnRkbS9ydGRtLmg+DQojaW5jbHVkZSA8bmF0aXZlL3Rhc2suaD4NCiNpbmNsdWRlIDxu
dWNsZXVzL3RyYWNlLmg+DQoNCiNkZWZpbmUgR1BJTzZfT04gCQkqR3BpbzJWYWxBZGRyIHw9
IDEgPDwgNg0KI2RlZmluZSBHUElPNl9PRkYJCSpHcGlvMlZhbEFkZHIgJj0gfigxIDw8IDYp
Ow0KDQpzdGF0aWMgUlRfVEFTSyBydF90YXNrX2Rlc2M7DQpzdGF0aWMgUlRfVEFTSyB0c2sy
bXM7DQoNCgkvL2RhdGkgcGVyIGxhIGdlc3Rpb25lIG1lbW9yaWEgbWFwcGF0YQ0Kc3RhdGlj
IHVuc2lnbmVkIGxvbmcgKiBHcGlvMlZhbEFkZHIgPSBOVUxMOw0KDQp2b2xhdGlsZSBpbnQg
Y250Mm1zID0gMDsNCnZvbGF0aWxlIGludCBjbnRtYWluID0gMDsNCnZvbGF0aWxlIGludCB4
Ow0KDQp2b2lkIGZ1bmN0Mm1zKCB2b2lkICogcGFyYW1zICkNCnsNCglmb3IoOzspDQoJew0K
CQlHUElPNl9PTjsNCgkJcnRfdGFza19zbGVlcCggMjAwMDAwMCApOw0KCQkrKyBjbnQybXM7
DQoJCUdQSU82X09GRjsNCgl9DQp9DQoNCmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2
W10pDQp7DQoJaW50IGNvdW50ID0gMDsNCglpbnQgdHJhY2VPbiA9IDA7DQoJaW50IGZkLCBy
ZXQ7DQoNCgkvLyBubyBtZW1vcnktc3dhcHBpbmcgZm9yIHRoaXMgcHJvZ3JhbW0NCglyZXQg
PSBtbG9ja2FsbChNQ0xfQ1VSUkVOVCB8IE1DTF9GVVRVUkUpOw0KCWlmKCByZXQgKQ0KCXsN
CgkJcGVycm9yKCJFUlJPUiA6IG1sb2NrYWxsIGhhcyBmYWlsbGVkIik7DQoJCWV4aXQoMSk7
DQoJfQ0KDQoNCglmZCA9IG9wZW4oICIvZGV2L21lbSIsIE9fUkRXUiB8IE9fU1lOQyApOw0K
CXByaW50ZiggIkZEPSVkIiwgZmQgKTsNCglmZmx1c2goIHN0ZG91dCApOw0KDQoJR3BpbzJW
YWxBZGRyID0gKHVuc2lnbmVkIGxvbmcgICopbW1hcCggIE5VTEwsIDB4MTAwMCwgUFJPVF9S
RUFEIHwgUFJPVF9XUklURSwgIE1BUF9TSEFSRUQsIGZkLCAweDUzRkQwMDAwICk7DQoJR1BJ
TzZfT047DQoJR1BJTzZfT0ZGOw0KDQoJcnRfdGFza19jcmVhdGUoICZ0c2sybXMsICJ0YXNr
Mm1zIiwwLCA5OSwgMCApOw0KCXJ0X3Rhc2tfc3RhcnQoICZ0c2sybXMsIGZ1bmN0Mm1zLCBO
VUxMICk7DQoJDQoJcmV0ID0gcnRfdGFza19zaGFkb3coJnJ0X3Rhc2tfZGVzYywgTlVMTCwg
MSwgMCk7DQoJaWYoIHJldCAhPSAwICkNCgl7DQoJCWZwcmludGYoc3RkZXJyLCAiRVJST1Ig
OiBydF90YXNrX3NoYWRvdzogJXNcbiIsIHN0cmVycm9yKC1yZXQpKTsNCgkJZXhpdCggMSAp
Ow0KCX0NCg0KCWZvcig7OykNCgl7DQoJCWZvciggeD0wOyB4IDwgMTAwMDAwMDsgeCsrICk7
DQoJCWZvciggeD0wOyB4IDwgMTAwMDAwMDsgeCsrICk7DQoJCS8veG50cmFjZV91c2VyX2Zy
ZWV6ZSgwLCAwKTsNCgkJZm9yKCB4PTA7IHggPCAxMDAwMDAwOyB4KysgKTsNCgkJZm9yKCB4
PTA7IHggPCAxMDAwMDAwOyB4KysgKTsNCgkJcnRfdGFza19zbGVlcCggMTAwMDAwMDAgKTsN
Cgl9DQoNCglyZXR1cm4gMDsNCn0NCg==
--------------080608070001090107000302--

