Message-ID: <4BA2445F.4050808@domain.hid>
Date: Thu, 18 Mar 2010 16:18:55 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1a6dfa8.17766.12771270c36.Coremail.robert165@domain.hid>
In-Reply-To: <1a6dfa8.17766.12771270c36.Coremail.robert165@domain.hid>
Content-Type: text/plain; charset=x-gbk
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Sleep in rtdm driver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: robert165 <robert165@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

robert165 wrote:
> Hi,
>=20
>=20
>=20
> =D4=DA2010-03-18 00:19:47=A3=AC"Philippe Gerum" <rpm@xenomai.org> =D0=B4=
=B5=C0=A3=BA
>> On Wed, 2010-03-17 at 22:07 +0800, robert165 wrote:
>>> Hi everyone!
>>>
>>> I'm writing a gpio driver in RTDM. I start it with the demo "Hard rea=
l
>>> time RTDM driver skeleton v1.1" of Jan Kiszka.
>>> If I used rtdm_task_sleep in rt_ioctrl  function,  it return that
>>> "Xenomai: assertion failed at kernel/xenomai/skins/rtdm/drvlib.c:372
>>> (!xnpod_unblockable_p())"  when running.
>>> It is said that rtdm_task_sleep can be called from Kernel-based task.
>>> Why I can't use it in my driver. Optionally, I can do this in
>>> user-space by periodic calling the driver, but it seems slower than i=
n
>>> kernel space.
>> I'm puzzled: what does "slower" mean, regarding what operation?
> I am sorry, I means is it more effective if doing things in kernel spac=
e.  I think when periodic calling driver in user-space, it may spent more=
 in context switching.

If you really depend on this minor difference, you are already designing
with a too small safety margin.

Have you measured the differences and compared them to your requirements?

Jan

--=20
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

