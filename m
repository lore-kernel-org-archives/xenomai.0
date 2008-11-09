Message-ID: <491749A1.7060609@domain.hid>
Date: Sun, 09 Nov 2008 21:35:45 +0100
From: Newsgroup <newsgroup@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Compile Kernel 2.6.26 with adeos patch failed
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

ive got a problem compiling the patched 2.6.26.7 linux kernel with the
adeos-ipipe patch.

after calling the prepare-kernel.sh script and "make menuconfig" i try
to build the kernel.

This error occurs:

scripts/kconfig/conf -s arch/x86/Kconfig
CHK include/linux/version.h
CHK include/linux/utsrelease.h
CALL scripts/checksyscalls.sh
CHK include/linux/compile.h
CC arch/x86/kernel/ipipe.o
arch/x86/kernel/ipipe.c: In Funktion =C2=BB__ipipe_divert_exception=C2=AB=
:
arch/x86/kernel/ipipe.c:810: Fehler: =C2=BBex_do_device_not_available=C2=AB
nicht deklariert (erste Benutzung in dieser Funktion)
arch/x86/kernel/ipipe.c:810: Fehler: (Jeder nicht deklarierte Bezeichner
wird nur einmal aufgef=C31/4hrt
arch/x86/kernel/ipipe.c:810: Fehler: f=C31/4r jede Funktion in der er
auftritt.)
make[1]: *** [arch/x86/kernel/ipipe.o] Fehler 1
make: *** [arch/x86/kernel] Fehler 2

can anyone able to help me?

Greets

Maveric



