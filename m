Message-ID: <44EA9D22.5090301@domain.hid>
Date: Tue, 22 Aug 2006 07:58:58 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Socketcan-users] [Xenomai-help] Re: send error: permission	denied
References: <DD39B5C3F4963040ADC9768BE7E430CBFFAD9F@is-hdq-exchange.marel.net>	<44EA096D.9080208@domain.hid>
	<44EA0DB4.1080302@domain.hid>
In-Reply-To: <44EA0DB4.1080302@domain.hid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, socketcan-users@domain.hid, Daniel Schnell <danielsch@domain.hid>

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Hi Daniel,
>>
>> Daniel Schnell wrote:
>>> Hi,
>>>
>>> =20
>>>
>>> I am new to socket can.
>>>
>>> =20
>>>
>>> I wanted to test the rtcan driver in combination with Linux and
>>> Xenomai and made a little program according to the rtcansend program
>>> but with some response time measurements.
>>>
>>> =20
>>>
>>> However after setting up the socket I get =E2=80=93EPERM when trying =
to send a
>>> packet to the can device. As the documentation doesn=E2=80=99t state =
anything
>>> about this error when calling rt_dev_send() I wonder why the error if
>>> at all doesn=E2=80=99t appear earlier if I try to setup the socket. T=
he test
>>> program already ran nicely when I tested the peak can drivers for
>>> linux. I just changed the driver specific calls.
>>>
>>> =20
>>>
>>> Attached you find the complete test file, the function task() is the
>>> one to blame.
>>>
>>> =20
>>>
>>> I am a bit stuck with this, so maybe someone can give me a slight hin=
t
>>> in what i am doing wrong.
>> I tried your program on my system and got the same error. The problem
>> is, that rt_dev_send() is called from non-RT context, which is illegal=
.
>=20
> ...but should not matter if the caller is a Xenomai thread in "Linux" m=
ode.
>=20
>> At a first glance, it's not obvious to me why. Therefore I added the
>> Xenomai Help ML to the CCs.
>=20
> How did you all compile the program [1]? Using xeno-config
> --posix-cflags / --posix-ldflags?

No, ah, oh. It works using the above flags, indeed. I see, that it calls=20
_rtdm_sendmsg in secondary execution mode (none-RT) first, which=20
returned -ENOSYS (-38). Then I guess, the context is switch to primary=20
mode and _rtdm_sendmsg is called again, correct?

> Jan
>=20
>=20
> PS: Daniel, if you go the POSIX way, you don't have to use rt_dev_, you
> can use the normal POSIX API directly. That services will be wrapped on
> the Xenomai core just like pthread&friends.

Cool. I was not yet aware of that.

> [1]https://lists.berlios.de/pipermail/socketcan-users/attachments/20060=
821/ff454f48/cantest_rt.obj

Thanks for clarifying things.

Wolfgang.


