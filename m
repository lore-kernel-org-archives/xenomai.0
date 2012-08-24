Message-ID: <503778DC.3040201@openwide.fr>
Date: Fri, 24 Aug 2012 14:51:40 +0200
From: Romain Naour <romain.naour@openwide.fr>
MIME-Version: 1.0
References: <50350308.8010405@openwide.fr> <50350712.4020704@xenomai.org>
	<5035E4CD.9080302@xenomai.org> <50364114.9090804@openwide.fr>
	<503641EA.2020201@xenomai.org> <503658B3.9060401@openwide.fr>
	<50366E2A.5030006@xenomai.org>
In-Reply-To: <50366E2A.5030006@xenomai.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] s3c24xx: Priority rotate enable !?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Le 23/08/2012 19:53, Gilles Chanteperdrix a =C3=A9crit :
> On 08/23/2012 06:22 PM, Romain Naour wrote:
>
>> Le 23/08/2012 16:44, Gilles Chanteperdrix a =C3=A9crit :
>>> On 08/23/2012 04:41 PM, Romain Naour wrote:
>>>> Le 23/08/2012 10:07, Gilles Chanteperdrix a =C3=A9crit :
>>>>> On 08/22/2012 06:21 PM, Gilles Chanteperdrix wrote:
>>>>>> On 08/22/2012 06:04 PM, Romain Naour wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> On s3c24xx processors the interrupt source priority isn't fixed b=
y Adeos
>>>>>>> patch (ARB_SEL bits in PRIORITY register).
>>>>>>> Is it intentional ?
>>>>>>> It may be possible to give priority to an interrupt simultaneousl=
y
>>>>>>> arrived that the interruption IRQ_TIMER4 (before being grabbed by
>>>>>>> Adeos). Therefore, we can have more jitter for real time applicat=
ions.
>>>>>> This can always happen even with interrupt priorities: imagine tha=
t the
>>>>>> first interrupt happens 1 microsecond before the timer interrupt, =
even
>>>>>> with the priority, the handler for first interrupt will be execute=
d and
>>>>>> the timer interrupt will have to wait for the end of this handler =
before
>>>>>> it is serviced.
>>>>>>
>>>>>>> Do we need to fix the priority at this level ?
>>>>>> I do not think so. However, what can be done is implement interrup=
t
>>>>>> controller muting using the priority register, see:
>>>>>> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#Priority_b=
ased_interrupt_controller_muting
>>>> The priority register can't be used for implement interrupt controll=
er
>>>> muting using this method .
>>>> The PIC hardware can't be configured with only two priority levels.
>>>> We are obligated to choose between fixed or "rotation fashion" prior=
ity
>>>> with 32 levels...
>>> What prevents us from using the "fixed" priorities, with one level fo=
r
>>> real-time interrupts and another for non real-time interrupts ?
>> The priority register is used to configure the arbitration procedure
>> when multiple interrupts occur.
>> But some interrupt sources always have higher priority than other.
>>
>> For example, EINT0 is always takes priority regardless INT_RTC, when
>> arrive at the same time.
>> Whatever the configuration of priority register.
>>
>> When INT_TIMER4 is trigged, the value of priority register is modified=
.
>> Thus, INT_TIMER4 loses its priority for arbitration procedure.
>> That is why I wonder if it is better to fix the priority for arbitrati=
on
>> procedure.
> I don't get it, could you point me to the datasheet?
>
In the figure 14-1, there is the Priority Generating Block (priority)=20
between IRQ mask and INTPND register.
It is detailed in figure 14-2 and its functional principle is explained=20
on the next page.
The priority of interrupt source is determined by the configuration of=20
each arbiter.
This configuration is set by the priority register (P 14-13) which is=20
left on initial state by Linux (0x7F).
(ARB_MODE =3D 1 for all arbiter)

"ARB_MODE bit is 1, ARB_SEL bits are changed in rotation fashion, e.g.,=20
if REQ1 is serviced, ARB_SEL bits are changed to 01b automatically so as=20
to put REQ1 into the lowest priority"

"Note that REQ0 of an arbiter always has the highest priority, and REQ5=20
has the lowest one."
For example, EINT0 always has the highest priority and INT_ADC has the=20
lowest one.

I suggest to reset ARB_MODE for all arbiter and modify ARB6 (01b) and=20
ARB2 (11b), in order to increase and fix INT_TIMER4's priority'.
This is all what we can do with this register. Tell me if I'm wrong.

Regards,
Romain

