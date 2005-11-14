Message-ID: <43787450.1050701@domain.hid>
Date: Mon, 14 Nov 2005 12:26:08 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] printk
References: <OF1D0CCC98.82E4D674-ONC12570B6.003B9ABD-C12570B6.003D16B7@domain.hid>
	<43786C64.1050404@domain.hid>
In-Reply-To: <43786C64.1050404@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai@xenomai.org

Ignacio Garc=EDa P=E9rez wrote:
> Dmitry Adamushko wrote:
>=20
>=20
>>xenomai-help-bounces@domain.hid wrote on 11.11.2005 10:30:26:
>>
>>
>>>Hi,
>>>
>>>I'm porting an app from RTAI to Xenomai, and when it came to the
>>>rt_printk function, I had to replace it with plain printk (the
>>>xnarch_log* functions all use printk).
>>>
>>>What I want to know if:
>>>
>>>1- Is totally safe to call the standard kernel printk function from a
>>>real time task?
>>
>>Actually, the adeos/ipipe patches make some changes to the vanilla
>>kernel's printk() mechanism.
>>
>>There are 2 possible modes of printk() being issued from the primary
>>domain.
>>
>>1) asynchronous:
>>
>>all data is written into the protected buffer and the
>>__ipipe_printk_virq virq is risen for the secondary domain. So the
>>data will be printed out when the linux gets control next time.
>>
>>Although, here is, well, a tiny race because of the fact that the virq
>>handler doesn't lock a buffer-related data (like __ipipe_printk_fill)
>>so a loss of data may occur under some circumstances.
>>

Nope. __ipipe_printk_fill and friends are manipulated under hw irq spinlo=
cking=20
in printk(), and under Linux domain stalling protection in __ipipe_flush_=
printk=20
since it's a virq handler, and finally, printk() cannot preempt=20
__ipipe_flush_printk under normal operation mode (i.e. async mode). AFAIC=
S,=20
there's no race here.

>>2) synchronous (IPIPE_SPRINTK_FLAG)
>>
>>in this case, a normal linux vprintk() call is issued. Oops, this one,
>>in turn, calls spin_lock_irqsave(&logbuf_lock, flags); in real-time
>>context and that lock may be already held by a preempted non-rt task
>>on the same CPU.
>>
>>Houston? :o)
>>
>=20
> (2) is unacceptable. Losing some data would be acceptable if it is
> caused by too much printk output, but not because of a race condition.
> This should be fixed. I guess a simple FIFO with proper locking should
> be in place. printk would discard data only if there is no space left.
>=20
>=20
>>>2- Even if it's safe, can it affect the performance of a real time tas=
k?
>>>(or can it block under *any* conceivable condition?)
>>
>>It gives some overhead since data must be copied to the buffer and at
>>that time the interrupts are off.
>>Blocked? No, if not taking into account a possible "hang up" with the
>>synchronous mode (ok, as always there is still a hope that I can be
>>wrong ):)
>>
>=20
> If you are right, then it's unacceptable. An RT task would be blocked b=
y
> a non-RT task.
>=20

Please people, keep things simple and easy: synchronous printk mode is an=
=20
_emergency_ configuration which is of no use under normal runtime conditi=
ons. It=20
is only there as a desperate debugging help for Adeos/Xeno core developme=
nt in=20
order to force the printk output regardless of the current domain, so it =
might=20
work, but it it doesn't and hits any of the obvious races that the asynch=
ronous=20
mode solves, well, nobody is going to complain because it's just a last r=
esort=20
bypass in order to get some ultimate traces before the box jumps out of t=
he=20
window anyway. IOW, if one keeps using the default and normal async print=
k mode=20
which prevents domain clashes, everything will be fine.

Regarding the overhead induced by a temporary copy of the printk data, if=
 one=20
starts having problem with this, then the issue is first caused by spammi=
ng the=20
kernel log with such amount of information. IOW, cure the real bug, not i=
ts=20
consequences.

--=20

Philippe.

