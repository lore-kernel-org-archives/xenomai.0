Message-ID: <4518F58A.5090900@domain.hid>
Date: Tue, 26 Sep 2006 11:40:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Help on debugger gdb
References: <45188502.4060209@domain.hid> <1159261731.5084.46.camel@domain.hid>
In-Reply-To: <1159261731.5084.46.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2D697736AED994E4DDE3EFA2"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D697736AED994E4DDE3EFA2
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Mon, 2006-09-25 at 22:40 -0300, Rodrigo Rosenfeld Rosas wrote:
>> Hi, it's me again, after a long while :)
>>
>> I'll present my Master thesis this Friday and I would like to comment =

>> about the debugger. Since I'm in hurry with a lot other issues, I do n=
ot=20
>> have to time to test what I'm going to ask.
>>
>> I've never used a debugger with Xenomai (or RTAI). I mean, not GDB. I =

>> used other techniques to debug, such as logging, etc. My doubt is:
>>
>> Suppose I have a user-space program with 3 independent Xenomai RT-task=
s.=20
>> If I put a breakpoint in one of them, will the other two keep running?=
 I=20
>> guess yes, but I'm not sure and that is why I'm asking.
>>
>=20
> Actually, they would not. The kernel would stop all of them as a
> consequence of ptracing, and Xenomai would switch them back to secondar=
y
> mode if needed, to let them handle the new situation properly.
>=20
>> Another thing. I think that the scheduler will keep counting the time =

>> when the debugger stopped the task. So, the next call to=20
>> rt_task_wait_period() will return -ETIMEDOUT immediately, with the=20
>> overruns set accordly, if this was the case, right?
>>
>=20
> No, the outstanding RT timers are globally frozen whenever a ptraced
> user-space task is stopped by the debugger, exactely to prevent the cas=
e
> you described, so that you can step into your application without
> causing such annoying side-effect. Since we are breakpointing/stepping
> into the code, real-time accuracy doesn't matter anyway, so we act as i=
f
> the timeline was being frozen each time the debugger holds the
> application.=20

Timers are frozen, but internal timekeeping continues, e.g. in
xnpod_wait_thread_period (which is used by rt_task_wait_period). So the
overrun counter is in fact incremented and an error is returned after
the interruption.

That raises the question for me if we shouldn't allow this freeze also
per-process in the future to confine the effect only to those programs
actually being debugged. I can easily imagine scenarios where the
developer might be more happy to keep other, fairly independent parts of
the system alive while stepping through one application.

Jan


--------------enig2D697736AED994E4DDE3EFA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFGPWKniDOoMHTA+kRAv8fAJwOSDIzwO2b+O2j1O4K6fIWUZLlCgCbBUwS
K2FmuRC281Kjw0QLhgQeOrw=
=QUQk
-----END PGP SIGNATURE-----

--------------enig2D697736AED994E4DDE3EFA2--

