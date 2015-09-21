MIME-Version: 1.0
In-Reply-To: <20150920170330.GA3486@hermes.click-hack.org>
References: <CAFkYNwbawB8iHkJA51FpuQFDDY2aYBj2_aMontPadSBf=VZ8AA@mail.gmail.com>
 <20150919151106.GD22852@hermes.click-hack.org>
 <20150919151423.GE22852@hermes.click-hack.org>
 <CAFkYNwZSskEBYeHOK1UEXi7iGucm5x=O7wBB9YQ+1A_Gu9iGgA@mail.gmail.com>
 <CAFkYNwZS5Js_22DMKozYciMwVUKxPbUJ0-FoAxoY50rfxtcBQA@mail.gmail.com>
 <20150920081716.GH22852@hermes.click-hack.org>
 <CAFkYNwY_sQxtHYfB=Y-bcpGyfaENWjAwnx0Yc7VvWcEPaUH+fg@mail.gmail.com>
 <20150920170330.GA3486@hermes.click-hack.org>
Date: Mon, 21 Sep 2015 22:16:53 +1200
Message-ID: <CAFkYNwbHQXK8_YA1A0NLErdcHbYB-PpTMo09VUaae7fgQTmxfw@mail.gmail.com>
From: vibnwis <vibnwis@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Installing xenomai libraries ARM OMAP4460
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

I managed to get autoreconf -if to work, and advanced to compiling the
xenomai. However, yet not to the end. I got the following error. Then I
switch xenomai-gch. The same error as well. Hence, I changed the CC to
Ubuntu arm-linux-gnueabihf package. The same error too. The errors are as
follow.

checking for ARM machine... configure: error: Selecting a machine with
--enable-arm-mach is mandatory

and the command is  ./configure CFLAGS="-march=armv7-a -mfpu=vfp3"
LDFLAGS="-march=armv7-a -mfpu=vfp3" --with-core=cobalt --enable-smp
--enable-pshared --build=x86_64-linux-gnu --host=arm-linux-gnueabihf

if I added --enable-arm-mach, I get error messages "checking for ARM
machine... configure: error: Invalid machine selected: "yes"".

Googles don't seem to get any positive resolution. Appreciate any comments.

Thank you



On 21 September 2015 at 05:03, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Sun, Sep 20, 2015 at 09:39:08PM +1200, vibnwis wrote:
> > I got the ,/configure to proceed a step further.It still complains that
> > checking whether the C compiler works... no
> > configure: error: in `/home/qws/PandaBoard-ee/xenomai-3':
> > configure: error: C compiler cannot create executables
> > See `config.log' for more details
> >
> > (...)
> >
> > Any comments would be very appreciated, please?
>
> Sorry, sent the mail to the wrong address.
>
> Once again, please read:
> http://xenomai.org/installing-xenomai-3-x/#Cross-compilation
>
> Or if you are looking for more information, see:
>
> https://www.sourceware.org/autobook/autobook/autobook_139.html#Cross-Compilation
>
> --
>                                             Gilles.
> https://click-hack.org
>
