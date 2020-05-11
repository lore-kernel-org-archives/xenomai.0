MIME-Version: 1.0
References: <2499CEB7-33FE-4F86-B075-FB4C5E9751FF.ref@yahoo.fr>
 <2499CEB7-33FE-4F86-B075-FB4C5E9751FF@yahoo.fr>
In-Reply-To: <2499CEB7-33FE-4F86-B075-FB4C5E9751FF@yahoo.fr>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 11 May 2020 10:39:48 -0400
Message-ID: <CALLqZ8S+dW8+MSSrOnAtbKYy5n9tMgbGL=vtVerCGrZr6YUq5Q@mail.gmail.com>
Subject: Re: RT I2C Raspberry Driver
Content-Type: text/plain; charset="UTF-8"
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

On Mon, May 11, 2020 at 3:05 AM ayaida marwane via Xenomai
<xenomai@xenomai.org> wrote:
>
> Dear all,
>
> We need to communicate in RT with a sensor (accelerometer) working with I2C protocol using a Raspberry 3 or 4 with Xenomai 3. The objective is, for example, to detect a collision in RT.
>
> Is there any driver already existing in Xenomai 3 that could help us?

Does the sensor support SPI? There is an existing SPI RTDM driver that
will work on the Raspberry Pi 3.
>
> To do this, we want to use RTDM driver for that. If not possible, we could use also Alchemy or Posix Skin or other from Kernel or Userland. The most important is to do it in RT.
>
> Could you help us please?

If you need I2C you'd have to implement the I2C rtdm driver similar to
the SPI driver.  I don't think anyone has tried Xenomai on the
raspberry pi 4 yet (anyone?).  You may want to stick with the
raspberry pi 3 and then eventually try getting the arm64 ipipe running
on the raspberry pi 4.

>
> Best regards,
> Marwane Ayaida.

Thanks

Greg

