From: Michael Pustylnik <MichaelPustylnik@domain.hid>
Date: Thu, 19 Jan 2012 14:41:15 -0500
Message-ID: <990B36E792F1A4488D3E2B1C46FD62D691470CC094@domain.hid>
References: <56F449AE83D74177BAC5887692E0EF55@domain.hid>
	<4EF44DB9.9000609@domain.hid><4EF49DA3.8070904@domain.hid>
	<4EF4A3E2.9030709@domain.hid>	<E9F947B915764962864D7E7291CA601F@TerryHP>
	<4EF4C4C0.9010100@domain.hid>
In-Reply-To: <4EF4C4C0.9010100@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: Makarand Pradhan <MakarandPradhan@domain.hid>

Hi Philippe,

I am really sorry for continuing this thread after such a long delay but I =
just couldn't get to it sooner.

I understand all your points you mentioned describing the rationale behind =
your decision to eliminate the rt_intr_* API in Xenomai 3.x, and I definite=
ly agree that they are very valid. However, in real life different Xenomai =
users could have all kinds of different considerations (other than the ones=
 you mentioned) and there might be special reasons for insisting on using t=
he user space interrupt services.

We happen to be one of such users and we have strong reasons to tolerate th=
e potential issues you mentioned in order to achieve our very specific goal=
s by using the rt_intr_* API. (I don't want to waste your time describing t=
hose specific goals but believe me there are ones).
Said that, we would face serious problems with upgrading to Xenomai 3.x, wh=
ile we actually do want to take advantage of it.

So, my question is simple - could you guys consider leaving the existing rt=
_intr* services in place as a bonus? (You could still say that this is not =
a recommended way interrupt handling but it's there for backwards compatibi=
lity).

Thanks,

 Michael.
=20


-----Original Message-----
From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] On=
 Behalf Of Philippe Gerum
Sent: Friday, December 23, 2011 1:13 PM
To: xenomai@xenomai.org
Subject: Re: [Xenomai-help] Interrupt numbers

On 12/23/2011 05:16 PM, Terry Fryar wrote:
> I would imagine it was nice, however, to have a userspace interrupt ISR s=
o
> that flaky code could be debugged in userspace before making it into a
> driver?
>

Most interrupts are level sensitive these days, which means that you=20
cannot safely step into the code which is supposed to ack the source=20
device using a debugger, your kernel would be stormed by IRQs before you=20
reach the point where the device request is acked. Remember that=20
userland always runs with hw interrupts enabled, regardless of the=20
domain. Even edge triggered IRQs would not give you any guarantee with=20
respect to device timing requirements.

GDB aside, also think about a transition to secondary mode for whatever=20
reason while running in userland prior to acking the device: this would=20
be another source of unexpected delays in the acknowledge path.

Debugging work is likely to introduce these issues, unless one refrains=20
from using anything else than rt_printf() for logging/observing the=20
runtime state, but that would not help with level sensitive IRQs anyway.

You may want to handle the main application logic that responds to an=20
interrupt in userland through, in which case you need some RTDM driver=20
handling the bottom half of real-time interrupts, which would in turn=20
unblock a task sleeping on some read() or ioctl(), to process the event=20
in userland (i.e. UIO-like for real-time IRQs).

The bottom line is that you want the IRQ to be acknowledged at device=20
level from kernel space. Keeping it masked in the PIC while=20
transitioning to user-space would be another option, assuming it is not=20
shared with the regular kernel (sharing between rt and non-rt would be=20
just wrong anyway), if the device permits (infinitely) delayed=20
acknowledges, but I would not recommend this. Typically, a user-space=20
code can be wiped off at any time, leaving the device in a weird state.

These are the reasons why I have killed the rt_intr_* API in 3.x, it was=20
way too easy to shoot oneself in the foot (and believe me, I saw quite a=20
few damaged feet in the past years due to this issue). What was missing=20
in this API is a clear hint that some user-provided code should live in=20
kernel space to ack each particular device controlled from userland.=20
Using RTDM to implement such code and synchronize with the application=20
logic in userland is a safe, sane and simple solution.

> -----Original Message-----
> From: xenomai-help-bounces@domain.hid [mailto:xenomai-help-bounces@domain.hid] =
On
> Behalf Of Gilles Chanteperdrix
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
>> any comments in the code regarding the deprecation or anything in the gi=
t
> log.
>
> Splitting your code between driver and application enforces a clean
> separation between the two, which helps maintenance, so is good on the lo=
ng
> run.
>
>>
>> Can you pl comment on the reasons for deprecating rt_intr_create? Will
>> it be removed in the next release?
>
> We never change ABI in a branch, so, all releases in the 2.6 branch are
> guaranteed to support the same services as xenomai 2.6.0.
>
> But in xenomai 3.0, rt_intr_create will certainly no longer be available.


--=20
Philippe.

_______________________________________________
Xenomai-help mailing list
Xenomai-help@domain.hid
https://mail.gna.org/listinfo/xenomai-help

No virus found in this incoming message.
Checked by AVG - www.avg.com=20
Version: 8.5.454 / Virus Database: 271.1.1/3990 - Release Date: 12/22/11 19=
:34:00

