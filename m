From: "George Pontis" <gpontis@z9.com>
Date: Mon, 29 Jul 2013 15:19:04 -0700
Message-ID: <004401ce8ca9$a2ad4870$e807d950$@z9.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
Subject: [Xenomai] Permissions problem/interaction with udev on Xenomai
	current
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Permissions problem happening when building with the current git for =
Xenomai:

for i in   vxworks psos rtai uitron vrtx ; do rm -f =
/home/gpontis/b2/g/output/target/usr/lib/lib$i.* ; if [ $i =3D=3D =
"posix" ] ; then rm -f =
/home/gpontis/b2/g/output/target/usr/lib/posix.wrappers ; fi ; done
if test -d /home/gpontis/b2/g/output/target/etc/udev/rules.d ; then for =
f in =
/home/gpontis/b2/g/output/build/xenomai-2.6/ksrc/nucleus/udev/*.rules ; =
do cp $f /home/gpontis/b2/g/output/target/etc/udev/rules.d/ ; done ; fi;
cp: cannot create regular file =
`/home/gpontis/b2/g/output/target/etc/udev/rules.d/rtheap.rules': =
Permission denied
cp: cannot create regular file =
`/home/gpontis/b2/g/output/target/etc/udev/rules.d/rtpipe.rules': =
Permission denied
make: *** =
[/home/gpontis/b2/g/output/build/xenomai-2.6/.stamp_target_installed] =
Error 1
gpontis@ubuntuVm:~/b2/g$





