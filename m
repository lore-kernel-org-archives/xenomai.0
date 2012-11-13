Message-ID: <50A23D62.3080409@axelsw.it>
Date: Tue, 13 Nov 2012 13:30:26 +0100
From: Roberto Bielli <roberto.bielli@axelsw.it>
MIME-Version: 1.0
References: <50A10873.9030907@axelsw.it> <50A109F3.9090106@axelsw.it>
	<50A16CA2.7060403@xenomai.org> <50A1FF6A.3000802@axelsw.it>
	<50A224BE.5060800@xenomai.org>
In-Reply-To: <50A224BE.5060800@xenomai.org>
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

Hi Gilles,

excuse me for my english but the exact question is this:

i have two applications with xenomai tasks.

I want to debug the first application with gdb but i don't want to debug 
the second.
I want that the second goes normally.

Tha actual behaviour is that if i put a breakpoint in a xenomai task in 
the first application also the tasks in the second applications stops.

You answer me that it's the correct behavior because it's a feature.

So i ask you if there is a way to allow to debug the first application 
without the second stops.

Best regards.


Il 13/11/2012 11:45, Gilles Chanteperdrix ha scritto:
> On 11/13/2012 09:06 AM, Roberto Bielli wrote:
>
>> Hi,
>>
>> is there a way instead to debug a xenomai userspace application without
>> than the other xenomai task in the application stops  ?
>
> The other xenomai task should not stop when you debug an application,
> they only stop when the debugged application is stopped.
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


