MIME-Version: 1.0
In-Reply-To: <4AF82BFA.1080903@domain.hid>
References: <ddc6e05e0911090400r37e0160aha2c3088dc673c0aa@domain.hid>
	<4AF813D2.2000001@domain.hid>
	<ddc6e05e0911090622m52d0297fo24061b6bea475a8e@domain.hid>
	<ddc6e05e0911090623w67986d66u19b71995d9c9e92f@domain.hid>
	<4AF82BFA.1080903@domain.hid>
Date: Mon, 9 Nov 2009 16:20:57 +0100
Message-ID: <ddc6e05e0911090720h1c6087e9p5d51efeeb9fac3ed@domain.hid>
From: Remco den Breeje <remco@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] Context-sharing semaphores
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

On Mon, Nov 9, 2009 at 3:49 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
>
> Ah. Sorry. Found the bug in the mean time. It is in the Makefile. You do
> not pass the compilation flags for compilation for Xenomai posix skin.
> So, your user space application uses plain linux semaphores.

Ah, that makes sense.
I'm able to run my test-app after adding the posix flags.

Thanks a lot!

Remco

>
> See:
> doc/txt/pse51-skin.txt in xenomai sources
> or:
> http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Co=
mpilation_flags.
>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0Gilles
>
>

