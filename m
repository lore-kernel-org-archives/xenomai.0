From: "Terry Fryar" <terry.fryar@domain.hid>
References: <56F449AE83D74177BAC5887692E0EF55@domain.hid>	<4EF44DB9.9000609@domain.hid><4EF49DA3.8070904@domain.hid>	<4EF4A3E2.9030709@domain.hid>
	<E9F947B915764962864D7E7291CA601F@TerryHP>
	<4EF4C4C0.9010100@domain.hid>
In-Reply-To: <4EF4C4C0.9010100@domain.hid>
Date: Fri, 23 Dec 2011 17:06:08 -0600
Message-ID: <8D114AE9A7CD44D99ADA5550179EA36C@TerryHP>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Interrupt numbers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: 'Philippe Gerum' <rpm@xenomai.org>, xenomai@xenomai.org

Yeh, this is the direction we were going anyways, as I really only need the
irq to trigger an unblock in userland.  I've already got a kernel driver
written using xenomai, so moving the irq code into a driver won't be a
stretch!!


-----Original Message-----
From: Philippe Gerum [mailto:rpm@xenomai.org] 
Sent: Friday, December 23, 2011 12:13 PM
To: xenomai@xenomai.org
Cc: terry.fryar@domain.hid
Subject: Re: [Xenomai-help] Interrupt numbers

On 12/23/2011 05:16 PM, Terry Fryar wrote:
> I would imagine it was nice, however, to have a userspace interrupt 
> ISR so that flaky code could be debugged in userspace before making it 
> into a driver?
>

Most interrupts are level sensitive these days, which means that you cannot
safely step into the code which is supposed to ack the source device using a
debugger, your kernel would be stormed by IRQs before you reach the point
where the device request is acked. Remember that userland always runs with
hw interrupts enabled, regardless of the domain. Even edge triggered IRQs
would not give you any guarantee with respect to device timing requirements.

GDB aside, also think about a transition to secondary mode for whatever
reason while running in userland prior to acking the device: this would be
another source of unexpected delays in the acknowledge path.

Debugging work is likely to introduce these issues, unless one refrains from
using anything else than rt_printf() for logging/observing the runtime
state, but that would not help with level sensitive IRQs anyway.

You may want to handle the main application logic that responds to an
interrupt in userland through, in which case you need some RTDM driver
handling the bottom half of real-time interrupts, which would in turn
unblock a task sleeping on some read() or ioctl(), to process the event in
userland (i.e. UIO-like for real-time IRQs).

The bottom line is that you want the IRQ to be acknowledged at device level
from kernel space. Keeping it masked in the PIC while transitioning to
user-space would be another option, assuming it is not shared with the
regular kernel (sharing between rt and non-rt would be just wrong anyway),
if the device permits (infinitely) delayed acknowledges, but I would not
recommend this. Typically, a user-space code can be wiped off at any time,
leaving the device in a weird state.

These are the reasons why I have killed the rt_intr_* API in 3.x, it was way
too easy to shoot oneself in the foot (and believe me, I saw quite a few
damaged feet in the past years due to this issue). What was missing in this
API is a clear hint that some user-provided code should live in kernel space
to ack each particular device controlled from userland. 
Using RTDM to implement such code and synchronize with the application logic
in userland is a safe, sane and simple solution.

> -----Original Message-----
> From: xenomai-help-bounces@domain.hid 
> [mailto:xenomai-help-bounces@domain.hid] On Behalf Of Gilles 
> Chanteperdrix
> Sent: Friday, December 23, 2011 9:53 AM
> To: Makarand Pradhan
> Cc: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Interrupt numbers
>
> On 12/23/2011 04:26 PM, Makarand Pradhan wrote:
>> On 23/12/11 04:45 AM, Gilles Chanteperdrix wrote:
>>>
>>> Xenomai uses the same interrupt numbers as linux. But rt_intr_create 
>>> is deprecated in user-space, you should instead write a driver using 
>>> the rtdm skin. The enable bit is handled by xenomai when you request 
>>> the irq at xenomai level.
>>>
>> Hi Gilles,
>>
>> We use rt_intr_create in our code. So I am trying to understand the 
>> reasons for it being deprecated. So far, I have not been able to see 
>> any comments in the code regarding the deprecation or anything in the 
>> git
> log.
>
> Splitting your code between driver and application enforces a clean 
> separation between the two, which helps maintenance, so is good on the 
> long run.
>
>>
>> Can you pl comment on the reasons for deprecating rt_intr_create? 
>> Will it be removed in the next release?
>
> We never change ABI in a branch, so, all releases in the 2.6 branch 
> are guaranteed to support the same services as xenomai 2.6.0.
>
> But in xenomai 3.0, rt_intr_create will certainly no longer be available.


--
Philippe.


