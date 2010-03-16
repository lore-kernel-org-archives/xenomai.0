Message-ID: <20100316191024.117214qo52wr9aps@domain.hid>
Date: Tue, 16 Mar 2010 19:10:24 +0100
From: Michel He <michel.he@domain.hid>
References: <20100316150037.11405209mnid677k@domain.hid>
	<4B9FB4A8.6000903@domain.hid>
	<20100316183247.34995yxgivc3ilj4@domain.hid>
	<4B9FC1F2.1070002@domain.hid>
In-Reply-To: <4B9FC1F2.1070002@domain.hid>
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

How can I exactly figure out which driver is using the Timer 3 ? I =20
wonder if there's a list of interrupt somewhere ? in irq.c -> =20
watch-dog and ac97, Both are disactivated from the kernel.



Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> a =E9crit=A0:

> Michel He wrote:
>> Still not working after reactivation of Timer 3. Here's the codes :
>
> Well, if timer 3 is used by another driver in the system, no wonder that
> it does not work. You will not get it to work by just changing a few
> things here and there. You have to actually understand what is needed
> and fix the implementation (probably to use another timer). Fortunately,
> you have the I-pipe porting guide to arm to understand what is needed.
>
>
> --
> Gilles Chanteperdrix, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
>



