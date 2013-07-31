From: "George Pontis" <gpontis@z9.com>
References: <004401ce8ca9$a2ad4870$e807d950$@z9.com>
	<51F97FF7.2030203@xenomai.org>
In-Reply-To: <51F97FF7.2030203@xenomai.org>
Date: Wed, 31 Jul 2013 14:42:28 -0700
Message-ID: <022801ce8e36$da4b7700$8ee26500$@z9.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
Subject: Re: [Xenomai] Permissions problem/interaction with udev on Xenomai
	current
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: 'Gilles Chanteperdrix' <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

> -----Original Message-----
> From: Gilles Chanteperdrix [mailto:gilles.chanteperdrix@xenomai.org]
> Sent: Wednesday, July 31, 2013 2:22 PM
> To: George Pontis
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai] Permissions problem/interaction with udev on =
Xenomai
> current
>=20
> On 07/30/2013 12:19 AM, George Pontis wrote:
>=20
> > Permissions problem happening when building with the current git for
> Xenomai:
> >
> > for i in   vxworks psos rtai uitron vrtx ; do rm -f
> /home/gpontis/b2/g/output/target/usr/lib/lib$i.* ; if [ $i =3D=3D =
"posix" ] ; then rm
> -f /home/gpontis/b2/g/output/target/usr/lib/posix.wrappers ; fi ; done
> > if test -d /home/gpontis/b2/g/output/target/etc/udev/rules.d ; then =
for f in
> /home/gpontis/b2/g/output/build/xenomai-2.6/ksrc/nucleus/udev/*.rules =
; do
> cp $f /home/gpontis/b2/g/output/target/etc/udev/rules.d/ ; done ; fi;
> > cp: cannot create regular file
> `/home/gpontis/b2/g/output/target/etc/udev/rules.d/rtheap.rules':
> Permission denied
> > cp: cannot create regular file
> `/home/gpontis/b2/g/output/target/etc/udev/rules.d/rtpipe.rules': =
Permission
> denied
> > make: *** [/home/gpontis/b2/g/output/build/xenomai-
> 2.6/.stamp_target_installed] Error 1
> > gpontis@ubuntuVm:~/b2/g$
>=20
>=20
> Normally, this copy is run as root. Maybe you are trying to run "make
> install" on a directory through NFS with root squashing enabled on the
> server side?
>=20
> --
>                                                                  =
Gilles.

I could see running it as root if building and installing on the same =
computer. In my case the
build runs on a PC for an embedded target. There are many files that =
need to be handled
specially by the build environment. In my case this is buildroot, which =
tries to take care of
ownership and permissions when it creates a rootfs.tar.

I see that something is testing sudo and the build is interrupted until =
the users supplies
the password. And under some conditions the target directory =
etc/udev/rules.d is created
as being owned by me, other times as being owned by root. When it is =
owned by me, then
the build succeeds. I could make a patch for buildroot to apply to a =
Xenomai  makefile or
shell script. But I thought that I should ask before doing this, since =
we did not experience
this problem with xenomai current a couple of months ago.

George



