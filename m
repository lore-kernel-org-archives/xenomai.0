Message-ID: <49E24A32.9050200@domain.hid>
Date: Sun, 12 Apr 2009 22:08:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <d6c8ef150904101628r60c02baal3568b2ece287ce1f@domain.hid>
In-Reply-To: <d6c8ef150904101628r60c02baal3568b2ece287ce1f@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Intel EP80579 support
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Bosko Radivojevic wrote:
> Hi all,
> 
> I'm quite new in anything related to Intel and Xenomai on it, so I'm
> sorry if my question(s) may sound silly ;) I hope some experience I
> have after 1 year of dealing with Xenomai on ARM will help me.
> 
> Anyway, I have Megrez+Mizar evaluation kit, which consist of Mergez
> (Development Board) and Mizar (Intel EP80579 Module):
> - http://www.m31.com/en/m31-projects-embedded-solutions/prodotti/megrez-evaluation-board.html
> - http://www.m31.com/en/m31-projects-embedded-solutions/prodotti/mizar-intel-ep80579-module.html
> - http://www.intel.com/design/intarch/devkits/ep80579/index.htm
> 
> Before I understand what is the status of vanila Linux support (I got
> 2.6.18 kernel in the kit, latest drivers on Intel's web are also for
> 2.6.18), I'm wondering if latest Xenomai/Adeos will work on this
> platform?

Ah! It is the thing once named "tolapai", right? I once saw a
presentation which said that the tolapai could not do bus master DMA on
the PCI bus for other peripherals than the built-in ones (so, for
instance, if you want to add a Wifi card, you have to use copy packets
around). I had no confirmation of this information, but if it is true, I
think it really cripples this processor.

-- 
					    Gilles.

