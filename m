Message-ID: <4FD0E198.7000606@xenomai.org>
Date: Thu, 07 Jun 2012 19:15:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4FBCB442.5030208@wanadoo.fr> <4FBCB64E.6090209@xenomai.org>
	<4FBCB89A.9090801@wanadoo.fr> <4FBCD8EC.60305@xenomai.org>
	<4FD0DF23.2030909@wanadoo.fr>
In-Reply-To: <4FD0DF23.2030909@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] iMX6 support
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Thierry Bultel <thierry.bultel@wanadoo.fr>
Cc: xenomai@xenomai.org

On 06/07/2012 07:04 PM, Thierry Bultel wrote:
> Hi,
> I have another question about the iMX6,
> it is about the TSC emulation .
> 
> I have been told that the Pentium TSC could not be accurate enough
> for a one of our application that performs high precision data acquisition.
> 
> Can we expect a better accuracy with the TSC emulation based
> on the ARM timer or not ?

Xenomai tsc emulation is usually based on a hardware timer which has a
lower frequency than the core. On cortex A9 cores, we use the "global
timer". On imx6q, this timer frequency should be around 500MHz, from the
top of my head.

Anyway, if you require a precision better than the processor cycle, then
you should not use the processor to do the measurement. Because for
instance, simply reading the TSC has a latency. This latency is around
10 cycles on mx6q (I am talking about 500 MHz cycles, not processor
cycles). And at that level, you should also account for the processor
intrinsic lack of determinism, with such things as pipeline stalls. So,
you simply can not achieve a better precision than the TSC when
measuring with a processor.

> 
> Is this based on the CCNT that is cycle-accurate ?

No, it is based on the cortex a9 "global timer". I am sure we can read
this one from user-space, I am not sure we can read CCNT from user-space.

-- 
					    Gilles.

