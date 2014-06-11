Message-ID: <5398A61D.3030204@xenomai.org>
Date: Wed, 11 Jun 2014 20:55:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140606135912.GJ5765@lukather> <20140606140031.GK5765@lukather>
 <539322FA.5030004@xenomai.org> <20140610094057.GJ9791@lukather>
 <5396D469.7060701@xenomai.org> <20140610095422.GK9791@lukather>
 <5396D780.4020704@xenomai.org> <20140611092532.GE4254@lukather>
 <53989CEF.3080205@xenomai.org>
In-Reply-To: <53989CEF.3080205@xenomai.org>
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

On 06/11/2014 08:16 PM, Gilles Chanteperdrix wrote:
> On 06/11/2014 11:25 AM, Maxime Ripard wrote:
>> On Tue, Jun 10, 2014 at 12:01:36PM +0200, Gilles Chanteperdrix 
>> wrote:
>>> If you compile the kernel without I-pipe and Xenomai support
>>> and enable the tcb_clksrc clocksource driver does it work?
> 
>> Yep, with the exact same config, except for CONFIG_IPIPE and 
>> CONFIG_XENOMAI being disabled, it boots fine.
> 
> Read again, I am not insterested in exactly the same config, I am 
> interested in the a config with tcb_clksrc clocksource, which is 
> disabled by CONFIG_IPIPE. Only if you enable this clocksource do
> you get to use the atmel_tclib code.

The corresponding config option is:
CONFIG_ATMEL_TCB_CLKSRC

- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFTmKYdGpcgE6m/fboRAjAeAJ9TgL0dxVm0pUl+jOCber1VGy5K7QCdFTRS
L55laOAlOFDmhzGeYx7o5mw=
=1JO0
-----END PGP SIGNATURE-----

