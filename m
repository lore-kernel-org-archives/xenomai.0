From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] Cosmetic changes to script xeno-config + man page
Date: Wed, 19 Oct 2005 13:53:10 +0900
References: <200510170157.58507.rlenglet@domain.hid>
	<200510181759.22534.rlenglet@domain.hid>
	<17237.12533.38471.80992@domain.hid>
In-Reply-To: <17237.12533.38471.80992@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200510191353.10936.rlenglet@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

> =A0> A simpler solution would be to ship a xenomai.m4 to be used
> =A0> as a acinclude.m4 in every project using Xenomai. But I
> =A0> have had very bad experiences with aclocal in that use
> =A0> case. aclocal is quite buggy. And it would be more
> =A0> confortable for projects it is were immediately available
> =A0> after installing Xenomai.
>
> Yes, this was the original plan, but there are still many
> things on our todo list before that.

I found a better solution, that could be a replacement for both a=20
xenomai.m4 trick, and the xeno-config script: pkg-config.
http://pkgconfig.freedesktop.org/wiki/
There are packages for pkgconfig in both Debian and RedHat,=20
AFAIK, and surely for all other distribs.

I will look into making a xenomai.pc file.


> DESTDIR is used by xeno-config the same way it is used by
> Makefiles. When you compiled Xenomai for a target and
> installed it with DESTDIR=3D/home/romain/target, you have to set
> DESTDIR in xeno-config environment =A0so that it outputs
> -I/home/romain/target/usr/realtime/include and
> -L/home/romain/target/usr/realtimeLib.
>
> Since it is a rather obscure functionality, it probably
> deserves an explanation.

Ok, done. Please apply patches #472 and #474:
https://gna.org/patch/index.php?func=3Ddetailitem&item_id=3D472
https://gna.org/patch/index.php?func=3Ddetailitem&item_id=3D474

=2D-=20
Romain Lenglet

