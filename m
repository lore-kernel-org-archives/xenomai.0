MIME-Version: 1.0
References: <2499CEB7-33FE-4F86-B075-FB4C5E9751FF.ref@yahoo.fr>
 <2499CEB7-33FE-4F86-B075-FB4C5E9751FF@yahoo.fr>
 <CALLqZ8S+dW8+MSSrOnAtbKYy5n9tMgbGL=vtVerCGrZr6YUq5Q@mail.gmail.com>
 <9034BFCC-5B53-4EB5-A134-4F3084EF920D@yahoo.fr>
In-Reply-To: <9034BFCC-5B53-4EB5-A134-4F3084EF920D@yahoo.fr>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Wed, 13 May 2020 00:02:41 -0400
Message-ID: <CALLqZ8TuNFbVhPYO1B+shdqz=SW0sE1w8zAw6v7ApPqTZ3w4zw@mail.gmail.com>
Subject: Re: RT I2C Raspberry Driver
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ayaida marwane <ayaida_marwane@yahoo.fr>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

On Mon, May 11, 2020 at 9:55 PM ayaida marwane <ayaida_marwane@yahoo.fr> wr=
ote:
>
> Hi Greg, Hi all,
>
> Thank you Greg for your clarifications.
>
> I have some more questions below.
>
> BR,
> Marwane.
>
> > Le 11 mai 2020 =C3=A0 16:39, Greg Gallagher <greg@embeddedgreg.com> a =
=C3=A9crit :
> >
> > Hi,
> >
> > On Mon, May 11, 2020 at 3:05 AM ayaida marwane via Xenomai
> > <xenomai@xenomai.org> wrote:
> >>
> >> Dear all,
> >>
> >> We need to communicate in RT with a sensor (accelerometer) working wit=
h I2C protocol using a Raspberry 3 or 4 with Xenomai 3. The objective is, f=
or example, to detect a collision in RT.
> >>
> >> Is there any driver already existing in Xenomai 3 that could help us?
> >
> > Does the sensor support SPI? There is an existing SPI RTDM driver that
> > will work on the Raspberry Pi 3.
>
> We have few sensors. Some of these sensors support I2C and SPI. Where can=
 I find the existing SPI RTDM driver that work with Raspberry Pi 3?

it's located in the xenomai tree at kernel/drivers/spi/, the specific
bcm2835 one is spi-bcm2835.c and the spi framework is in spi-master.c
and spi-device.c
>
> >>
> >> To do this, we want to use RTDM driver for that. If not possible, we c=
ould use also Alchemy or Posix Skin or other from Kernel or Userland. The m=
ost important is to do it in RT.
> >>
> >> Could you help us please?
> >
> > If you need I2C you'd have to implement the I2C rtdm driver similar to
> > the SPI driver.  I don't think anyone has tried Xenomai on the
> > raspberry pi 4 yet (anyone?).  You may want to stick with the
> > raspberry pi 3 and then eventually try getting the arm64 ipipe running
> > on the raspberry pi 4.
>
> Ok, we will try to do it for Raspberry Pi 3 if it is easier. Then, we wil=
l see for Raspberry Pi 4.
>
> If we will succeed, we will distribute it. So any help, indications or re=
commendations are welcome.
Sounds great, if you need help porting the ipipe to this new SOC let
me know, I'd be happy to help.

-Greg
>
> Thank you in advance for your help.
>
> >
> >>
> >> Best regards,
> >> Marwane Ayaida.
> >
> > Thanks
> >
> > Greg
>

