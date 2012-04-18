Message-ID: <4F8E9746.8060209@domain.hid>
Date: Wed, 18 Apr 2012 12:28:22 +0200
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid>
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
	<4F841E32.50101@domain.hid> <4F8428AA.1040404@domain.hid>
	<4F842A4B.8040106@domain.hid> <4F852BBB.5050400@domain.hid>
	<4F85749C.808@domain.hid> <4F86AA98.6010805@domain.hid>
	<4F87099F.2020707@domain.hid> <4F87139E.6050805@domain.hid>
	<4F87E781.8020801@domain.hid> <4F882E7B.7010909@domain.hid>
	<4F8E7EF1.4070205@domain.hid> <4F8E871D.8030207@domain.hid>
In-Reply-To: <4F8E871D.8030207@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] porting xenomai on imx25
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

Hi Gilles,

i try to give only another accurate information.

i made another test:
i write a xenomai driver for reading the timer and avic register and i 
see a strange behaviour.
when there is the problem the interrupt is NOT masqueraded in avic but 
the timer has the interrupt not acked.

After this i understand that now are my problems.
Do you know somebody that can help me understanding the problem only for 
xenomai side?
We can accept a quotation of work.

Thanks for all


information and if you

Il 18/04/2012 11:19, Gilles Chanteperdrix ha scritto:
> On 04/18/2012 10:44 AM, Roberto Bielli wrote:
>> Hi Gilles,
>>
>> here find the answers.
>> sorry for the delay.
>>
>> Il 13/04/2012 15:47, Gilles Chanteperdrix ha scritto:
>>> On 04/13/2012 10:44 AM, Roberto Bielli wrote:
>>>> Hi Gilles,
>>>>
>>>> you don't feel like to repeat.
>>>> I'm trying all the things that you told me and i will do all the missing
>>>> test that you told me.
>>> So, what is the result of running your test with unpatched Linux, but
>>> with CONFIG_HIGH_RES_TIMERS enabled?
>> the result is the same.
>> With the base linux application and  CONFIG_HIGH_RES_TIMERS all it's ok,
>> instead with xenomai application the task with less priority halt the
>> task with higher priority until it sleeps.
>> I send you my .config file and the test with pthread base.
> You know as well as me that this description of the problem is
> inaccurate, what really happens is that the timer is programmed but does
> not tick. What you have to do now is try and understand what is the
> difference between the way xenomai and linux handle the timer to
> understand what cause it not to work in xenomai case. If I were you, to
> understand this difference, I would start by dumping all timer registers
> values at the time when the problem is detected, that is, before the
> timer is programmed again. But I am afraid I can not give you more help,
> ultimately you are the one which is doing the port to imx25, so you are
> on your own.
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


