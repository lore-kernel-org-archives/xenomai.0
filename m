Message-ID: <4EAE70C3.4040902@domain.hid>
Date: Mon, 31 Oct 2011 10:56:19 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAAeYjMmJ_LKimbvRsR5562MaYvrQGJkSx9jeP2RM3FQvewtg5Q@mail.gmail.com>
In-Reply-To: <CAAeYjMmJ_LKimbvRsR5562MaYvrQGJkSx9jeP2RM3FQvewtg5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] which skin to use
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?UTF-8?B?xYF1a2FzeiBTYWNoYQ==?= <dragilla@domain.hid>
Cc: xenomai@xenomai.org

On 10/30/2011 11:47 PM, =C5=81ukasz Sacha wrote:
> Hi,
> I'm working on a device that will process several input signals (2
> analog, about 4 digital and 1 over serial interface) do some
> calculations and control 4 uarts. It will also write some log data to
> a file on an sd card.
> It will probably be a single process working in an infinite loop,
> regularly, say 50 times per second or more.
> I'm a total beginner as it comes to RT and xenomai. I have some
> experience in wrinting programs in C/C++ for linux.
> Which API should do you think will be good for me to start with?
> Which would be better for the application that I want to write?

If you have programmed for linux, you know the posix api, so, using the
posix skin should be easy. The skins propose more or less the same
services, so, which skin you choose is a matter of taste, check the
doxygen documentation and choose the services you prefer.

--=20
                                                                Gilles.


