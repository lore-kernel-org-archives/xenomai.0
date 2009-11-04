Message-ID: <4AF1C4B1.3020400@domain.hid>
Date: Wed, 04 Nov 2009 19:15:13 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <45435.172.20.62.191.1257358048.squirrel@domain.hid>
In-Reply-To: <45435.172.20.62.191.1257358048.squirrel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] Error in pthread_make_periodic_np
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: =?UTF-8?B?UnViw6luIEdvbnrDoWxleiBkZWwgUG96bw==?= <rubengp@domain.hid>
Cc: xenomai@xenomai.org

Rub=C3=A9n Gonz=C3=A1lez del Pozo wrote:
> Hello all,
> I am working with Xenomai 2.4.9.1 on Kernel 2.6.30. I try to test the
> pperiodic example and I always get the error code 3 in
> pthread_make_periodic_np function: ESRCH -> invalid thread.
> Why I get that code?
> Thanks a lot,

It is hard to say why it fails, with such a sloppy code. Please check
the return values of ALL the posix services, not only
pthread_make_periodic_np.

--=20
					    Gilles.


