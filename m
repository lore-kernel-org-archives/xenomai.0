Message-ID: <4F575BA3.7060404@domain.hid>
Date: Wed, 07 Mar 2012 13:59:15 +0100
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid> <4F55C306.8020307@domain.hid>
	<4F55D765.7040705@domain.hid> <4F55E390.8090706@domain.hid>
	<4F55FE81.6000904@domain.hid> <4F560A6C.2080306@domain.hid>
	<4F560B76.5080606@domain.hid> <4F5629D2.50304@domain.hid>
	<4F562B53.7070400@domain.hid> <4F562EC2.6040604@domain.hid>
	<4F56387B.40702@domain.hid>
In-Reply-To: <4F56387B.40702@domain.hid>
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

we are sure that when a task execute NO INTERRUPTS arrives in interrupt 
service routine in assembler in the kernel,
until it sleeps. It's not a problem of secondary mode.

So we tried the same application on another porting of xenomai with 
marvell ( kernel 2.6.31.8 - xenomai always 2.5.6 ) and there is no problem.

We cannot change the kernel so we must find the problem in this version 
2.6.31 with xenomai 2.5.6 .
The patch of ipipe used is for 2.6.31.8 instead 2.6.31.
Is there a problem for this ? There are the hw locks (spin_lock, etc...) 
in the 2.6.31 that are different in 2.6.31.8 ?

I repeat that seems that all interrupt are disabled, as if there are 
some irq_enable/irq_disable when execute a task,
or the interrupt line is not acked.

The hw implementation of read/write/ack timer are correct.

Can you explain me how work the scheduler of xenomai compared with the 
tasks and the timer ?

Thanks for all.




Il 06/03/2012 17:16, Gilles Chanteperdrix ha scritto:
> On 03/06/2012 04:35 PM, Roberto Bielli wrote:
>> Hi Gilles,
>>
>> about T_WARNSW i see in the /proc/xenomai/stat that my task hasn't change mode (the value of MSW is 0 )
>> so, it hasn't changed in secondary mode.
> Or maybe it started in secondary mode and never switched mode?
>
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


