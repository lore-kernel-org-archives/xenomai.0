MIME-Version: 1.0
In-Reply-To: <1314698841.22036.2.camel@domain.hid>
References: <CAMk6uB=6aJmndwmU14zu3S9QBH=tFy0xrub7kznUyZBqsTTdiQ@mail.gmail.com>
	<1314698841.22036.2.camel@domain.hid>
Date: Tue, 30 Aug 2011 18:59:45 +0800
Message-ID: <CAMk6uBnQQ54rBk2LZOSwws21EnfXVf2QZE7r66+iJWbcp6HKzw@domain.hid>
From: realmz6 <realmz6@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] [Adeos-main] gpio irq always set to level
 sensitive with Xenomai on Blackfin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, adeos-main@gna.org, uclinux-dist-devel@domain.hid

Hi Philippe,

Thanks for your quick response. I have a few questions.

On Tue, Aug 30, 2011 at 6:07 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Tue, 2011-08-30 at 16:40 +0800, realmz6 wrote:
>> Hi Guys,
>>
>> in adeos patch bfin_set_irq_handler(), this will set irq handle to
>> handle_level_irq even it is a edge gpio irq, is it true?
>>
>> =C2=A0#ifdef CONFIG_IPIPE
>> - =C2=A0 =C2=A0 =C2=A0 _set_irq_handler(irq, handle_level_irq);
>> -#else
>> - =C2=A0 =C2=A0 =C2=A0 struct irq_desc *desc =3D irq_desc + irq;
>> + =C2=A0 =C2=A0 =C2=A0 handle =3D __fixup_irq_handler(desc, handle_level=
_irq, 0);
>> +#endif
>>
>> should it like the follows, it just fixup original handle and will not
>> always set it to handle_level_irq.
>
> No, this code is correct Adeos-wise. See there for an explanation, and a
> pending fix for a related issue:
> https://mail.gna.org/public/xenomai-help/2011-08/msg00081.html
why adeos is designed to use handle_level_irq for all interrupts even
it is a edge interrupt in hardware?
you means it should be fixed in the ipipe fixup_handler for
handle_level_irq to deal with a edge interrupt.
on blackfin edge irq need a ack to clear sticky but level irq needn't,
if i fixed it in ipipe_ack_level_irq maybe
the level irq will be broken.

>
>>
>> #ifdef CONFIG_IPIPE
>> - =C2=A0 =C2=A0 =C2=A0 _set_irq_handler(irq, handle_level_irq);
>> -#else
>> - =C2=A0 =C2=A0 =C2=A0 struct irq_desc *desc =3D irq_desc + irq;
>> + =C2=A0 =C2=A0 =C2=A0 handle =3D __fixup_irq_handler(desc, handle, 0);
>> +#endif
>>
>> -steven
>>
>> _______________________________________________
>> Adeos-main mailing list
>> Adeos-main@domain.hid
>> https://mail.gna.org/listinfo/adeos-main
>
> --
> Philippe.
>
>
>

