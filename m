Message-ID: <20100719184826.21461mofq8kwzh7k@domain.hid>
Date: Mon, 19 Jul 2010 18:48:26 +0200
From: Michel He <michel.he@domain.hid>
References: <20100316150037.11405209mnid677k@domain.hid>
	<4B9FB4A8.6000903@domain.hid>
	<20100316183247.34995yxgivc3ilj4@domain.hid>
	<4B9FC1F2.1070002@domain.hid>
	<20100316191024.117214qo52wr9aps@domain.hid>
	<20100709114655.46571rvnivjguu4w@domain.hid>
	<4C36F32A.4080404@domain.hid>
In-Reply-To: <4C36F32A.4080404@domain.hid>
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
To: xenomai@xenomai.org

Hello Gilles,

    I just tested the latest I-pipe with Xenomai versions 2.5.3. So =20
the average latency 7000 us has slightly been improved. It is now =20
about 4000 us, that's too much for servo motor controlling. The =20
S3C2410 PWM divider is 1/2 (this is the minimum) and the prescalar is =20
set to 0 (no shift)...

Bye !

Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> a =E9crit=A0:

> Michel He wrote:
>> ok, thanks for help as far as concerned the S3C2440 issues on that board.
>>
>> So what has been previously found out is: no external clock connected
>> on pin clk1 of timer 3, instead timer 2 and 3 are used to drive the
>> sound module. Since I get changed the timer 3 to timer 1, it can boot
>> to shell. However, the xenomai test give a 7000 us of average latency,
>> it is even worst than pure Linux system. Also, the USB, nor the camera
>> won't work at all (the system get freezed when plug them in). The UART
>> and LCD are OK. The sound is buggy due to lags, it seems the buffer
>> not continuously filled up by linux. So far the others modules are not
>> tested.
>>
>> Something should get wrong, but no idea how to figure it out.
>
> The timer issue you had should have been fixed in the latest I-pipe
> versions. Could you try Xenomai 2.5.3 and one of the I-pipe patch it
> contains and see if it has the same latencies issues?
>
> --
> =09=09=09=09=09    Gilles.
>



