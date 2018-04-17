MIME-Version: 1.0
In-Reply-To: <CALLqZ8TxoKntzDObQYvBbonPG725B8GbQo-9ZeeFMTLrDkxoaA@mail.gmail.com>
References: <8cb23a1388df4237bd2b132fe0addd83@ocnapvsw3301.ocr.priv>
 <CALLqZ8TxoKntzDObQYvBbonPG725B8GbQo-9ZeeFMTLrDkxoaA@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Tue, 17 Apr 2018 13:18:49 -0400
Message-ID: <CALLqZ8TNa5Rb8_VyqJpccSvEoJY2zoybnK4uUtMfghmn6WvFLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] kernel panic - xenomai3.0.6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Fazio Maurizio <maurizio.fazio@leonardocompany.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

NVM, found it

On Tue, Apr 17, 2018 at 12:41 PM, Greg Gallagher <greg@embeddedgreg.com> wr=
ote:
> I don't see a log attached, my email may have filtered it?
>
> On Tue, Apr 17, 2018 at 11:27 AM, Fazio Maurizio
> <maurizio.fazio@leonardocompany.com> wrote:
>> Good morning,
>> I=E2=80=99ve attached a kernel panic problem that occurs during the exec=
ution of my application.
>> Have you some ideas?
>>
>> Cpu:  Intel Core i7
>> OS: Centos 7 64bit with kernel 3.18.20 and path Xenomai 3.0.6
>>
>> Thanks in advance
>>
>>
>>
>> [cid:image002.jpg@01D3D671.4D19C7A0]
>>
>>
>>
>>
>>
>> Maurizio Fazio
>>
>> Chief Technical Office / Aircraft Systems
>> Software Engineer
>>
>>
>>
>> Leonardo S.p.A.
>> C.so Francia, 426 - Torino - 10146 - Italy
>> Tel. +39 011 756 3308 / 3761
>>
>> maurizio.fazio@leonardocompany.com
>> www.leonardocompany.com
>>
>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=93=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
>> HELICOPTERS/AERONAUTICS/ELECTRONICS, DEFENCE & SECURITY SYSTEMS/SPACE
>> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=93=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
>>
>>
>>
>>
>> Il presente messaggio e-mail e ogni suo allegato devono intendersi indir=
izzati esclusivamente al destinatario indicato e considerarsi dal contenuto=
 strettamente riservato e confidenziale. Se non siete l'effettivo destinata=
rio o avete ricevuto il messaggio e-mail per errore, siete pregati di avver=
tire immediatamente il mittente e di cancellare il suddetto messaggio e ogn=
i suo allegato dal vostro sistema informatico. Qualsiasi utilizzo, diffusio=
ne, copia o archiviazione del presente messaggio da parte di chi non ne =C3=
=A8 il destinatario =C3=A8 strettamente proibito e pu=C3=B2 dar luogo a res=
ponsabilit=C3=A0 di carattere civile e penale punibili ai sensi di legge.
>> Questa e-mail ha valore legale solo se firmata digitalmente ai sensi del=
la normativa vigente.
>> ________________________________
>> The contents of this email message and any attachments are intended sole=
ly for the addressee(s) and contain confidential and/or privileged informat=
ion.
>> If you are not the intended recipient of this message, or if this messag=
e has been addressed to you in error, please immediately notify the sender =
and then delete this message and any attachments from your system. If you a=
re not the intended recipient, you are hereby notified that any use, dissem=
ination, copying, or storage of this message or its attachments is strictly=
 prohibited. Unauthorized disclosure and/or use of information contained in=
 this email message may result in civil and criminal liability. =E2=80=9C
>> This e-mail has legal value according to the applicable laws only if it =
is digitally signed by the sender
>> -------------- next part --------------
>> A non-text attachment was scrubbed...
>> Name: image002.jpg
>> Type: image/jpeg
>> Size: 3447 bytes
>> Desc: image002.jpg
>> URL: <http://xenomai.org/pipermail/xenomai/attachments/20180417/9dfcc18a=
/attachment.jpg>
>> -------------- next part --------------
>> A non-text attachment was scrubbed...
>> Name: kernelPanic.JPG
>> Type: image/jpeg
>> Size: 635465 bytes
>> Desc: kernelPanic.JPG
>> URL: <http://xenomai.org/pipermail/xenomai/attachments/20180417/9dfcc18a=
/attachment.jpe>
>> _______________________________________________
>> Xenomai mailing list
>> Xenomai@xenomai.org
>> https://xenomai.org/mailman/listinfo/xenomai

