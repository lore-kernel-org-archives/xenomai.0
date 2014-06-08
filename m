Message-ID: <5394652C.3030101@xenomai.org>
Date: Sun, 08 Jun 2014 15:29:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140606135912.GJ5765@lukather>
In-Reply-To: <20140606135912.GJ5765@lukather>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai on Atmel SAMA5D3 with a 3.14 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Michael Opdenacker <michael@free-electrons.com>, Thomas Petazzoni <thomas@free-electrons.com>, Boris Brezillon <boris@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, xenomai@xenomai.org, =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine@free-electrons.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/06/2014 03:59 PM, Maxime Ripard wrote:
> Hi Gilles,
> 
> I've been experimenting these days with the i-pipe 3.14 kernel,
> and current xenomai master branch on the Atmel SAMA5D3 SoC.

Maybe the cortex A5 has some integrated timers, like A9, which would
be certainly more interesting to use than a TC. The TC is a 16 bits
free-running counter which we have to run at a low frequency (as close
as possible to 1 MHz) to avoid it to wrap too fast.

- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFTlGUsGpcgE6m/fboRAvsAAJ9+uXUZ65m6ugesmxrtcftEusWiBACfV9H3
JcUDQU0g2fnyiaALPJU6uos=
=2Hdm
-----END PGP SIGNATURE-----

