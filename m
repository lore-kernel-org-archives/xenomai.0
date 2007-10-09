Message-ID: <470B1CA2.8070509@domain.hid>
Date: Tue, 09 Oct 2007 08:16:02 +0200
MIME-Version: 1.0
References: <bc4264770710081022n71a97a91m6d839ab1e27cb54@domain.hid>	<470A6B28.7020009@domain.hid>
	<bc4264770710081116n5d49911ah6aa0831ebd9023ae@domain.hid>
	<470AB8DA.5000408@domain.hid>
In-Reply-To: <470AB8DA.5000408@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Subject: Re: [Xenomai-help] adeos patch for 2.6.21
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
To: Jan Kiszka <jan.kiszka@domain.hid>, Xenomai-help@domain.hid

Hi Jan,

>>> But note that we are still sweeping out remaining bugs around this
>>> kernel, see "Fix __ipipe_pin_range_globally" and "IO-APIC stall due to
>>> broken fasteoi handling" on Xenomai-core / Adeos-main. Moreover, today's

> Just checked again: The problem is still limited to kernels with
> CONFIG_HIGH_RES_TIMERS or CONFIG_NO_HZ. So you can already do your tests
> with those features disabled and the two mentioned patches applied.
I presume the "Fix __ipipe_pin_range_globally" and "IO-APIC stall due to
 >>> broken fasteoi handling" are the patches you are refering to. I 
also assume these have been posted on xenomai-core and/or adeos-main 
mailing list. If that is correct I am having some trouble locating them 
in the ML archives with the labels above. Any other manner I can get 
hold of those patches?

Regards,

Roland.


> 
> Jan
> 

