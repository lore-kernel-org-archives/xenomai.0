Message-ID: <4F83FB24.9070104@domain.hid>
Date: Tue, 10 Apr 2012 11:19:32 +0200
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid> <4F55C306.8020307@domain.hid>
	<4F55D765.7040705@domain.hid> <4F55E390.8090706@domain.hid>
	<4F55FE81.6000904@domain.hid> <4F560A6C.2080306@domain.hid>
	<4F560B76.5080606@domain.hid> <4F5629D2.50304@domain.hid>
	<4F562B53.7070400@domain.hid> <4F562EC2.6040604@domain.hid>
	<4F56387B.40702@domain.hid> <4F575BA3.7060404@domain.hid>
	<4F576622.1030509@domain.hid> <4F57A567.7030008@domain.hid>
	<4F7C127D.2010400@domain.hid> <4F7C1484.5090406@domain.hid>
	<4F7C183F.5040009@domain.hid> <4F7F0D4E.8080906@domain.hid>
	<4F7F0E8A.70702@domain.hid> <4F7F20F0.9070007@domain.hid>
	<4F80BD10.2060200@domain.hid> <4F83F2C3.50704@domain.hid>
	<4F83F321.2030300@domain.hid> <4F83F645.7040402@domain.hid>
	<4F83F828.4000508@domain.hid>
In-Reply-To: <4F83F828.4000508@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Gilles,

the steps for supporting imx25 have been:
1. We buy a board with imx25
2. Our supplier made the porting of linux 2.6.31 freescale with  imx25
3. we put a xenomai  2.5.6 and we have adapted for imx25. The only 
changes is this (because imx25 registers are identical to mx3 ):

old:
#define timer_is_v2()    (cpu_is_mx3() || cpu_is_mx5())

new:
#define timer_is_v2()    (cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx5())





Il 10/04/2012 11:06, Gilles Chanteperdrix ha scritto:
> On 04/10/2012 10:58 AM, Roberto Bielli wrote:
>> Hi Gilles,
>>
>> i look at the processor errata but for the imx25 there are no errata
>> elements on timer.
> It is strange that you use linux 2.6.31 on imx25: linux 2.6.31 does not
> support imx25.
>
> The I-pipe support has not been written for imx25, so, it is entirely
> possible that you have to adapt it. See:
> http://www.xenomai.org/index.php/I-pipe:ArmPorting
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


