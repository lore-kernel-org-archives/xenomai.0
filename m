Message-ID: <4F18A041.6050407@domain.hid>
Date: Thu, 19 Jan 2012 23:59:13 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <56F449AE83D74177BAC5887692E0EF55@domain.hid>	<4EF44DB9.9000609@domain.hid><4EF49DA3.8070904@domain.hid>	<4EF4A3E2.9030709@domain.hid>	<E9F947B915764962864D7E7291CA601F@TerryHP>
	<4EF4C4C0.9010100@domain.hid>
	<990B36E792F1A4488D3E2B1C46FD62D691470CC094@domain.hid>
In-Reply-To: <990B36E792F1A4488D3E2B1C46FD62D691470CC094@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Michael Pustylnik <MichaelPustylnik@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Makarand Pradhan <MakarandPradhan@domain.hid>

On 01/19/2012 08:41 PM, Michael Pustylnik wrote:
> Hi Philippe,
>
> I am really sorry for continuing this thread after such a long delay but I just couldn't get to it sooner.
>
> I understand all your points you mentioned describing the rationale behind your decision to eliminate the rt_intr_* API in Xenomai 3.x, and I definitely agree that they are very valid. However, in real life different Xenomai users could have all kinds of different considerations (other than the ones you mentioned) and there might be special reasons for insisting on using the user space interrupt services.
>
> We happen to be one of such users and we have strong reasons to tolerate the potential issues you mentioned in order to achieve our very specific goals by using the rt_intr_* API. (I don't want to waste your time describing those specific goals but believe me there are ones).
> Said that, we would face serious problems with upgrading to Xenomai 3.x, while we actually do want to take advantage of it.
>
> So, my question is simple - could you guys consider leaving the existing rt_intr* services in place as a bonus? (You could still say that this is not a recommended way interrupt handling but it's there for backwards compatibility).
>

Please don't misunderstand this decision, it is 100% based on real life 
issues involving multiple customer projects, and was not taken lightly. 
The rationale behind it is that most newcomers should be allowed to 
expect all interfaces from the native/alchemy API to implement the 
recommended way of doing things. rt_intr* is completely at odds with 
this implicit rule: it is error-prone, limited to very specific use 
cases, and can lead to blatantly wrong app designs and roadblocks.

The plan is to provide for a basic uio-like mechanism based on a RTDM 
driver for dealing with IRQs in userland. Users who insist on dealing 
with interrupts in userland could use the RTDM/ioctl() interface 
directly to that driver or wrap the deprecated rt_intr_* calls locally 
over it. Using a RTDM driver dedicated to such a peculiar task (and it 
shall be documented that way) could not be a naive decision.

> Thanks,
>
>   Michael.
>
>
>
> -----Original Message-----
> From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] On Behalf Of Philippe Gerum
> Sent: Friday, December 23, 2011 1:13 PM
> To: xenomai@xenomai.org
> Subject: Re: [Xenomai-help] Interrupt numbers
>
> On 12/23/2011 05:16 PM, Terry Fryar wrote:
>> I would imagine it was nice, however, to have a userspace interrupt ISR so
>> that flaky code could be debugged in userspace before making it into a
>> driver?
>>
>
> Most interrupts are level sensitive these days, which means that you
> cannot safely step into the code which is supposed to ack the source
> device using a debugger, your kernel would be stormed by IRQs before you
> reach the point where the device request is acked. Remember that
> userland always runs with hw interrupts enabled, regardless of the
> domain. Even edge triggered IRQs would not give you any guarantee with
> respect to device timing requirements.
>
> GDB aside, also think about a transition to secondary mode for whatever
> reason while running in userland prior to acking the device: this would
> be another source of unexpected delays in the acknowledge path.
>
> Debugging work is likely to introduce these issues, unless one refrains
> from using anything else than rt_printf() for logging/observing the
> runtime state, but that would not help with level sensitive IRQs anyway.
>
> You may want to handle the main application logic that responds to an
> interrupt in userland through, in which case you need some RTDM driver
> handling the bottom half of real-time interrupts, which would in turn
> unblock a task sleeping on some read() or ioctl(), to process the event
> in userland (i.e. UIO-like for real-time IRQs).
>
> The bottom line is that you want the IRQ to be acknowledged at device
> level from kernel space. Keeping it masked in the PIC while
> transitioning to user-space would be another option, assuming it is not
> shared with the regular kernel (sharing between rt and non-rt would be
> just wrong anyway), if the device permits (infinitely) delayed
> acknowledges, but I would not recommend this. Typically, a user-space
> code can be wiped off at any time, leaving the device in a weird state.
>
> These are the reasons why I have killed the rt_intr_* API in 3.x, it was
> way too easy to shoot oneself in the foot (and believe me, I saw quite a
> few damaged feet in the past years due to this issue). What was missing
> in this API is a clear hint that some user-provided code should live in
> kernel space to ack each particular device controlled from userland.
> Using RTDM to implement such code and synchronize with the application
> logic in userland is a safe, sane and simple solution.
>
>> -----Original Message-----
>> From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] On
>> Behalf Of Gilles Chanteperdrix
>> Sent: Friday, December 23, 2011 9:53 AM
>> To: Makarand Pradhan
>> Cc: xenomai@xenomai.org
>> Subject: Re: [Xenomai-help] Interrupt numbers
>>
>> On 12/23/2011 04:26 PM, Makarand Pradhan wrote:
>>> On 23/12/11 04:45 AM, Gilles Chanteperdrix wrote:
>>>>
>>>> Xenomai uses the same interrupt numbers as linux. But rt_intr_create
>>>> is deprecated in user-space, you should instead write a driver using
>>>> the rtdm skin. The enable bit is handled by xenomai when you request
>>>> the irq at xenomai level.
>>>>
>>> Hi Gilles,
>>>
>>> We use rt_intr_create in our code. So I am trying to understand the
>>> reasons for it being deprecated. So far, I have not been able to see
>>> any comments in the code regarding the deprecation or anything in the git
>> log.
>>
>> Splitting your code between driver and application enforces a clean
>> separation between the two, which helps maintenance, so is good on the long
>> run.
>>
>>>
>>> Can you pl comment on the reasons for deprecating rt_intr_create? Will
>>> it be removed in the next release?
>>
>> We never change ABI in a branch, so, all releases in the 2.6 branch are
>> guaranteed to support the same services as xenomai 2.6.0.
>>
>> But in xenomai 3.0, rt_intr_create will certainly no longer be available.
>
>


-- 
Philippe.

