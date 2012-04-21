Message-ID: <4F93208F.4040600@domain.hid>
Date: Sat, 21 Apr 2012 23:03:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.0.1334997334.18156.xenomai@xenomai.org>
	<4F931496.1060607@domain.hid>
In-Reply-To: <4F931496.1060607@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] linux 2.6.11
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenophile <xenophile@domain.hid>
Cc: xenomai@xenomai.org

On 04/21/2012 10:12 PM, xenophile wrote:
> Hi,
> 
> I am trying to see why a trivial driver reading an ADC on an EP9312 ARM 
> board has slowed by a factor of three. Since I installed it under 2.6.29 
> a couple fo years ago.
> 
> It's looking like this is due to a kernel update I did in the mean time 
> to 2.6.32

If the kernel is patched with Xenomai, did you check that you have the
same setting for FCSE ? Other than that, you can have an idea of how the
time is spent in both cases using the I-pipe tracer.

> Would there be any value in trying to rebuild a 2.6.11 based system for 
> realtime work ?

xenomai comes with a latency test that you can run on any two
configuration to compare their latencies. If you go on the adeos project
download area:
http://download.gna.org/adeos/patches/

You will find kernel patches for versions such as 2.6.13 or 2.6.14, they
are supposed to work with xenomai latest stable release. You can even
find patches for 2.4 kernels for i386 and ppc.

Chances are however that these patches have bugs which have been fixed
since then (after all, 2.6.11 is 7 years old).

-- 
                                                                Gilles.

