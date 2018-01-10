MIME-Version: 1.0
In-Reply-To: <266d7c1efc534a3284787e54599e952b@ocnapvsw3301.ocr.priv>
References: <266d7c1efc534a3284787e54599e952b@ocnapvsw3301.ocr.priv>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 10 Jan 2018 12:09:39 -0500
Message-ID: <CALLqZ8S5LHPi+5qAGfiCVQOyAnK+bTjhK2Mxt1vqQei6jbfq_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xenomai 3.0.6 - ipipe-3.18.20 - kernel build error
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

Hi,
  Can you post more information on how you are building the patched
kernel?  I'm assuming you are building for x86_64?

Thanks

Greg

On Wed, Jan 10, 2018 at 11:16 AM, Fazio Maurizio
<maurizio.fazio@leonardocompany.com> wrote:
> Hello,
> I have some problems in building the 3.18.20 stable kernel patched with X=
enomai 3.0.6 - Cobalt - ipipe-core-3.18.20-x86-9.patch
> The installed operating system is Centos 7. The same kernel patched using=
 Xenomai 3.0.5 and the same ipipe patch works without any problems.
>
> The following lines are the errors during the kernel building
>
> In file included from kernel/xenomai/bufd.c:23:0:
> arch/x86/xenomai/include/asm/xenomai/syscall.h: In function =E2=80=98__xn=
_get_syscall_n=E2=80=99:
> arch/x86/xenomai/include/asm/xenomai/syscall.h:60:2: error: implicit decl=
aration of function =E2=80=98__COBALT_CALL32_SYSNR=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
>  return __xn_syscall_p(regs) ? __xn_syscall(regs)
>
> In file included from arch/x86/xenomai/machine.c:22:0:
> arch/x86/xenomai/include/asm/xenomai/syscall.h: In function =E2=80=98__xn=
_get_syscall_n=E2=80=99:
> arch/x86/xenomai/include/asm/xenomai/syscall.h:60:2: error: implicit decl=
aration of function =E2=80=98__COBALT_CALL32_SYSNR=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
>  return __xn_syscall_p(regs) ? __xn_syscall(regs)
>
> The only difference is the new release of Xenomai 3.0.6 instead of the ol=
der 3.0.5 version...
>
> Thanks in advance
>
> Maurizio Fazio
>
> Chief Technical Office / Aircraft Systems
> Software Engineer
>
>
>
> Leonardo S.p.A.
> C.so Francia, 426 - Torino - 10146 - Italy
> Tel. +39 011 756 3308 / 3761
>
> maurizio.fazio@leonardocompany.com
> www.leonardocompany.com
>
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=93=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
> HELICOPTERS/AERONAUTICS/ELECTRONICS, DEFENCE & SECURITY SYSTEMS/SPACE
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=93=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94
>
>
>
> Il presente messaggio e-mail e ogni suo allegato devono intendersi indiri=
zzati esclusivamente al destinatario indicato e considerarsi dal contenuto =
strettamente riservato e confidenziale. Se non siete l'effettivo destinatar=
io o avete ricevuto il messaggio e-mail per errore, siete pregati di avvert=
ire immediatamente il mittente e di cancellare il suddetto messaggio e ogni=
 suo allegato dal vostro sistema informatico. Qualsiasi utilizzo, diffusion=
e, copia o archiviazione del presente messaggio da parte di chi non ne =C3=
=A8 il destinatario =C3=A8 strettamente proibito e pu=C3=B2 dar luogo a res=
ponsabilit=C3=A0 di carattere civile e penale punibili ai sensi di legge.
> Questa e-mail ha valore legale solo se firmata digitalmente ai sensi dell=
a normativa vigente.
>
> The contents of this email message and any attachments are intended solel=
y for the addressee(s) and contain confidential and/or privileged informati=
on.
> If you are not the intended recipient of this message, or if this message=
 has been addressed to you in error, please immediately notify the sender a=
nd then delete this message and any attachments from your system. If you ar=
e not the intended recipient, you are hereby notified that any use, dissemi=
nation, copying, or storage of this message or its attachments is strictly =
prohibited. Unauthorized disclosure and/or use of information contained in =
this email message may result in civil and criminal liability. =E2=80=9C
> This e-mail has legal value according to the applicable laws only if it i=
s digitally signed by the sender
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

