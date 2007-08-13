Message-ID: <46C09773.5070607@domain.hid>
Date: Mon, 13 Aug 2007 19:40:03 +0200
MIME-Version: 1.0
References: <46C02829.9020009@domain.hid>
	<46C04384.4030805@domain.hid>	<46C05180.5090302@domain.hid>
	<46C05690.2010108@domain.hid> <46C063E0.1010809@domain.hid>
	<46C07005.8000504@domain.hid> <46C07EDC.4040305@domain.hid>
	<46C08D64.4050903@domain.hid>
In-Reply-To: <46C08D64.4050903@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] [Ethercatmaster-users] EML conflict with RTCAN?
 low_level_input	framebuilding failed.
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai-help@domain.hid, rtnet-users <rtnet-users@domain.hid>, EML users <ethercatmaster-users@domain.hid>

Hi Jan,


>> thus network buffer allocation is ought to run
>>> against the real-time rtskb pool - which is by default empty :p. See
>>> README.pools from the RTnet documentation on this.
I read this documentation. Together with an archive email of this list I 
  understand that if I load rtnet.ko like

insmod rtnet.ko rtskb_cache_size=64

(for the benfit of other poor souls in the future :))

it should help. And it does make a huge difference. Now instead of not 
giving a problem 1 out of 5 times its more like giving a problem 1 every 
10 times.

The 64 is a value I got from the mailing list. How large can I make this 
and what am I compromising?


>>> I don't have the EML design at hand, but you might be able to avoid this
>>> by initialising before creating the shadow task or by explicitly
>> In fact this is what I tried initially. IT does not work at all. so I
>> ended up initializing in the thread. Problem?
> 
> Not necessarily. But it would have been nice to report the other issue
> as well, because maybe there is something to be fixed (either in the
> code or in the docs). Initialisation almost always happens in non-RT
> context, and you shouldn't be force to do this under RT constraints. If
> this is an RTnet and/or EML problem, please report it on the related lists!
Will do so with your compliments and regards. :) I tried to initialize 
like I initialize rtcan in non-rt but it really does not work.


> Did you set the rtskb_cache_size module parameter for the rtnet.ko? Did
> you choose it appropriately large so that buffer pool do not exhaust if
> RTnet is blocked by other system activity? Again, check the documentation.
As stated, this seems to mitigate the problem. What is not clear to me 
is why the default of the rtskb pool is zero?

Roland.

> 
> Jan
> 

