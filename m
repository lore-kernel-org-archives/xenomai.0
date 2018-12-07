MIME-Version: 1.0
References: <CAK+-5=KyqTMv7+Dw_zZWyrWjeyF6P43kvS5iwWWtNWkqrsqvQA@mail.gmail.com>
In-Reply-To: <CAK+-5=KyqTMv7+Dw_zZWyrWjeyF6P43kvS5iwWWtNWkqrsqvQA@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Fri, 7 Dec 2018 09:32:12 -0500
Message-ID: <CALLqZ8R9bC0F2t14-a-jktCRUvwMLJPXf3h+09=MDAdVciSj2Q@mail.gmail.com>
Subject: Re: rtdm spi demo on Raspberri pi
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ho Tam <mophong@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

I've played with it a bit, I'll see if I have any example code laying
around.  Did you unbind the linux spi driver?

Thanks

Greg
On Thu, Dec 6, 2018 at 9:50 PM Ho Tam via Xenomai <xenomai@xenomai.org> wrote:
>
> Hello group,
> I can see there is rtdm spi driver for raspberry pi but can't see any
> userspace demo for it.
> I have built and inserted xeno_spi_bcm2835, xeno_spi modules but couldn't
> see any spi device in '/dev/rtdm/'.
> Does anyone have example using this driver?
> Thank you
> --

