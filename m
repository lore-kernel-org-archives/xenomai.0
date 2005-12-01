Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Problem building MVM: "error: The X11 library
	'-lX11' could not be found"
Date: Thu, 1 Dec 2005 13:14:43 +0200
Message-ID: <8DF1258D5F0FC94EBF5810BF2C7BF2FB3FFD4A@ILEX5.IL.NDS.COM>
From: "Ashri, Sarit" <Sashri@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hi Philippe,

I did read the files. What I don't understand is how to build the
Xenomai
With Simulator support?
When I build Xenomai without simulator support - everything works just
fine
(crossed compiled to work on PPC with Linux 2.6.13.4).
As soon as I mark Simulator->Minute Virtual Machine I get that error
(X11 library..).
I understood from reading previous mails on the internet that I should
be able to=20
build the MVM on my host computer which is NOT patched by Adeos (RHEL3.0
Linux on i686)
through Regular Xenomai CROSS_COMPILING and installation.

If I try using the unpatched host Linux version (2.4) I get the
following error message from
Xenomai configuration:=20
=2E..
checking for Linux build tree... /lib/modules/2.4.21-32.EL/build (kernel
2.4.21-32.ELcustom)
checking for Linux source tree... /lib/modules/2.4.21-32.EL/build
checking for interrupt pipeline extension... configure: error: No
interrupt pipeline extension enabled in your kernel.
        You need to apply an Adeos patch first.
make: *** [config.status] Error 1

Should I:
1. Try compiling with my patched Linux 2.6 - won't I have problems
running programs=20
compiled for Linux 2.6 on Linux 2.4?
2. compile Xenomai without Simulator support and then try installing the
simulator separately?
BTW when I try to install the simulator separately:
I ran sim/configure it passed and so did make and make install of the
simulator directly in sim directory, but when I tried to compile the
demos with gcic (make sim) I received the error message:
"gcic:instrumenter/compiler is missing -- please check your
installation."
So I thought this might not be the correct way to do it. Maybe I should
continue on this
road?
3. Something else?

I'm new to Xenomai and Linux so excuse me if I'm missing something
basic.
I appreciate your help!
Sarit
=20
> Philippe Gerum wrote:
> > Ashri, Sarit wrote:
> >=20
> >> Hi,
> >>
> >> I'm trying to build Xenomai 2.0.1 with MVM support.
> >> My target board is PPC and I use patched Linux 2.6.13.4 with it +=20=

> >> Xenomai 2.0.1 , cross compiled with the flags: ARCH=3Dppc
> >> CROSS_COMPILE=3Dppc_82xx:
> >=20
> >=20
> > The simulator is a _host_ based tool, not a target one, so=20
> you don't=20
> > want to cross-compile it for your target, it's a native compilation=20=

> > from and for your build system. Make sure to read sim/README to get=20=

> > the software package deps, then select the simulation build in the=20=

> > config menu, and specify a valid path to a GCC-2.95.3=20
> archive as specified.
>=20
> While you are at it, also make sure to read=20
> sim/doc/mvm-manual.txt to get a detailed explanation about=20
> what the simulator does and how it does it. It's an=20
> event-driven simulation engine working at source code level,=20
> not a CPU emulator.
>=20
> --=20
>=20
> Philippe.
>=20
*************************************************************************=
**********
This email message and any attachments thereto are intended only for use =
by the addressee(s) named above, and may contain legally privileged and/o=
r confidential information. If the reader of this message is not the inte=
nded recipient, or the employee or agent responsible to deliver it to the=
 intended recipient, you are hereby notified that any dissemination, dist=
ribution or copying of this communication is strictly prohibited. If you =
have received this communication in error, please immediately notify the =
postmaster@domain.hid and destroy the original message.
*************************************************************************=
**********

