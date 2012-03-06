Message-ID: <4F562EC2.6040604@domain.hid>
Date: Tue, 06 Mar 2012 16:35:30 +0100
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid> <4F55C306.8020307@domain.hid>
	<4F55D765.7040705@domain.hid> <4F55E390.8090706@domain.hid>
	<4F55FE81.6000904@domain.hid> <4F560A6C.2080306@domain.hid>
	<4F560B76.5080606@domain.hid> <4F5629D2.50304@domain.hid>
	<4F562B53.7070400@domain.hid>
In-Reply-To: <4F562B53.7070400@domain.hid>
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

about T_WARNSW i see in the /proc/xenomai/stat that my task hasn't change mode (the value of MSW is 0 )
so, it hasn't changed in secondary mode.

Correct ?



Il 06/03/2012 16:20, Gilles Chanteperdrix ha scritto:
> On 03/06/2012 04:14 PM, Roberto Bielli wrote:
>>   Hi Gilles,
>>
>> i changed the min value of the '__ipipe_mach_set_dec' but the situation
>> is the same.
>> I see with the scope that the task with less priority is not interrupted.
> In the trace you sent, we clearly saw that it was interrupted by a timer
> interrupt.
>
>> It's difficult to see with the ipipe trace the problem so i put the
>> xenomai trace in the application with
>> |xntrace_user_start|/|xntrace_user_stop|.
>> Is the log of xenomai in the same place (/proc/ipipe/trace/max ) of ipipe ?
> See the latency test for an example of usage of the I-pipe tracer in
> user-space. When using latency -f the trace is available in
> /proc/ipipe/trace/frozen.
>
> What about T_WARNSW (it is the third time I ask).
>
> Also, it would be nice if you could try a more recent version of Xenomai
> and of the I-pipe patch, say 2.6.0 with the I-pipe patch for 2.6.38.
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


