From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <AANLkTi=EDSiKDiHyvZ8LpqBC9AAHL+6i=goa4r-rZyJU@mail.gmail.com>
References: <AANLkTi=EDSiKDiHyvZ8LpqBC9AAHL+6i=goa4r-rZyJU@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 20 Aug 2010 11:59:01 +0200
Message-ID: <1282298341.1730.555.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] pthread_make_periodic_np
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: ramon costa <ramoncostacastello@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Fri, 2010-08-20 at 11:21 +0200, ramon costa wrote:
> Hi,
>=20
> In the xenomai manual (POSIX skin) the command
> pthread_make_periodic_np is introduced.
>=20
> When I compile the file I obtain the following error :
>=20
> p1_xn_parallel.c:32: warning: implicit declaration of function
> =E2=80=98pthread_make_periodic_np=E2=80=99
> p1_xn_parallel.c:53: warning: implicit declaration of function
> =E2=80=98pthread_wait_np=E2=80=99
>=20
> Is this command available ?

> Which .h should I include ?

Try: grep -r pthread_wait_np /usr/xenomai/include/posix

You should check your Makefile as well:
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Comp=
ilation_for_the_Xenomai_POSIX_skin.

>=20
> Thanks
> Ramon
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

--=20
Philippe.



