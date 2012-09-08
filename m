Message-ID: <504AE348.8060407@xenomai.org>
Date: Sat, 08 Sep 2012 08:18:48 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANKLDmsO-1E7+d9X6-t532RJ=CWY4P4x30nCNCwgHffJjAFkDA@mail.gmail.com>	<50460BCE.8010505@xenomai.org>	<CANKLDmtmnbAb7PM4URTjxYtaH5WnvGjVcEPOpSNr2A6gPwLLaA@mail.gmail.com>	<50464969.2000902@xenomai.org>
	<50464BED.7020209@xenomai.org>
In-Reply-To: <50464BED.7020209@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel NULL pointer dereference
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henri Roosen <henriroosen@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 09/04/2012 08:43 PM, Gilles Chanteperdrix wrote:

> When the local timer interrupt happens for a non supported cpus, how
> does it get propagated to the root domain?


Ok. Got it now. Before the I-pipe core, Xenomai was reprogramming the
APIC of the cpus in rthal_supported_cpu to use a different vector for
the local timer irq. So, no propagaction was needed. We simply need the
I-pipe core APIC timer initialization function to do the same thing.

-- 
                                                                Gilles.

