Message-ID: <4F93E9E6.4070604@domain.hid>
Date: Sun, 22 Apr 2012 13:22:14 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.0.1334997334.18156.xenomai@xenomai.org>	<4F931496.1060607@domain.hid>
	<4F93208F.4040600@domain.hid> <4F93A3EA.7010802@domain.hid>
In-Reply-To: <4F93A3EA.7010802@domain.hid>
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

On 04/22/2012 08:23 AM, xenophile wrote:
> I'm interested in exploring RT on this hardware and part of the change 
> of kernel was to move to more recent kernel which has better support for 
> this board and to find a kernel that has been used RT with this type of 
> hardware so that I don't have to start from scratch.
> 
> Yesterday I tested 2.6.33 and it was equally slow. I need to find out if 
> this is due to kernel version or gcc. (4.3.4)
> 
> I need to resolve the cause of this factor of 2 or 3 slow down before I 
> get involved in xenomia patching so as to start from a sound base.

Well, given the way xenomai works, we do not depend much on the linux
performances. So, if you want to compare something, it should be the
xenomai latency differences between the two kernel versions. Using linux
performance to get an idea of xenomai performance does not really make
any sense.

To give you just an example, at some point around 2.6.30, the linux
kernel introduced threaded interrupts, which greatly increase interrupt
latencies. Xenomai does not use threaded interrupts, so it is
essentially unaffected by the change.

Of course there are some indirect effect such as the size of the kernel,
which has an impact on I-cache and so on the latency.

> Thanks, I was hoping to find some comments on which kernels are more 
> responsive. I'm sure there's good and bad since RT is not one of the 
> main priorities for kernel development, this may not be a case of the 
> most recent being the best.
> 
>  From a simple user experience circa 2.6.11 was hugely more responsive 
> than the more recent offerings. Maybe 2.6.13 or 2.6.14 are close enough 
> to be in the same league.
> 
> I would have thought this sort of thing would have been thoroughly 
> investigated by RT people and would be documented.

We run xenomai, so, what we investigate are xenomai performances. On a
system running xenomai, the performance-sensitive job is done by
xenomai, not by linux anyway. And we check between two releases that we
do not get differences in performances. So, I am pretty sure that on
at91rm9200 for instance (the platform I have which should be the closest
to an EP9312), the xenomai user-space latency from 2.6.29 to 3.2.1 is
around 220us.

Besides, in terms of performance, the relation performance/version
probably also depends on the platform which is running the kernel. So
for instance, you may have found that 2.6.11 was good on x86, but maybe
it sucked on ARM.

Apart from that, as I already said, we provide you with:
- the latest version of xenomai which should supports all past kernel
versions
- the tools to do the performance measurement.

So, you have everything you need to do the comparison.

-- 
                                                                Gilles.

