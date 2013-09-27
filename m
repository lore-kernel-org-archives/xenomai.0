Message-ID: <524580CE.7020505@axelsw.it>
Date: Fri, 27 Sep 2013 14:57:50 +0200
From: Roberto Bielli <roberto.bielli@axelsw.it>
MIME-Version: 1.0
References: <52457ED1.8050509@axelsw.it>
In-Reply-To: <52457ED1.8050509@axelsw.it>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Subject: [Xenomai] Fwd: Re: RE : RE : RE : RE : No boot kernel with xenomai
 on i.MX6Q Sabrelite
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

missing attachment


-------- Messaggio originale --------
Oggetto: 	Re: [Xenomai] RE : RE : RE : RE : No boot kernel with xenomai =

on i.MX6Q Sabrelite
Data: 	Fri, 27 Sep 2013 14:49:21 +0200
Mittente: 	Roberto Bielli <roberto.bielli@axelsw.it>
A: 	Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
CC: 	xenomai@xenomai.org <xenomai@xenomai.org>



Hi,

my kernel working before applying adeos-ipipe-3.0.36-arm-1.18-11.patch +
adeos-ipipe-3.0.36-arm-1.18-11-post.patch,
So is not a problem before installing ipipe.

Can you tell me if there are some invalid/missing configuration in
attached .config ( otherwise the patch has problems ) ?









Il 27/09/2013 14:32, Gilles Chanteperdrix ha scritto:
> Roberto Bielli wrote:
>> Hi,
>>
>> i'm try to do the same things (porting xenomai 2.6.2.1 on imx6q sabresd
>> kernel ) and i have the same error ('Switching to clocksource ipipe_tsc'
>> on boot the kernel).
>> The steps was these:
>> 1. patch the kernel with the prepare-kernel.sh with the correct CFLAGS
>> and LDFLAGS (adeos-ipipe-3.0.36-arm-1.18-11.patch)
>> 2. apply the post patch (adeos-ipipe-3.0.36-arm-1.18-11-post.patch)
>> 3. boot the new kernel
>> 4. show the error 'Switching to clocksource ipipe_tsc'
>>
>> i have some simple question.
>> 1. There is a solution actually for this (are there some kernel
>> particular options to enable/disable)?
> The answer to this question is contained in the quoted answer. So, please
> read the answer again.
>
>> Il 15/07/2013 20:18, Gilles Chanteperdrix ha scritto:
>>> On 07/15/2013 03:00 PM, Younes CHALABI wrote:
>>>
>>>> Hi Gilles,
>>>>
>>>> I have tried to disable the CONFIG_IPIPE and CONFIG_XENOMAI manually
>>>> on the .config, where CONFIG_cpu_IDLE was already disabled, then
>>>> recompile but still have the same issue as previously.
>>>
>>> It is generally not a good idea to edit the .config manually.
>>> Automatic dependencies may re-enable the options you want disabled.
>>>
>>> Anyway, if indeed the kernel without CONFIG_IPIPE and CONFIG_XENOMAI
>>> does not boot, your problem has probably nothing to do with Xenomai.
>>>
>>> Again, I would recommend using mx6q_defconfig and checking that this
>>> default configuration at least boots.
>>>
>>>
>>
>


-- =

+--------------------------------------------------------------------------=
----------------------+
							=

Roberto Bielli
Sviluppo Software					=

Axel S.r.l.					=

							=

Via Del Cannino, 3 				=

21020 Crosio Della Valle			=

Varese - Italy					=

							=

Telefono: +39 0332 949600			=

Fax:      +39 0332 969315			=

							=

E-mail:   roberto.bielli@axelsw.it	=

Web Site: www.axelsw.it

+--------------------------------------------------------------------------=
----------------------+

Si precisa che le informazioni contenute in questo messaggio sono riservate=
 e ad uso esclusivo del destinatario.
Qualora il messaggio in parola Le fosse pervenuto per errore, La preghiamo =
di eliminarlo senza copiarlo e di non inoltrarlo a terzi,
dandocene gentilmente comunicazione. Grazie.
Informativa sul trattamento dei dati personali (D. Lgs. 196/2003).
I dati utilizzati per la spedizione del presente messaggio sono utilizzati =
da Axel S.r.l., titolare del trattamento,
per l'invio delle comunicazioni dei diversi settori aziendali, non essendo =
autorizzata la divulgazione a terzi.
Potrete rivolgere alla seguente mail richieste di verifica, rettifica o can=
cellazione dei Vostri dati: info@axelsw.it

This e-mail and any attachments is confidential and may contain privileged =
information
intended for the addressee(s) only. Dissemination, copying, printing or use=
 by anybody
else is unauthorised. If you are not the intended recipient,
please delete this message and any attachments and advise the sender
by return e-mail.Thank you.  			=

							=

+--------------------------------------------------------------------------=
----------------------+


_______________________________________________
Xenomai mailing list
Xenomai@xenomai.org
http://www.xenomai.org/mailman/listinfo/xenomai


-- =

+--------------------------------------------------------------------------=
----------------------+
							=

Roberto Bielli
Sviluppo Software					=

Axel S.r.l.					=

							=

Via Del Cannino, 3 				=

21020 Crosio Della Valle			=

Varese - Italy					=

							=

Telefono: +39 0332 949600			=

Fax:      +39 0332 969315			=

							=

E-mail:   roberto.bielli@axelsw.it	=

Web Site: www.axelsw.it

+--------------------------------------------------------------------------=
----------------------+

Si precisa che le informazioni contenute in questo messaggio sono riservate=
 e ad uso esclusivo del destinatario.
Qualora il messaggio in parola Le fosse pervenuto per errore, La preghiamo =
di eliminarlo senza copiarlo e di non inoltrarlo a terzi,
dandocene gentilmente comunicazione. Grazie.
Informativa sul trattamento dei dati personali (D. Lgs. 196/2003).
I dati utilizzati per la spedizione del presente messaggio sono utilizzati =
da Axel S.r.l., titolare del trattamento,
per l'invio delle comunicazioni dei diversi settori aziendali, non essendo =
autorizzata la divulgazione a terzi.
Potrete rivolgere alla seguente mail richieste di verifica, rettifica o can=
cellazione dei Vostri dati: info@axelsw.it

This e-mail and any attachments is confidential and may contain privileged =
information
intended for the addressee(s) only. Dissemination, copying, printing or use=
 by anybody
else is unauthorised. If you are not the intended recipient,
please delete this message and any attachments and advise the sender
by return e-mail.Thank you.  			=

							=

+--------------------------------------------------------------------------=
----------------------+



-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config
Type: application/xml
Size: 72750 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20130927/397740d=
9/attachment.wsdl>
