Message-ID: <459B7D71.40808@domain.hid>
Date: Wed, 03 Jan 2007 10:54:57 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] recommendations for new computer
References: <2571.74.57.109.247.1167253824.squirrel@domain.hid>
In-Reply-To: <2571.74.57.109.247.1167253824.squirrel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: vleves@domain.hid
Cc: xenomai@xenomai.org

vleves@domain.hid wrote:
> Hello all,
> 
> I'm about to buy a new computer and I'd like to make sure that it will
> work with Xenomai (although it won't be its primary use). I'm hesitating
> between building a Core 2 Duo PC or buying a Mac. Are there any
> limitations with respect to Xenomai that I should be aware of? Does anyone
> have experience installing Linux and Xenomai on an intel Mac?

I would expect xenomai to run on a core 2 duo: I am using it on a core
duo and it seems to work correctly. The only oddity I observed on this
platform is the fact that all interrupts go to CPU 0, even if I disable
IRQ balancing. This platform also has the option "constant_tsc"
displayed in /proc/cpuinfo, it seems to mean that the tsc frequency does
not change when the CPU frequency changes, so it is possible to use
xenomai with cpufreq. I have no experience with intel macs.

-- 
                                                 Gilles Chanteperdrix

