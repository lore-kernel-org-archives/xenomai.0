Message-ID: <4AC5AD7C.7010208@domain.hid>
Date: Fri, 02 Oct 2009 09:36:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <71396b5b0910010109h5cb5912el7eee9d071ed23cda@domain.hid>
	<71396b5b0910020021n44f2bc22md97b14e389128486@domain.hid>
In-Reply-To: <71396b5b0910020021n44f2bc22md97b14e389128486@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Strange issue : high latency for kernel task
 when a	user task is stop
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles FRITZ <gillou365@domain.hid>
Cc: xenomai@xenomai.org

Gilles FRITZ wrote:
> Hi,
>=20
> I use Xenomai since not very long, but I have seen a strange behavior :=
 when
> I stop a user-space task, my in-kernel task have a latency of about 500=
=C2=B5s.
>=20
> I have observed that on Xenomai 2.4.8 and 2.3.4, on kernel 2.6.25.19 an=
d
> 2.6.28.9.
>=20
> To observe that, I launch two latency test : one in user-space and the
> second in kernel-space
> latency -p 50 -t 1
> latency -p 70
>=20
> When I stop the second latency (in user-space), I can observe a latency=
 of
> at least 500ms in the in-kernel task.
>=20
> I do not know if this is normal or not.
>=20
> Have you an explanation for that?

I do not think we have but:
- 50us and 70us are a bit short periods depending on the platform
(though it should not change anything to use larger periods), and you
did not tell us on what platform you are running xenomai
- the I-pipe patch proposes an option, the I-pipe tracer, which will
tell you exactly what happens during these 500us.

--=20
					    Gilles.


