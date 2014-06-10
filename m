Message-ID: <5396C664.4080202@xenomai.org>
Date: Tue, 10 Jun 2014 10:48:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140606135912.GJ5765@lukather> <5391FFCD.3010505@xenomai.org>
 <20140610081940.GG9791@lukather>
In-Reply-To: <20140610081940.GG9791@lukather>
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

On 06/10/2014 10:19 AM, Maxime Ripard wrote:
> On Fri, Jun 06, 2014 at 07:52:13PM +0200, Gilles Chanteperdrix
> wrote:
>> On 06/06/2014 03:59 PM, Maxime Ripard wrote:
>>> Hi Gilles,
>>> 
>>> I've been experimenting these days with the i-pipe 3.14
>>> kernel, and current xenomai master branch on the Atmel SAMA5D3
>>> SoC.
>>> 
>>> There's a few issues there, the first one being that 
>>> at91_ipipe_early_init crashes because of a NULL pointer 
>>> dereference. This is due to the clk_get_rate call on the clock
>>>  returned by clk_get(NULL, "mck").
>>> 
>>> This clk_get call cannot since 3.14 because the clock code has 
>>> been rewritten, and you can't use clkdev anymore.
>> 
>> Well, it works on AT91. (RM9200 and SMA9263). What you are doing
>> with SAMA5D3 here is actually a port to a new platform.
> 
> Not really. The SAMA5D3 is the latest evolution of the AT91, and
> the only major difference is that it's now using a Cortex-A5, but
> it's mostly the same.
> 
> The only major difference I can find is that like all the recent
> AT91 SoCs, it's using the common clock framework in Linux, while
> the 9200 and the 9263 are still using the old API.

What I mean is that from the I-pipe patch point of view, this is a new
processor, and you should not presume too much. Also note that since
3.14, the I-pipe patch uses the atmel tclib
(drivers/misc/atmel_tclib.c), which uses clk_get and friends, so, if
clk_get does not work for this new processor, the tclib will not work
either.


- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFTlsZkGpcgE6m/fboRAuTkAJ4/nRXsSenQLiY1Itg0Zi9P4kzjBACfX6vl
WP6TyMkZUC7ZG2W31q/EG6k=
=WXmJ
-----END PGP SIGNATURE-----

