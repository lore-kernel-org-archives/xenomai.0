Date: Thu, 27 Mar 2008 13:39:46 +0100
Message-Id: <1102904794@domain.hid>
MIME-Version: 1.0
From: Paradoxxa2001@domain.hid
Subject: [Xenomai-help] (no subject)
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

NetSilicon 9360 and Xenomai/Adeos 
Precedence: fm-user
Organization: http://freemail.web.de/
X-Provags-Id: V01U2FsdGVkX18V85CtHcfHVFUMcMsg3rrEv7jsRH/jSEbkyMRKi14oBPLbZ
 9uEdkqV+/H8H30BnJelT5JBi8IPN2qfwTgSDNwEvwDe3kYuahkJO5E0MD+hy
 w==
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

I have here a NetSilicon 9360 (ARM926EJ-Sid(wb) [41069264] revision 4 (ARM=
v5TEJ)) Board and a buildroot toolchain. I will porting Xenomai/Adeos to t=
his Board. Actual i patches the Kernel (2.6.24) with Xenaomai:

$ /usr/src/xenomai-2.4.3/scripts/prepare-kernel.sh	\
		--linux=3D/usr/src/linux-2.6.24-gentoo/ 	\
		--adeos=3D/usr/src/xenomai-2.4.3/ksrc/arch/arm/patches/adeos-ipipe-2.6.24-=
arm-1.9-01.patch --arch=3Darm
$ cd /usr/src/linux-2.6.24-gentoo
$ build=5Froot=3D/usr/src/build=5Froot/
$ make ARCH=3Darm CROSS=5FCOMPILE=3Darm-linux- O=3D$build=5Froot ns9xxx=5Fdefconfig

Here the cross compiler from buildroot is used.
Then i started to port the I-Pipe recording to I-pipe:ArmPorting  ( http:/=
/www.xenomai.org/index.php/I-pipe:ArmPorting ). I added the variables and =
functions to the following files: /arch/arm/mach-ns9xxx/time.c, include/as=
m-arm/arch-ns9xx/irqs.h and /arch/arm/mach-ns9xxx/irq.c

The next step in the howto i don't understand really. I found nowhere the =
pxa=5Ftimer=5Finterrupt() function and so on. Therefore i don't know what i ha=
ve to do further.
When i try to compiling it i get this errors:

$ make ARCH=3Darm CROSS=5FCOMPILE=3Darm-linux- O=3D$build=5Froot
  CHK     include/linux/version.h
make[2]: =BBinclude/asm-arm/mach-types.h=AB ist bereits aktualisiert.
  Using /usr/src/linux-2.6.24-gentoo as source for kernel
  GEN     /usr/src/build=5Froot/Makefile
  CHK     include/linux/utsrelease.h
  CALL    /usr/src/linux-2.6.24-gentoo/scripts/checksyscalls.sh
<stdin>:1097:2: warning: #warning syscall fadvise64 not implemented
<stdin>:1265:2: warning: #warning syscall migrate=5Fpages not implemented
<stdin>:1321:2: warning: #warning syscall pselect6 not implemented
<stdin>:1325:2: warning: #warning syscall ppoll not implemented
<stdin>:1365:2: warning: #warning syscall epoll=5Fpwait not implemented
  CHK     include/linux/compile.h
  CC      arch/arm/kernel/ipipe.o
/usr/src/linux-2.6.24-gentoo/arch/arm/kernel/ipipe.c: In function '=5F=5Fipipe=
=5Fgrab=5Firq':
/usr/src/linux-2.6.24-gentoo/arch/arm/kernel/ipipe.c:429: error: expected =
expression before ')' token
make[2]: *** [arch/arm/kernel/ipipe.o] error 1
make[1]: *** [arch/arm/kernel] error 2
make: *** [sub-make] error 2


Do someone have an idea and could help me=3F
Thanks
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Mit der Gruppen-SMS von WEB.DE FreeMail k=F6nnen Sie eine SMS an alle=20
Freunde gleichzeitig schicken: http://freemail.web.de/features/=3Fmc=3D021179




