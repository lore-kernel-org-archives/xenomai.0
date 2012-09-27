Date: Thu, 27 Sep 2012 13:23:15 +0000 (UTC)
From: Forconi <forconi@wavecomm.it>
Message-ID: <1999962074.3983480.1348752195552.JavaMail.root@zmail.sgconsulting.it>
In-Reply-To: <50644142.3040107@xenomai.org>
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

The command:

make ARCH=3Darm CROSS_COMPILE=3Darm-unknown-linux-gnu- uImage

is the command I use to cross compile kernels for my AT91 board, and I have=
 successfully cross-compiled several kernels, so I think AS is the cross-as=
 not the system-as.

It seems like my cross-as doesn't support that assembler instruction.. (arm=
-unknown-linux-gnu-as version is: GNU assembler 2.16.1)



----- Messaggio originale -----
Da: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
A: "Forconi" <forconi@wavecomm.it>
Cc: xenomai@xenomai.org
Inviato: Gioved=C3=AC, 27 settembre 2012 14:06:26
Oggetto: Re: [Xenomai] Xenomai 2.6.1 - Linux 2.6.38.8 on AT91SAM9260 - Kern=
el compilation fails

On 09/27/2012 12:05 PM, Forconi wrote:
> Hi, this is my first approach to Xenomai, I'm trying to compile a
> Xenomai patched Linux kernel to run on a AT91SAM9260 embedded board.
>=20
> This is my environment: CROSS-GCC: gcc-4.2.3-glibc-2.3.3 KERNEL:
> Linux 2.6.38.8 XENOMAI: Xenomai-2.6.1
>=20
> I'm following the "Installation instructions" on web site (section
> 3.4. Building for ARM).
>=20
> The prepare-kernel.sh script runs ok, all files are patched with no
> errors, this is the command I've used:=20
> $xenomai_root/scripts/prepare-kernel.sh --arch=3Darm
> --adeos=3D$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-2.6.38.8-arm-1.=
18-08.patch
> --linux=3D$linux_tree
>=20
> Then I configure/build the kernel: make ARCH=3Darm
> CROSS_COMPILE=3Darm-unknown-linux-gnu- at91sam9260ek_defconfig make
> ARCH=3Darm CROSS_COMPILE=3Darm-unknown-linux-gnu- uImage
>=20
> But compilation fails: ... AS      arch/arm/nwfpe/entry.o LD
> arch/arm/nwfpe/nwfpe.o LD      arch/arm/nwfpe/built-in.o CC
> arch/arm/kernel/elf.o AS      arch/arm/kernel/entry-armv.o AS
> arch/arm/kernel/entry-common.o arch/arm/kernel/entry-common.S:
> Assembler messages: arch/arm/kernel/entry-common.S:449: Error: bad
> instruction `ldm sp,{r0-r3}' make[1]: ***
> [arch/arm/kernel/entry-common.o] Error 1 make: *** [arch/arm/kernel]
> Error 2
>=20
>=20
> Maybe I have to try with other versions of xenomai and kernel?

No, the problem is the toolchain. Are you sure AS is $(CROSS_COMPILE)as
and not the build system as ?


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

