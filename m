Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-help] Problem building MVM: "error: The X11 library
	'-lX11' could not be found"
Date: Sun, 4 Dec 2005 14:45:42 +0200
Message-ID: <8DF1258D5F0FC94EBF5810BF2C7BF2FB400251@domain.hid>
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
Do you think I should wait for the v2.1 to be released=20
or is it stable enough To start playing with it now?

Thanks a lot for all your help!
Sarit.

> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org
> Sent: Thursday, December 01, 2005 2:52 PM
> To: Ashri, Sarit
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Problem building MVM: "error: The=20
> X11 library '-lX11' could not be found"
>=20
> Ashri, Sarit wrote:
> >>Ashri, Sarit wrote:
> >>
> >>>Hi Philippe,
> >>>
> >>>I did read the files. What I don't understand is how to build the=20=

> >>>Xenomai With Simulator support?
> >>>When I build Xenomai without simulator support - everything
> >>
> >>works just
> >>
> >>>fine (crossed compiled to work on PPC with Linux 2.6.13.4).
> >>>As soon as I mark Simulator->Minute Virtual Machine I get=20
> that error
> >>>(X11 library..).
> >>>I understood from reading previous mails on the internet
> >>
> >>that I should
> >>
> >>>be able to build the MVM on my host computer which is NOT
> >>
> >>patched by
> >>
> >>>Adeos (RHEL3.0 Linux on i686) through Regular Xenomai
> >>
> >>CROSS_COMPILING
> >>
> >>>and installation.
> >>
> >>Try this:
> >>
> >>- Build your target system first without the simulator using=20
> >>cross-compilation for ppc. Let's say that you installed the results=20=

> >>under /usr/realtime, which is the default.
> >>
> >>- Then, build the simulator separately for the host:
> >>
> >>$ mkdir sim-build && cd sim-build
> >>$ .../xenomai/sim/configure --with-xeno-dir=3D/usr/realtime
> >>--with-gcc-tarball=3D/something/gcc-2.95.3.tar.bz2
> >>$ make install
> >>
> >=20
> > Everything compiled fine, but when I tried to compile the=20
> native demo=20
> > for the Simulator I received the following error:
> > cd .../skins/native/demos
> > [demos]$ /usr/realtime/bin/gcic -o satch_s.o -c satch.c -g -I=20
> > /opt/nfs_root/usr/realtime/include
> > In file included from
> > /opt/nfs_root/usr/realtime/include/nucleus/asm/atomic.h:23,
> >                  from
> > /opt/nfs_root/usr/realtime/include/nucleus/system.h:33,
> >                  from
> > /opt/nfs_root/usr/realtime/include/nucleus/asm-generic/system.h:560,
> >                  from
> > /opt/nfs_root/usr/realtime/include/nucleus/asm/system.h:23,
> >                  from
> > /opt/nfs_root/usr/realtime/include/nucleus/types.h:40,
> >                  from
> > /opt/nfs_root/usr/realtime/include/nucleus/queue.h:23,
> >                  from
> > /opt/nfs_root/usr/realtime/include/nucleus/timer.h:23,
> >                  from
> > /opt/nfs_root/usr/realtime/include/nucleus/thread.h:23,
> >                  from
> > /opt/nfs_root/usr/realtime/include/native/task.h:26,
> >                  from satch.c:4:
> > /usr/include/asm/atomic.h:40: warning: #warning Using=20
> kernel header in=20
> > userland program. BAD!
> > In file included from
> > /opt/nfs_root/usr/realtime/include/nucleus/system.h:33,
> >                  from
>=20
> Gah. Ok, my mistake. Since you are cross-compiling for your=20
> target, you need to have two Xenomai installations, once for=20
> the ppc target to run the real stuff, another one to run the=20
> virtual simulation environment for the x86 host.
>=20
> So, ...
>=20
> - Configure and cross-compile Xenomai for ppc without=20
> simulation support for installing to /opt/nfsroot
> - Configure and compile Xenomai natively for x86 with=20
> simulation support for installing to, e.g. /opt/local
>=20
> This way at least, you won't need to build the simulator=20
> apart, it will be built as part of the second step. Most of=20
> the native x86 support won't be used (aside of the simulator,=20
> of course), but at least, this will work. On the host, you=20
> will need to set your PATH and LD_LIBRARY_PATH to=20
> /opt/local/bin, and /opt/local/lib respectively, so that the=20
> simulation libs and tools are found.
>=20
> The #warning won't go away though; only v2.1 gets rid of this=20
> by avoiding any kernel header inclusion in user-space. Debian=20
> systems would not bother you with this (at least sarge=20
> doesn't), but RH actually do.
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

