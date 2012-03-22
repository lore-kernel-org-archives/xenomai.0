Message-ID: <4F6B554A.4080008@domain.hid>
Date: Thu, 22 Mar 2012 17:37:30 +0100
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
References: <4F6A065E.9030309@domain.hid> <4F6B45B3.7080904@domain.hid>
In-Reply-To: <4F6B45B3.7080904@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Using xenomai with standard ethernet driver
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

I explain better the problem.

I want to use ethernet driver raw without using all the abstract layer 
(tcp, socket etc....)
and my xenomai application must link to the raw driver without enter in 
secondary mode.

Have i change the driver interface with xenomai calls (rtdm_......) or 
is there another chance ?

Thanks a lot for your response.


Il 22/03/2012 16:30, Jan Kiszka ha scritto:
> On 2012-03-21 17:48, Roberto Bielli wrote:
>> Hi,
>>
>> i want to use xenomai for sending standard tcp/ip packets.
>> Is it possible to rewrite the ethernet driver for xenomai without using
>> rtnet ?
>> Or if i use rtnet is there a way to send standard tcp packet instead
>> rtnet packets ?
> Is the TCP/IP communication itself part of your time-critical path, or
> could it run with lower priority as well?
>
> Jan
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


