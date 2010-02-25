Message-ID: <20100225164651.15503clnikl4sq5k@domain.hid>
Date: Thu, 25 Feb 2010 16:46:51 +0100
From: Michel He <michel.he@domain.hid>
References: <20100224161747.77015rxwv9jyh5a8@domain.hid>
	<4B8548E4.3060505@domain.hid>
In-Reply-To: <4B8548E4.3060505@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Adeos-main] port to s3c2440  /  mini2440
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

Ok many thanks for the tips.

Refering to the webpage, actually the cause should be :
     *  If the kernel locks at "Calibrating delay loop...", it means =20
that the timer interrupt is not ticking and that the delay calibration =20
routine is running an infinite loop at while (ticks =3D=3D jiffies) in =20
function calibrate_delay, file init/calibrate.c. To help debugging =20
this situation, you can put printks in the while (ticks =3D=3D jiffies) =20
loop, printing any hardware timer registers or status register you want.

It seems that S3C2440 / Mini2440 Timer has changed. There is no more =20
register named S3C2410_T...

But I have no experience in debugging ARM cpu hardware timer... Nor =20
have time to investigate further how to debug the port...

You can still find the kernel on FriendlyARM.net



Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> a =E9crit=A0:

> Michel He wrote:
>> hello all,
>>
>>     Is there anyone who managed to port Adeos I-Pipe to the arm9
>> S3C2440 of the Mini2440 board (Friendly-ARM) ?
>
> The s3c24xx support is still in the I-pipe patch, if it was not, the
> compilation of the kernel with CONFIG_IPIPE would not even work.
>
>>
>>     The boot is blocked in the __delay function. Something maybe wrong
>> with the interrupt scheduling ...
>
> This port has been contributed a long time ago. Since then, we use an
> "optimistic testing strategy", we make sure that the port compiles, but
>  we assume people really having that board are in charge of testing our
> releases. Not having a board based on this chip, it would be hard for us
> to test it. IOW, I have no idea whether it is supposed to work.
>
> I suggest you assume nothing, read:
> http://www.xenomai.org/index.php/I-pipe:ArmPorting
>
> And try and debug your port. It even contains a tip for the particular
> case you are mentioning.
>
> --
> =09=09=09=09=09    Gilles.
>



