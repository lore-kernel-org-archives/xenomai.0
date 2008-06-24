MIME-Version: 1.0
Date: Tue, 24 Jun 2008 19:10:24 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <48612393.1090405@domain.hid>
References: <48612393.1090405@domain.hid>
Message-ID: <c93c27ad0d08dde74d76078062909dec@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai scheduler's ticks period
Reply-To: matthieu.connaulte_xenomai@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On Tue, 24 Jun 2008 18:40:51 +0200, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Matthieu wrote:
>>
>> On Tue, 24 Jun 2008 16:27:42 +0200, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> Matthieu wrote:
>>>> Let me know if I've done something wrong ...
>>> rt_timer_read belongs to the native skin, not to the vxworks skin !
>>>
>>> --
>>>                                                   Gilles.
>>
>> Ok, but I don't really see why does mixing vxworks task with a xenomai
>> instruction that not depends on vxworks scheduler is a problem. if I
> just
>> get time, does the task switch to xenomai scheduler ?. However, if it'=
s
>> really a problem, what can I use to get a pricise time, as I can't use
>> getTick anymore. Philippe suggested xntbase time base services ?
>=20
> You can use rt_timer_read(), but you should not assume that this return=
s
> a nanoseconds count, this depends on the timing configuration of the
> native skin.
>=20
> --
>      =20
                                           Gilles.
Ok, but in fact, that's not my problem : I don't understand why the loop
doesn't stop on taskDelay(1), as there is no tick on vxworks scheduler (d=
ue
to tick_arg=3D0) ?

Matthieu



