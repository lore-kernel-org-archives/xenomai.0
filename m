Message-ID: <4F6C7EC6.3040405@domain.hid>
Date: Fri, 23 Mar 2012 14:46:46 +0100
From: Roberto Bielli <roberto.bielli@domain.hid>
MIME-Version: 1.0
References: <4F6A065E.9030309@domain.hid> <4F6B45B3.7080904@domain.hid>
	<4F6B554A.4080008@domain.hid> <4F6C3D32.70801@domain.hid>
	<4F6C5C07.4090001@domain.hid> <4F6C6925.8000503@domain.hid>
In-Reply-To: <4F6C6925.8000503@domain.hid>
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
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Jan,

if i want to send a raw ethernet (for example for implement ethercat 
communication) so the best practise for xenomai is
to transform the linux base driver to xenomai driver. Is it correct ?

Thanks for all

Il 23/03/2012 13:14, Jan Kiszka ha scritto:
> On 2012-03-23 12:18, Roberto Bielli wrote:
>> Hi Jan,
>>
>> i want to send and receive custom raw packets over ethernet.
>> is it possibile with RTnet or it sends only rtnet packets ?
>>
>> Thanks for your response.
> RTnet is modular, and if you use the stack a sketched, you are free to
> define the payload of the sent Ethernet frames on your own.
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


