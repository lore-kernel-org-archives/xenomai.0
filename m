Subject: Re: [Xenomai-core] Xenomai on PXA255
From: Stelian Pop <stelian.pop@domain.hid>
In-Reply-To: <17531.5942.353611.748409@domain.hid>
References: <1148554757.9498.19.camel@domain.hid>
	<17530.65147.519598.892978@domain.hid>
	<1148912044.9574.30.camel@domain.hid>
	<1148913934.5494.15.camel@domain.hid>
	<17531.5942.353611.748409@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 29 May 2006 21:17:55 +0200
Message-Id: <1148930275.3483.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Le lundi 29 mai 2006 =E0 17:45 +0200, Gilles Chanteperdrix a =E9crit :
> Stelian Pop wrote:
>  > If you have specific questions feel free to ask. But I suggest you r=
ead
>  > and try to understand the code first.
>=20
> Maybe we could provide a quick overview of how this works, Stelian,
> please correct me if I am wrong.=20

Your description is accurate. However, such deep knowledge on the inner
workings should not be needed to port Xenomai to a new ARM platform.
(well, in case it works immediately. Debugging the port could need more
knowledge :) ).

In the list of 'undocumented' functions there is also
__ipipe_mach_get_tsc() which should return some accurate time
information. Most of the ARM platforms do not have a special Time Stamp
Clock register, so most of the time the tick count is used instead
(giving a TSC resolution of one microsecond). This is what standard
Linux also use.

If the platform has something more appropriate than the core timer for
measuring the time, this function is where you need to wire it.

Stelian.
--=20
Stelian Pop <stelian.pop@domain.hid>
Open Wide


