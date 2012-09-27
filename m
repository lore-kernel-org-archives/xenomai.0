Date: Thu, 27 Sep 2012 14:07:49 +0000 (UTC)
From: Forconi <forconi@wavecomm.it>
Message-ID: <1280469939.3985122.1348754869513.JavaMail.root@zmail.sgconsulting.it>
In-Reply-To: <506458A3.7030708@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai 2.6.1 - Linux 2.6.38.8 on AT91SAM9260 -
 Kernel compilation fails
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

Thanks for this suggestion, replacing ldm sp,{r0-r3} with ldmia sp,{r0-r3} =
does the trick!
Now, the kernel compiles fine, so the problem was the ldm instruction was n=
ot recognised from the cross-as.


----- Messaggio originale -----
Da: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
A: "Forconi" <forconi@wavecomm.it>
Cc: xenomai@xenomai.org
Inviato: Gioved=C3=AC, 27 settembre 2012 15:46:11
Oggetto: Re: [Xenomai] Xenomai 2.6.1 - Linux 2.6.38.8 on AT91SAM9260 - Kern=
el compilation fails

On 09/27/2012 03:32 PM, Gilles Chanteperdrix wrote:
> On 09/27/2012 03:23 PM, Forconi wrote:
>> The command:
>>
>> make ARCH=3Darm CROSS_COMPILE=3Darm-unknown-linux-gnu- uImage
>>
>> is the command I use to cross compile kernels for my AT91 board, and I h=
ave successfully cross-compiled several kernels, so I think AS is the cross=
-as not the system-as.
>>
>> It seems like my cross-as doesn't support that assembler instruction.. (=
arm-unknown-linux-gnu-as version is: GNU assembler 2.16.1)
>=20
> I very much doubt an ARM assembler does not support
> ldm sp,{r0-r3}

You can also try replacing ldm with ldmia, but ldmia is supposed to be
the default for ldm where no suffix is specified, at least it is what
the documentation says.

--=20
=09=09=09=09=09    Gilles.

--=20
Ing. Samuele Forconi
Responsabile Sviluppo SW
WaveComm S.r.l.
Sede legale: Via Donizetti 25, 53011 Castellina in Chianti (SI)
Sede operativa: Loc. Belvedere - Ingresso 2, 53034 Colle Val d'Elsa (SI)
Phone: (39) 0577 043101
Fax: (39) 0577 043101
Mobile: (39) 347 5899717
Skype: samueleforconi
E-mail: forconi@wavecomm.it
URL: www.wavecomm.it

___________________________________________________________________________=
__________________

Ai sensi del D. Lgs. n.196 del 30/06/2003, questo messaggio ed ogni suo all=
egato sono confidenziali e ad uso esclusivo del destinatario, il quale =C3=
=A8 l'unico autorizzato ad usarlo, copiarlo e, sotto la propria responsabil=
it=C3=A0, diffonderlo. Se il ricevente non =C3=A8 il destinatario diretto d=
el presente messaggio, =C3=A8 pregato di contattare l'originario mittente e=
 di cancellare questo messaggio ed ogni suo allegato dal sistema di posta. =
Se il ricevente non =C3=A8 il destinatario diretto del presente messaggio, =
sono vietati l'uso, la riproduzione, e la stampa di questo messaggio e di o=
gni suo allegato, nonch=C3=A9 la diffusione del loro contenuto a qualsiasi =
altro soggetto.

For the D. Lgs. n.196 of 30/06/2003, this message and any attachment are co=
nfidential and privileged for the the recipient identified above, who only =
may use, copy and, under his/her responsibility, further disseminate it. If=
 you are not the intended recipient, please contact the sender and delete t=
his message and any attachment from your system. If you are not the intende=
d recipient you must not use, copy or print this message or attachment or d=
isclose the contents to any other person.

