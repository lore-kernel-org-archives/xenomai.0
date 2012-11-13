Message-ID: <50A1FC73.7080104@axelsw.it>
Date: Tue, 13 Nov 2012 08:53:23 +0100
From: Roberto Bielli <roberto.bielli@axelsw.it>
MIME-Version: 1.0
References: <50A10873.9030907@axelsw.it> <50A109F3.9090106@axelsw.it>
	<50A16CA2.7060403@xenomai.org>
In-Reply-To: <50A16CA2.7060403@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] debug a xenomai application with gdb stops another
 xenomai application
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi,

is the same behaviour in kernel space ?

I explain it better.

if i develop a rtdm driver with xenomai tasks and put a gdb breakpoint 
into user space application
does the task in kernel space continue ?

Best Regards


Il 12/11/2012 22:39, Gilles Chanteperdrix ha scritto:
> On 11/12/2012 03:38 PM, Roberto Bielli wrote:
>
>> Hi,
>>
>> i have two different applications with xenomai task.
>> When i put a gdb breakpoint into a task in the first application, the
>> xenomai tasks in the second applications stops.
>>
>> Is it a correct behaviour ?
>>
>> the system is:
>>    - cpu = arm - freescale imx25
>>    - kernel 2.6.31
>>    - xenomai 2.5.6
>>    - adeos-ipipe-2.6.31-arm-1.16-02.patch
>>
>> Thanks for all
>
> I think so. This is a feature, the timers stops, because otherwise, if
> you use timeouts, you get cascaded timeouts all over the place when one
> thread stops in the debugger.
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
							
E-mail:   roberto.bielli@axelsw.it	
Web Site: www.axelsw.it

+------------------------------------------------------------------------------------------------+

Si precisa che le informazioni contenute in questo messaggio sono riservate e ad uso esclusivo del destinatario.
Qualora il messaggio in parola Le fosse pervenuto per errore, La preghiamo di eliminarlo senza copiarlo e di non inoltrarlo a terzi,
dandocene gentilmente comunicazione. Grazie.
Informativa sul trattamento dei dati personali (D. Lgs. 196/2003).
I dati utilizzati per la spedizione del presente messaggio sono utilizzati da Axel S.r.l., titolare del trattamento,
per l'invio delle comunicazioni dei diversi settori aziendali, non essendo autorizzata la divulgazione a terzi.
Potrete rivolgere alla seguente mail richieste di verifica, rettifica o cancellazione dei Vostri dati: info@axelsw.it

This e-mail and any attachments is confidential and may contain privileged information
intended for the addressee(s) only. Dissemination, copying, printing or use by anybody
else is unauthorised. If you are not the intended recipient,
please delete this message and any attachments and advise the sender
by return e-mail.Thank you.  			
							
+------------------------------------------------------------------------------------------------+


