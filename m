Message-ID: <51FF7DF1.9010606@axelsw.it>
Date: Mon, 05 Aug 2013 12:26:57 +0200
From: Roberto Bielli <roberto.bielli@axelsw.it>
MIME-Version: 1.0
References: <51F267DB.2050404@axelsw.it> <51FE5208.9090008@xenomai.org>
In-Reply-To: <51FE5208.9090008@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] fcse best-effort mode has limitations in memory map
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

That's right.
i didn't pass MAP_FIXED but always mmap without FCSE gave me the same 
address.
FCSE with best effort works also with memory larger than 32MB.




Il 04/08/2013 15:07, Gilles Chanteperdrix ha scritto:
> On 07/26/2013 02:13 PM, Roberto Bielli wrote:
>
>> Hi,
>>
>> i try to map a memory address fixed on 0x79000000 with mmap.
>> if i don't enable FCSE with best effort the mmap give me the desire
>> wanted address,
>> otherwise seems only an adress minor than 32MB.
>>
>> But i understand that fcse with best effort cannot has limitations.
>>
>> Xenomai 2.6.2.1 on kernel 3.4.6, tx28 karo ( freescale imx28 ) ARM.
>
>
> Well, actually it works here, maybe you forgot to pass the "MAP_FIXED" 
> flag? If you do not pass this flag, the address is taken as a "hint", 
> and mmap has no obligation to use it.
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


