Message-ID: <20100709114655.46571rvnivjguu4w@domain.hid>
Date: Fri, 09 Jul 2010 11:46:55 +0200
From: Michel He <michel.he@domain.hid>
References: <20100316150037.11405209mnid677k@domain.hid>
	<4B9FB4A8.6000903@domain.hid>
	<20100316183247.34995yxgivc3ilj4@domain.hid>
	<4B9FC1F2.1070002@domain.hid>
	<20100316191024.117214qo52wr9aps@domain.hid>
In-Reply-To: <20100316191024.117214qo52wr9aps@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Mini2440 on the kernel 2.6.30.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Michel He <michel.he@domain.hid>
Cc: xenomai@xenomai.org

ok, thanks for help as far as concerned the S3C2440 issues on that board.

So what has been previously found out is: no external clock connected =20
on pin clk1 of timer 3, instead timer 2 and 3 are used to drive the =20
sound module. Since I get changed the timer 3 to timer 1, it can boot =20
to shell. However, the xenomai test give a 7000 us of average latency, =20
it is even worst than pure Linux system. Also, the USB, nor the camera =20
won't work at all (the system get freezed when plug them in). The UART =20
and LCD are OK. The sound is buggy due to lags, it seems the buffer =20
not continuously filled up by linux. So far the others modules are not =20
tested.

Something should get wrong, but no idea how to figure it out.

Michel He <michel.he@domain.hid> a =E9crit=A0:

> How can I exactly figure out which driver is using the Timer 3 ? I =20
> wonder if there's a list of interrupt somewhere ? in irq.c -> =20
> watch-dog and ac97, Both are disactivated from the kernel.
>
>
>
> Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> a =E9crit=
=A0:
>
>> Michel He wrote:
>>> Still not working after reactivation of Timer 3. Here's the codes :
>>
>> Well, if timer 3 is used by another driver in the system, no wonder that
>> it does not work. You will not get it to work by just changing a few
>> things here and there. You have to actually understand what is needed
>> and fix the implementation (probably to use another timer). Fortunately,
>> you have the I-pipe porting guide to arm to understand what is needed.
>>
>>
>> --
>> Gilles Chanteperdrix, Free Electrons
>> Kernel, drivers, real-time and embedded Linux
>> development, consulting, training and support.
>> http://free-electrons.com
>>
>
>



