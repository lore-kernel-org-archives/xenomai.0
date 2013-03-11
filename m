Message-ID: <513D8C24.4010009@xenomai.org>
Date: Mon, 11 Mar 2013 08:47:48 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <512BFD9E.5010501@crubille.lautre.net>
	<512BE5A2.3090505@xenomai.org>
	<513DA0B5.5060304@crubille.lautre.net>
In-Reply-To: <513DA0B5.5060304@crubille.lautre.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Linux port to ARM Allwinner A13
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Paul <paul@crubille.lautre.net>
Cc: xenomai@xenomai.org

On 03/11/2013 10:15 AM, Paul wrote:

> Hello,
> 
> Here are pre and post patch for xenomai on sun5i (allwinner A13). It
> should work for sun4i (allwinner A10) too, but is not tested for this
>  proc.
> 
> The tested kernels are
> 
> wget 
> https://github.com/linux-sunxi/linux-sunxi/archive/sunxi-v3.4.24-r1.tar.gz
>
> 


and

> wget 
> https://github.com/linux-sunxi/linux-sunxi/archive/sunxi-v3.4.24-r2.tar.gz




Fine,

> 


but the pre patch touches a lot of things which I believe it
should not be touching, like entry.S.

Is it because your patch is based on 3.2.24 and not 3.2.21? If that is
the case, the post patch should undo the changes made by the pre patch.

The coding style you use is not really the kernel coding style, see:
Documentation/CodingStyle

For sunxi_enable_irqdesc/sunxi_disable_irqdesc, you could use a switch
case, or even better, define a macro SW_INT_SRCPRIO_REG(n) that gives
the address of the nth register, and avoid the ifs completely.

You do not need to manually call enable_irqdesc for the timer irq, it
should be called automatically. Maybe your problem is that your
"pic_muter_init" function is called too late, if that is the case, you
should call it in the function which declares the Linux timer, this one
should be called early enough.

ipipe_ns_delay is ugly, you  can probably get away much more simply with
ipipe_tsc_get, or can not you simply wait for a PLL lock bit or
somehting? If you want to maintain ipipe_ns_delay, plase call it
ipipe_mach_something, and fix the coding style.

Please avoid dead code, and C++ comments. And the cartouches.

> 
> It implement priority interrupt masking.
> 
> I check the priority masking with a preempt test which is derived
> from the latency test: The real time task loop for 1/4 of its period
> reading and rereading the clock, so i get the min, avg and worst case
> that the task can be preempted while it is running.


> 
> If you are interested in this test, i can post it when I have
> modified the output messages.



I do not really understand. Why would it be more preempted in the first
1/4 of its period?


-- 
                                                                Gilles.

