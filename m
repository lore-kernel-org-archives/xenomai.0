Message-ID: <49B0F2DD.5080507@domain.hid>
Date: Fri, 06 Mar 2009 10:54:37 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <76902d360903060146t677ab7a1y38a11273957b8c45@domain.hid>
In-Reply-To: <76902d360903060146t677ab7a1y38a11273957b8c45@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai and reading of linux files?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?Jens_K=F6hler?= <jenskxxx@domain.hid>
Cc: xenomai@xenomai.org

Jens K=F6hler wrote:
> Hello,
>=20
> I like to port a rtai application  to xenomai. The rtai application has=
 a
> user space part and a kernel module. Both communication together by rta=
i
> queues and a shared memory.
> Do I need for xenomai still queues? Or is it f.i. possible to read or w=
rite
> linux files from xenomai application without problems?

reading and writing will work, but will cause the thread which does it
to switch to secondary mode (if it is a real-time thread), so it may not
be what you want.

--=20
                                                 Gilles.


