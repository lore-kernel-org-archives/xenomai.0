Message-ID: <4AF6AA34.3040308@domain.hid>
Date: Sun, 08 Nov 2009 12:23:32 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <47a3101a0911070704o5307a23dhef368d04cc25fc6@domain.hid>
	<4AF59B0F.1020300@domain.hid>
	<47a3101a0911072306g42ddc0dfld0571e04fe1bf18b@domain.hid>
In-Reply-To: <47a3101a0911072306g42ddc0dfld0571e04fe1bf18b@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Gumstix arm pxa
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Linus Casassa <linus@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Linus Casassa wrote:
> I applied the patch but I don't see difference.

You should use the patch if you want to use an older version of Xenomai.
If you want to use Xenomai 2.4.9.1 you have to use one of the patches it
contains.

Please do that, and test with the "latency" tests included in xenomai to
know if your system works correctly.

> So I remember that there is a tick argument for the skin. By default it is
> 1000 so I try with 40.
> 
> modprobe xeno_native tick_arg=40

No, by default, the skins run in aperiodic mode.

> 
> And now for the same period I get a bigger number in ticks
> 
> I can get up to 1,3 ms!! :D
> 
> I steel don't understand the ticks on xenomai. Where can find info?
> What is the disadvantage on a small tick_arg?

Periodic ticks are the old ways of handling timer in operating systems.
The higher the period, the higher the overhead. However, Xenomai
proposes you an aperiodic mode, which is the default.


-- 
					    Gilles.

