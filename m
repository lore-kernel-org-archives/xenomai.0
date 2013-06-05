Date: Wed, 5 Jun 2013 22:34:41 +0800 (CST)
From: =?UTF-8?B?5bWM5YWl5byP5bel56iL5biI?= <ericvic@163.com>
In-Reply-To: <51AC8209.4060507@xenomai.org>
References: <4cacd80b.2131b.13ef60cf09e.Coremail.ericvic@163.com>
	<51A79898.50805@xenomai.org>
	<34806652.2924.13ef838eb26.Coremail.ericvic@163.com>
	<4855a071.2a22.13ef83b0d46.Coremail.ericvic@163.com>
	<51A835DE.5020409@xenomai.org>
	<700980f4.7d37.13ef927183f.Coremail.ericvic@163.com>
	<27b32d48.5247.13efee65625.Coremail.ericvic@163.com>
	<51A9C9EF.2040702@xenomai.org>
	<37d33293.2abd.13f07ada45c.Coremail.ericvic@163.com>
	<51AC31A2.5010907@xenomai.org>
	<7b78f3e.c5e4.13f092364eb.Coremail.ericvic@163.com>
	<51AC8209.4060507@xenomai.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2bb4890b.c7e9.13f14c2da98.Coremail.ericvic@163.com>
Subject: Re: [Xenomai] freescale(imx53)  with xenomai patch
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

Now =EF=BC=8CI suddenly noticed,P and V operation must not be interrupted o=
peration. Before I did not know my colleague spent rt_sem_p () and rt_sem_v=
 ().
Today, I suddenly saw it.
I also would like to ask, rt_alarm_inquire is available in rt_sem_v () oper=
ation, timing counts?
Because they are in the case with a timer but also a very accurate timekeep=
ing pv operation.
=E5=9C=A8 2013-06-03 19:46:17=EF=BC=8C"Gilles Chanteperdrix" <gilles.chante=
perdrix@xenomai.org> =E5=86=99=E9=81=93=EF=BC=9A
>On 06/03/2013 10:24 AM, =E5=B5=8C=E5=85=A5=E5=BC=8F=E5=B7=A5=E7=A8=8B=E5=
=B8=88 wrote:
>
>> I have set the trigger type with Low trigger  and without disable and en=
able codes.
>> if the interrupt is triggered the hardware will set the gpio with High =
=E3=80=82
>> It has the same problem.
>> I do not why ?
>
>
>Ok, could you tell me:
>- what type you set for your interrupt (with irq_set_irq_type)?
>- what is the shape of the signal?
>
>Sorry for stating the obvious, but if the gpio is toggled every
>500milliseconds and you set the irq type to level (low or high), the
>interrupts is considered to be asserted by the interrupt controller
>during 500 milliseconds, and so your interrupt handler is called
>continuously during 500 milliseconds. In that case, what you would be
>interested in would be to call:
> irq_set_irq_type(irq, IRQ_TYPE_EDGE_BOTH)
>for instance.
>
>Regards.
>
>--=20
>                                                                Gilles.


