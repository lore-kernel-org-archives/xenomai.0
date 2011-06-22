MIME-Version: 1.0
Date: Wed, 22 Jun 2011 15:45:52 +0200
Message-ID: <BANLkTinOEhJtFVTL6DM5u+J4BJrkEyBqKA@mail.gmail.com>
From: Adrien LEMAITRE <adrien.lemaitre@domain.hid>
Content-Type: multipart/alternative; boundary=20cf3005db5add434404a64d2fb2
Subject: [Xenomai-help] Problem during compilation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--20cf3005db5add434404a64d2fb2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello,

i would like to install xenomai on x86 pc, but during compilation i have
this error:

arch/x86/xenomai/hal_32.c: In function =91rthal_arch_init=92:
arch/x86/xenomai/hal_32.c:348: error: =91nmi_watchdog=92 undeclared (first =
use
in this function)
arch/x86/xenomai/hal_32.c:348: error: (Each undeclared identifier is
reported only once
arch/x86/xenomai/hal_32.c:348: error: for each function it appears in.)
arch/x86/xenomai/hal_32.c:348: error: =91NMI_IO_APIC=92 undeclared (first u=
se in
this function)
make[1]: *** [arch/x86/xenomai/hal_32.o] Erreur 1
make: *** [arch/x86/xenomai] Erreur 2

I use for this compilation adeos-ipipe-2.6.38.8-x86-2.10-00.patch with
linux-2.6.38.8 and xenomai-2.5.6.
I tried with i386_defconfig configuration and with my computer's
configuration (/boot/config-2.6.32-24-generic).
In these cases always the same error.

Is it an incompatibility of version between linux and xenomai or a problem
with configuration?

do you have an idea?


thanks,

Adrien Lema=EEtre.

--20cf3005db5add434404a64d2fb2
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>i would like to install xenomai on x86 pc, but during compila=
tion i have this error:<br><br><div style=3D"margin-left: 40px;">arch/x86/x=
enomai/hal_32.c: In function =91rthal_arch_init=92:<br>arch/x86/xenomai/hal=
_32.c:348: error: =91nmi_watchdog=92 undeclared (first use in this function=
)<br>
arch/x86/xenomai/hal_32.c:348: error: (Each undeclared identifier is report=
ed only once<br>arch/x86/xenomai/hal_32.c:348: error: for each function it =
appears in.)<br>arch/x86/xenomai/hal_32.c:348: error: =91NMI_IO_APIC=92 und=
eclared (first use in this function)<br>
make[1]: *** [arch/x86/xenomai/hal_32.o] Erreur 1<br>make: *** [arch/x86/xe=
nomai] Erreur 2<br></div><br>I use for this compilation adeos-ipipe-2.6.38.=
8-x86-2.10-00.patch with linux-2.6.38.8 and xenomai-2.5.6.<br>I tried with =
i386_defconfig configuration and with my computer&#39;s configuration (/boo=
t/config-2.6.32-24-generic).<br>
In these cases always the same error. <br><br>Is it an incompatibility of v=
ersion between linux and xenomai or a problem with configuration?<br><br>do=
 you have an idea?<br><br><br>thanks,<br><br>Adrien Lema=EEtre.<br>

--20cf3005db5add434404a64d2fb2--

