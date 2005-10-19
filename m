Message-ID: <4356860F.9030906@domain.hid>
Date: Wed, 19 Oct 2005 19:44:47 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] newbie question
References: <4353F109.7000707@domain.hid>	<4353F411.4000500@domain.hid>	<4353F896.1040508@domain.hid>	<435402B4.5060004@domain.hid>	<435403C8.80400@domain.hid>	<43540531.8050304@domain.hid>	<435406E0.8020405@domain.hid>	<435408E5.8020007@domain.hid>	<435419B0.8030004@domain.hid>	<4354AD5A.7010305@domain.hid>	<17237.13723.766826.515585@domain.hid>	<43553F22.80805@domain.hid>	<17237.19216.373031.430361@domain.hid>	<43554BD2.1050305@domain.hid>	<17237.20014.842135.310718@domain.hid>	<43555065.40704@domain.hid>	<435605E7.90201@domain.hid>
	<43567F17.2020302@domain.hid>
In-Reply-To: <43567F17.2020302@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-15?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

Ignacio Garc=EDa P=E9rez wrote:
> Hi,
>=20
> I'm quite new to xenomai (switching from RTAI). I noticed that the
> latency_rt.ko module fails to start the timer if the posix skin module
> (xeno_posix.ko) is loaded. Is this the expected behaviour?
>

Yes and no. There is a change pending in my tree that makes rt_time_start=
() a=20
bit smarter, trying its best effort to check whether the requested settin=
g fits=20
any current one, in which case the call returns without error. In the cas=
e you=20
mentioned, both timer setups at nucleus level asked for oneshot, so this =
should=20
have been ok with this patch, instead of bailing out on error rather usel=
essly.=20
The UVM skin already enforces this for instance. I have just committed it=
 to the=20
SVN repo.

But on the long-term, I recall that Jan once asked for a normalized appro=
ach,=20
allowing the timer to be set at configuration/loadup time for each skin, =
just=20
keeping the system call as is for legacy/unusual/dynamic purposes. I agre=
e with=20
that, most of us don't really need to fiddle with the timer settings whil=
e the=20
application runs, so having it statically configurable is more user-frien=
dly and=20
less error-prone.

--=20

Philippe.

