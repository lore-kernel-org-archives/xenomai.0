MIME-Version: 1.0
In-Reply-To: <BLU437-SMTP29D359A6746B3F160FFE69F0890@phx.gbl>
References: <56E5F4B4.9030807@googlemail.com>
 <CA+CJOCzH=jrnM70D3=8ix1i25eMGpemv_Te_Tk3aWbUeZ86j6g@mail.gmail.com>
 <BLU437-SMTP29D359A6746B3F160FFE69F0890@phx.gbl>
From: Nicolas SCHURANDO <schurann@ext.essilor.com>
Date: Mon, 21 Mar 2016 16:41:59 +0100
Message-ID: <CA+CJOCyuEohMS4NjtOmewB+7BzbG=OTCQ2UfESamyoA736J4Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai-3.0.1 with raspberry pi
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathieu Rondonneau <mathieu_rondonneau@hotmail.com>
Cc: xenomai@xenomai.org

Thanks Mathieu for the reminder. I had bookmarked Philippe's new year
message introducing the specific vendor branch, but in the interval I
somehow forgot it existed.

I was able to produce a working Xenomai 3.0 image for the Raspberry Pi 1
using the bcmrpi_defconfig as a base. It seems stable so far.

However, when using bcm2709_defconfig, the generated kernel won't boot on a
Raspberry Pi 2, leaving me with the initial rainbow screen.

Philippe, have you had any feedback from people testing on the Raspberry Pi
2 yet ?

Regards,

Nicolas

2016-03-15 4:58 GMT+01:00 Mathieu Rondonneau <mathieu_rondonneau@hotmail.com
>:

> On 16-03-14 12:47 AM, Nicolas SCHURANDO wrote:
> > Hi Mosta,
> >
> > I have written a quick guide to get Xenomai 3.0 on the Raspberry Pi 2
> > working at
> https://www.raspberrypi.org/forums/viewtopic.php?p=926466#p926466
> > .
> >
> > It relies on a post patch written by a member of the mailing list a few
> > month ago.
> >
> > I however find the system to be very unstable so I would love to hear
> some
> > feedback from you, especially if your system freezes or not.
> >
> > Hope this helps.
> >
> > Regards,
> >
> > Nicolas
> >
> > 2016-03-14 0:16 GMT+01:00 mosta <mosta.me@googlemail.com>:
> >
> >> Hallo everyone,
> >>
> >> I try to compile the current stable release of xenomai for the raspberry
> >> pi2. I found a linuxcnc installation guide for xenomai 2.6.1
> >> (http://wiki.linuxcnc.org/cgi-bin/wiki.pl?RaspbianXenomaiBuild) and I
> >> compiled on image with it, so I use it as a template to compile
> >> xenomai-3.0.1 and the problem I found is that there are pre- and post
> >> patches for the raspberry pi and I can't find any for xenomai-3.0.1 are
> >> they not needed or do I have to create them myself?
> >>
> >> tips and hints for moving forward are welcome.
> >>
> >> greetings mosta
> >>
> >> _______________________________________________
> >> Xenomai mailing list
> >> Xenomai@xenomai.org
> >> https://xenomai.org/mailman/listinfo/xenomai
> >>
> > _______________________________________________
> > Xenomai mailing list
> > Xenomai@xenomai.org
> > https://xenomai.org/mailman/listinfo/xenomai
> >
>
> Thanks Nicolas for taking the time to write the guide.
> I have not looked at the problem but there is port to the 4.1 kernel
> from Philippe Gerum here:
> http://git.xenomai.org/ipipe.git/log/?h=vendors/raspberry/ipipe-4.1
> It is likely more up to date than mine.
>
> Regards,
> -Mathieu
>
