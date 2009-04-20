Date: Mon, 20 Apr 2009 11:46:07 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
In-Reply-To: <49ECC04C.10708@domain.hid>
Message-ID: <Pine.LNX.4.64.0904201139480.23588@domain.hid>
References: <Pine.LNX.4.64.0904201026330.23588@domain.hid>
	<49ECC04C.10708@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: Re: [Xenomai-help] Tests with 2.5rc1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


On Mon, 20 Apr 2009, Gilles Chanteperdrix wrote:
>>     clock lost seconds of time.  It froze many times during the
>>     switchbench part of xeno-test, without any complaints from Xenomai
>
> The freeze during switchbench is normal. There should be a message
> telling you so and telling you not to try and interrupt switchbench.

These weren't the normal switchbench freezes, but rather indefinite
freezes that stopped the clock, made pings from other machines fail,
and that never ended until I went to the offending computer and either
moved its mouse, hit any keyboard key, or pressed the power-button
momentarily. I sometimes left it a few hours in that frozen state
while I worked on other things on another computer.

Martin

