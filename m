Message-ID: <4F5F392D.4050506@domain.hid>
Date: Tue, 13 Mar 2012 13:10:21 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F50A422.50208@domain.hid>
	<4F55C306.8020307@domain.hid>	<4F55D765.7040705@domain.hid>
	<4F55E390.8090706@domain.hid>	<4F55FE81.6000904@domain.hid>
	<4F560A6C.2080306@domain.hid>	<4F560B76.5080606@domain.hid>
	<4F5629D2.50304@domain.hid>	<4F562B53.7070400@domain.hid>
	<4F562EC2.6040604@domain.hid>	<4F56387B.40702@domain.hid>
	<4F575BA3.7060404@domain.hid>	<4F576622.1030509@domain.hid>
	<4F57A567.7030008@domain.hid> <4F5F3301.8020807@domain.hid>
In-Reply-To: <4F5F3301.8020807@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] preemptive doesn't work
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Roberto Bielli <roberto.bielli@domain.hid>
Cc: xenomai@xenomai.org

On 03/13/2012 12:44 PM, Gilles Chanteperdrix wrote:
> On 03/07/2012 07:13 PM, Roberto Bielli wrote:
>> Hi Gilles,
>>
>> this is the trace and the test.
>>
>> It seems that '__ipipe_dispatch_event' last about ~84 milliseconds with 
>> disable interrupts.
> 
> Sorry, I somehow missed this post.
> 
> I am afraid you are mis-reading the trace. The time spent in user-space
> gets accounted to __ipipe_dispatch_event, because this is the last
> instrumented function called before the return to user-space. Interrupts
> are disabled at this point, this is perfectly normal, but they are
> probably re-enabled when returning to user-space.
> 
> What is more problematic, however, is that the timer interrupt did not
> tick at -83749 like it is supposed to. If it had ticked and the
> interrupt had been disabled in user-space, you would have taken the
> interrupt at -35, when __ipipe_syscall_root gets called with interrupts on.
> 
> So, now, you have to understand why the timer interrupt did not tick. I
> suggest, when the problem happens, you look at:
> * the interrupt controller register, to see if the timer interrupt is
> still masked, if it is masked, then try first commenting out the snippet
> in arch/arm/plat-mxc/avic.c which declares mxc_mask_irq as the
> irq_mask_ack callback
> * the timer registers, to see if the timer was programmed correctly, and
> is still ticking when the issue happens.
> 

You may also want, in __ipipe_mach_set_dec, to re-read the comparator
value after writing it. Sometimes, such things are needed for the write
to register to be really taken into account.

-- 
                                                                Gilles.

