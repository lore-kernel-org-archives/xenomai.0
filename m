MIME-Version: 1.0
In-Reply-To: <4F034332.3040708@domain.hid>
References: <CAL8zT=h3+AYe56fWhbKr3nY8VhYcNjx=sPRe0cak5hvF+aM6yA@mail.gmail.com>
	<4F0341CA.9080101@domain.hid> <4F034332.3040708@domain.hid>
From: Jean-Michel Hautbois <jhautbois@domain.hid>
Date: Tue, 3 Jan 2012 19:13:20 +0100
Message-ID: <CAL8zT=g0-6UhMku5suh8tUXYzR9eJ4knFY=TOmYC2Ug4MzJrrw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] Ipipe breaks my MPC8541 board boot
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

2012/1/3 Philippe Gerum <rpm@xenomai.org>:
> On 01/03/2012 06:58 PM, Gilles Chanteperdrix wrote:
>>
>> On 01/03/2012 06:49 PM, Jean-Michel Hautbois wrote:
>>>
>>> cpm2_cascade is dedicated to my board, but has nothing impressive :
>>> static void cpm2_cascade(unsigned int irq, struct irq_desc *desc)
>>> {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 int cascade_irq;
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 while ((cascade_irq =3D cpm2_get_irq())>=3D=
 0)
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 generic_handle_=
irq(cascade_irq);
>>
>>
>> Replace generic_handle_irq with ipipe_handle_chained_irq.
>>

Argh ! I didn't see it :) !
Thanks, it works.

> You have to fixup the eoi handling as well, check how this is done in
> arch/powerpc/platforms/85xx/sbc8560.c.

OK, I will check it, but didn't need to do it for making it work... :).

Thanks again !
JM

