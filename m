Message-ID: <52E0281C.3090102@xenomai.org>
Date: Wed, 22 Jan 2014 21:20:44 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANKLDmv_hfbVcWzoxjerWOTEWqEWPnQzUu44GF=SbC0iSopDOg@mail.gmail.com>
 <52DCF0D1.4000307@xenomai.org>
 <CANKLDms3aXrSoov7Z9T2JBN6fpmuh43LCQ0RUEETrDAYr3=1dA@mail.gmail.com>
 <52DD89AF.4090905@xenomai.org>
 <CANKLDmtkrhERdZ8h3HV0=Q3fPHxLjw9T4n12n0A0=-1chKPS7A@mail.gmail.com>
 <52DFA1C5.9000006@xenomai.org>
 <CANKLDmvujEYxC_Z_5xE0oyBRmnnwOVbk55xweMu0m+gsgB5rfA@mail.gmail.com>
In-Reply-To: <CANKLDmvujEYxC_Z_5xE0oyBRmnnwOVbk55xweMu0m+gsgB5rfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xnarch_xchg infinite loop
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henri Roosen <henriroosen@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/22/2014 03:49 PM, Henri Roosen wrote:
> On Wed, Jan 22, 2014 at 11:47 AM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> On 01/22/2014 09:31 AM, Henri Roosen wrote:
>>> Removing the device driver before reboot doesn't help: we still get a
>>> LDREX/STREX lockup in the Xenomai timertick path. I'm still not sure what
>>> actually causes this lockup, but my guess is somewhere late in the
>>> shutdown-sequence the memory (or something else) is put into a state that
>>> makes LDREX/STREX fail all the time. Any interrupt from the Xenomai
>> domain
>>> locks the system then.
>>>
>>> As a quick (and dirty!) workaround skipping __ipipe_handle_irq when
>>> system_state == SYSTEM_REBOOT solves the problem.
>>>
>>> So thinking towards a proper solution: is there or should there be any
>>> shutdown/de-initialization of Xenomai and it's services in the Linux
>>> shutdown sequence?
>>
>> The simplest solution seems to find the Linux code involved, which
>> probably contains a local_irq_disable() to avoid this situation, and
>> replace it with hard_local_irq_disable() in the I-pipe case so as to
>> also block xenomai interrupts.
>>
> 
> Great, this seems to work. Thanks Gilles!
> I replaced with local_irq_disable_hw(), that is what you meant right?
> 
> The ARM reboot code also disables the fiq with local_fiq_disable(). It it
> necessary to also change this by local_fiq_disable_hw() for the ipipe case?
> Or is there no need for that?

Right, hard_local_irq_disable is for I-pipe patches for 3.2 and later
kernels. Yeq, if local_fiq_disable_hw exists, you should call it instead
of local_fiq_disable.

Regards.

-- 
                                                                Gilles.

