Message-ID: <43D81B11.2020809@domain.hid>
Date: Wed, 25 Jan 2006 22:42:57 -0200
From: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
MIME-Version: 1.0
References: <200601251552.10271.lbocseg@domain.hid> <43D7D7E3.3040804@domain.hid>
In-Reply-To: <43D7D7E3.3040804@domain.hid>
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Re: RTDM and udelay
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
Cc: xenomai@xenomai.org

Rodrigo Rosenfeld Rosas wrote:

>>Is there any alternative to udelay on RTDM?
>>
>>Or should I do something like:
>>
>>void rt_udelay(unsigned int usec) {
>>  uint64_t timeout =3D rtdm_clock_read () + usec;
>>  while (rtdm_clock_read () < timeout);
>>}
>>   =20
>>
>
>You mean something like this: =3D:)
>
>http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/skins/rtdm/drvlib.c=
?v=3DSVN-trunk#L366
> =20
>
Yes, but it seemed too complex for me, since it disables IRQ and I do=20
not need this feature. It will no problem if, instead of waiting 2us, I=20
have to wait 100us because some interrupt has occurred. After I write to=20
the board i2c registers, I need to wait *at least*, say, 2us before=20
writing another i2c cycle.

One more thing: although the name of the function has the word "task", I=20
think it is not task specific. Documentation even says it can be called=20
from initialization/cleanup code. But it doesn't say if it can be called=20
from an ioctl handler or any other context, although I see no problem=20
when reviewing the code. Thus, I think a better name would be something=20
like rtdm_busy_sleep() or rtdm_ns_delay(). Just a suggestion.

>>Or maybe my design is wrong.
>>
>>I have a function, say WriteI2C(...). Should I create it as a task and ca=
ll=20
>>rtdm_task_sleep?
>>   =20
>>
>
>Depending on how long you would like to sleep and if you are not inside
>an IRQ handler, a re-scheduling call like rtdm_task_sleep() can be
>better. If it's just about a few microseconds, busy sleeping should be
>preferred.
> =20
>
Exactly what I had in mind, thanks.

Best regards,

Rodrigo.


=09

=09
	=09
_______________________________________________________=20
Yahoo! doce lar. Fa=E7a do Yahoo! sua homepage.=20
http://br.yahoo.com/homepageset.html=20



