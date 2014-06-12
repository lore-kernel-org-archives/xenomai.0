Message-ID: <539966B7.3080900@xenomai.org>
Date: Thu, 12 Jun 2014 10:37:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140606135912.GJ5765@lukather> <20140606140031.GK5765@lukather>
 <539322FA.5030004@xenomai.org> <20140610094057.GJ9791@lukather>
 <5396D469.7060701@xenomai.org> <20140610095422.GK9791@lukather>
 <5396D780.4020704@xenomai.org> <20140611092532.GE4254@lukather>
 <53989CEF.3080205@xenomai.org> <20140612075401.GH4254@lukather>
In-Reply-To: <20140612075401.GH4254@lukather>
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

On 06/12/2014 09:54 AM, Maxime Ripard wrote:
> On Wed, Jun 11, 2014 at 08:16:15PM +0200, Gilles Chanteperdrix
> wrote:
>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
>> 
>> On 06/11/2014 11:25 AM, Maxime Ripard wrote:
>>> On Tue, Jun 10, 2014 at 12:01:36PM +0200, Gilles Chanteperdrix 
>>> wrote:
>>>> If you compile the kernel without I-pipe and Xenomai support
>>>> and enable the tcb_clksrc clocksource driver does it work?
>>> 
>>> Yep, with the exact same config, except for CONFIG_IPIPE and 
>>> CONFIG_XENOMAI being disabled, it boots fine.
>>> 
>> Read again, I am not insterested in exactly the same config, I
>> am interested in the a config with tcb_clksrc clocksource, which
>> is disabled by CONFIG_IPIPE. Only if you enable this clocksource
>> do you get to use the atmel_tclib code.
> 
> Let me rephrase then. It works with the exact same config, with 
> CONFIG_IPIPE and CONFIG_XENOMAI disabled, and
> CONFIG_ATMEL_TCB_CLKSRC enabled.

Then I would tend to think that the clocksource is not your problem
and repeat that you should check everything else in the porting guide.

> 
>> Also, it would be nice if you could subscribe to the mailing
>> list, (and bounce all the messages you have sent so far to the
>> mailing list), so that mailing list users do not read only my
>> answers. Otherwise what you do is equivalent to using my personal
>> e-mail address for Xenomai questions, and usually, I do not
>> answer such questions.
> 
> Done.


Thanks.


- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFTmWa3GpcgE6m/fboRAje5AKCaWLggwYx8nCybNJOEKyiLXva23QCgmzVh
Zv2PM8L9khkowVFrqQYNz1A=
=Sy3S
-----END PGP SIGNATURE-----

