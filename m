MIME-Version: 1.0
References: <CAEmXcAwpre7qQrw9ipS5_f5hUXyB6a+LzD945oZdr4tGd4WifQ@mail.gmail.com>
 <b6355451-15c4-4156-70de-d19ee842cb0e@qmul.ac.uk>
 <CAEmXcAyXPb1r4B4_DxiAhOfuXerGkpRkbgFWgK44cWA9KsR92g@mail.gmail.com>
 <520d0b03-4fd6-3b07-8629-36fa57fee95d@qmul.ac.uk>
In-Reply-To: <520d0b03-4fd6-3b07-8629-36fa57fee95d@qmul.ac.uk>
From: danwe <daniel.wenninger92@gmail.com>
Date: Sun, 18 Aug 2019 21:19:35 +0200
Message-ID: <CAEmXcAzk=pOcf2MEcLMA7hry_TY13=MAsRKWDS=-3JO6E-shWQ@mail.gmail.com>
Subject: Re: Access to Mini-USB-port on BeagleBone Black
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, xenomai@xenomai.org

Okay thanks.
I am not using Xenomai 3 because for BeagleBone Black there is no Driver
for using Xenomai 3 *and *RTnet.

Am So., 18. Aug. 2019 um 16:44 Uhr schrieb Giulio Moro <g.moro@qmul.ac.uk>:

> danwe wrote:
> > I'm sorry I forgot to say that I was using Xenomai 2 with RTnet on top.
> I think RTnet is the problem isn't it? What exactly does RTnet to stop
> using mini usb port?
> >
> > Kind regards
> >
> > Daniel
>
> You surely cannot use RTnet on that port, if that is what you are asking,
> because that uses the Linux usb gadget driver. If the question is why you
> cannot use the mini USB port while using RTnet on the ethernet port, I am
> not sure what the answer is, as I have never used RTnet. Again, I'd look at
> what features are enabled in your kernel and whether the drivers that are
> supposed to handle that are loaded, and check the system log. Basically,
> the instructions I gave earlier  will still apply if you have a half recent
> kernel (they are from 4.4). Maybe someone else on the list will have more
> insights on the specifics of RTNet, but you'd have to make a clearer
> question, providing your kernel and Xenomai version, and also go through
> the checklist I mentioned earlier. You need to understand that Xenomai 2 is
> no longer supported, so you'd really have to make it easy for people to
> help you. Also, why are you not using Xenomai 3?
>
> Giulio
>
