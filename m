MIME-Version: 1.0
Date: Thu, 26 Jun 2008 10:07:25 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <c93c27ad0d08dde74d76078062909dec@domain.hid>
References: <c93c27ad0d08dde74d76078062909dec@domain.hid>
Message-ID: <1493ab12c63e2d90490767fb70872a57@domain.hid>
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

Hi

Do I have to understand that with no tick taskDelay(xxx) wait xxx
nanoseconds ?

Well, I've made other tests, and it's a little confuse to me because I tr=
y
tickGet() instruction when tick_arg=3D0 and the result is that tickGet gi=
ve
me an inceasing number, while I should have been a fixe value. Is it the
same think : tickGet get nanosecond time since epoch ? I really need to
know if I can use tick_arg=3D0 and tickAnnounce to have a manual tick, in
order to use watchdog (wdStart which takes as arguments the number of tic=
ks
to delay is going to use nanoseconds ?)

Thak you in advance

Matthieu


On Tue, 24 Jun 2008 19:10:24 +0200, Matthieu
<matthieu.connaulte_xenomai@domain.hid> wrote:
> On Tue, 24 Jun 2008 18:40:51 +0200, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>> Matthieu wrote:
>>>
>>> On Tue, 24 Jun 2008 16:27:42 +0200, Gilles Chanteperdrix
>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>> Matthieu wrote:
>>>>> Let me know if I've done something wrong ...
>>>> rt_timer_read belongs to the native skin, not to the vxworks skin !
>>>>
>>>> --
>>>>                                                   Gilles.
>>>
>>> Ok, but I don't really see why does mixing vxworks task with a xenoma=
i
>>> instruction that not depends on vxworks scheduler is a problem. if I
>> just
>>> get time, does the task switch to xenomai scheduler ?. However, if it=
's
>>> really a problem, what can I use to get a pricise time, as I can't us=
e
>>> getTick anymore. Philippe suggested xntbase time base services ?
>>
>> You can use rt_timer_read(), but you should not assume that this retur=
ns
>> a nanoseconds count, this depends on the timing configuration of the
>> native skin.
>>
>> --
>>
>                                            Gilles.
> Ok, but in fact, that's not my problem : I don't understand why the loo=
p
> doesn't stop on taskDelay(1), as there is no tick on vxworks scheduler
> (due
> to tick_arg=3D0) ?
>=20
> Matthieu
>=20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help



