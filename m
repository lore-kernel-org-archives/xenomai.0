Message-ID: <50366E2A.5030006@xenomai.org>
Date: Thu, 23 Aug 2012 19:53:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50350308.8010405@openwide.fr> <50350712.4020704@xenomai.org>
	<5035E4CD.9080302@xenomai.org> <50364114.9090804@openwide.fr>
	<503641EA.2020201@xenomai.org> <503658B3.9060401@openwide.fr>
In-Reply-To: <503658B3.9060401@openwide.fr>
Content-Type: text/plain; charset=UTF-8
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
To: Romain Naour <romain.naour@openwide.fr>
Cc: xenomai@xenomai.org

On 08/23/2012 06:22 PM, Romain Naour wrote:

> Le 23/08/2012 16:44, Gilles Chanteperdrix a =C3=A9crit :
>> On 08/23/2012 04:41 PM, Romain Naour wrote:
>>> Le 23/08/2012 10:07, Gilles Chanteperdrix a =C3=A9crit :
>>>> On 08/22/2012 06:21 PM, Gilles Chanteperdrix wrote:
>>>>> On 08/22/2012 06:04 PM, Romain Naour wrote:
>>>>>> Hello,
>>>>>>
>>>>>> On s3c24xx processors the interrupt source priority isn't fixed by=
 Adeos
>>>>>> patch (ARB_SEL bits in PRIORITY register).
>>>>>> Is it intentional ?
>>>>>> It may be possible to give priority to an interrupt simultaneously=

>>>>>> arrived that the interruption IRQ_TIMER4 (before being grabbed by
>>>>>> Adeos). Therefore, we can have more jitter for real time applicati=
ons.
>>>>> This can always happen even with interrupt priorities: imagine that=
 the
>>>>> first interrupt happens 1 microsecond before the timer interrupt, e=
ven
>>>>> with the priority, the handler for first interrupt will be executed=
 and
>>>>> the timer interrupt will have to wait for the end of this handler b=
efore
>>>>> it is serviced.
>>>>>
>>>>>> Do we need to fix the priority at this level ?
>>>>> I do not think so. However, what can be done is implement interrupt=

>>>>> controller muting using the priority register, see:
>>>>> http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#Priority_ba=
sed_interrupt_controller_muting
>>> The priority register can't be used for implement interrupt controlle=
r
>>> muting using this method .
>>> The PIC hardware can't be configured with only two priority levels.
>>> We are obligated to choose between fixed or "rotation fashion" priori=
ty
>>> with 32 levels...
>> What prevents us from using the "fixed" priorities, with one level for=

>> real-time interrupts and another for non real-time interrupts ?
> The priority register is used to configure the arbitration procedure=20
> when multiple interrupts occur.
> But some interrupt sources always have higher priority than other.
>=20
> For example, EINT0 is always takes priority regardless INT_RTC, when=20
> arrive at the same time.
> Whatever the configuration of priority register.
>=20
> When INT_TIMER4 is trigged, the value of priority register is modified.=

> Thus, INT_TIMER4 loses its priority for arbitration procedure.
> That is why I wonder if it is better to fix the priority for arbitratio=
n=20
> procedure.


I don't get it, could you point me to the datasheet?

--=20
                                                                Gilles.


