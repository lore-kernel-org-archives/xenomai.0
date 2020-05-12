Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: RT I2C Raspberry Driver
From: ayaida marwane <ayaida_marwane@yahoo.fr>
In-Reply-To: <CALLqZ8S+dW8+MSSrOnAtbKYy5n9tMgbGL=vtVerCGrZr6YUq5Q@mail.gmail.com>
Date: Tue, 12 May 2020 03:55:18 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <9034BFCC-5B53-4EB5-A134-4F3084EF920D@yahoo.fr>
References: <2499CEB7-33FE-4F86-B075-FB4C5E9751FF.ref@yahoo.fr>
 <2499CEB7-33FE-4F86-B075-FB4C5E9751FF@yahoo.fr>
 <CALLqZ8S+dW8+MSSrOnAtbKYy5n9tMgbGL=vtVerCGrZr6YUq5Q@mail.gmail.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Greg, Hi all,

Thank you Greg for your clarifications.

I have some more questions below.

BR,
Marwane.

> Le 11 mai 2020 =C3=A0 16:39, Greg Gallagher <greg@embeddedgreg.com> a =
=C3=A9crit :
>=20
> Hi,
>=20
> On Mon, May 11, 2020 at 3:05 AM ayaida marwane via Xenomai
> <xenomai@xenomai.org> wrote:
>>=20
>> Dear all,
>>=20
>> We need to communicate in RT with a sensor (accelerometer) working =
with I2C protocol using a Raspberry 3 or 4 with Xenomai 3. The objective =
is, for example, to detect a collision in RT.
>>=20
>> Is there any driver already existing in Xenomai 3 that could help us?
>=20
> Does the sensor support SPI? There is an existing SPI RTDM driver that
> will work on the Raspberry Pi 3.

We have few sensors. Some of these sensors support I2C and SPI. Where =
can I find the existing SPI RTDM driver that work with Raspberry Pi 3?

>>=20
>> To do this, we want to use RTDM driver for that. If not possible, we =
could use also Alchemy or Posix Skin or other from Kernel or Userland. =
The most important is to do it in RT.
>>=20
>> Could you help us please?
>=20
> If you need I2C you'd have to implement the I2C rtdm driver similar to
> the SPI driver.  I don't think anyone has tried Xenomai on the
> raspberry pi 4 yet (anyone?).  You may want to stick with the
> raspberry pi 3 and then eventually try getting the arm64 ipipe running
> on the raspberry pi 4.

Ok, we will try to do it for Raspberry Pi 3 if it is easier. Then, we =
will see for Raspberry Pi 4.

If we will succeed, we will distribute it. So any help, indications or =
recommendations are welcome.

Thank you in advance for your help.

>=20
>>=20
>> Best regards,
>> Marwane Ayaida.
>=20
> Thanks
>=20
> Greg


