Message-ID: <4E806651.7040204@domain.hid>
Date: Mon, 26 Sep 2011 13:47:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAL7_A_VgBKS_dkzSTSE8M8d1TZQ+DLGoM-M7uM3OD4MW=aff9A@mail.gmail.com>
In-Reply-To: <CAL7_A_VgBKS_dkzSTSE8M8d1TZQ+DLGoM-M7uM3OD4MW=aff9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] timestamping of events in a xenomai task?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?SmVucyBLw7ZobGVy?= <jenskxxx@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On 09/26/2011 11:13 AM, Jens K=C3=B6hler wrote:
> Hello,
>=20
> I have a computer where time is synchronized by ntp. In a xenomai task =
I
> like to time stamp external events. What is best way to read linux syst=
em
> time in a Xenomai task?
>=20
> Does function *int ftime(struct timeb ***tp**);* works?

ftime documentation says:
This  function is obsolete.  Don't use it.  If the time in seconds suf=E2=
=80=90
fices,  time(2)  can  be  used;  gettimeofday(2)  gives   microseconds;
clock_gettime(2) gives nanoseconds but is not as widely available.

In order to solve this particular issue, a new clock was introduced in
Xenomai 2.6.0: CLOCK_HOST_REALTIME to be used with Xenomai posix skin
clock_gettime service. It requires a compatible I-pipe patch, currently
only available for x86 and ARM. Note that CLOCK_HOST_REALTIME can only
be used for timestamping, not for timers.

Xenomai 2.6.0 was not yet released, but you can try 2.6.0-rc3 in the
mean time.

--=20
					    Gilles.


