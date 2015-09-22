MIME-Version: 1.0
In-Reply-To: <20150921144615.GA20753@hermes.click-hack.org>
References: <CAFkYNwbawB8iHkJA51FpuQFDDY2aYBj2_aMontPadSBf=VZ8AA@mail.gmail.com>
 <20150919151106.GD22852@hermes.click-hack.org>
 <20150919151423.GE22852@hermes.click-hack.org>
 <CAFkYNwZSskEBYeHOK1UEXi7iGucm5x=O7wBB9YQ+1A_Gu9iGgA@mail.gmail.com>
 <CAFkYNwZS5Js_22DMKozYciMwVUKxPbUJ0-FoAxoY50rfxtcBQA@mail.gmail.com>
 <20150920081716.GH22852@hermes.click-hack.org>
 <CAFkYNwY_sQxtHYfB=Y-bcpGyfaENWjAwnx0Yc7VvWcEPaUH+fg@mail.gmail.com>
 <20150920170330.GA3486@hermes.click-hack.org>
 <CAFkYNwbHQXK8_YA1A0NLErdcHbYB-PpTMo09VUaae7fgQTmxfw@mail.gmail.com>
 <20150921144615.GA20753@hermes.click-hack.org>
Date: Tue, 22 Sep 2015 14:13:55 +1200
Message-ID: <CAFkYNwYS1NLVK9Kx7ZiVWaM37mLRyfLMFHMV9=on1yjhTux6Fw@mail.gmail.com>
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

On 22 September 2015 at 02:46, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Mon, Sep 21, 2015 at 10:16:53PM +1200, vibnwis wrote:
> > Hi Gilles,
> >
> > I managed to get autoreconf -if to work, and advanced to compiling the
> > xenomai. However, yet not to the end. I got the following error. Then I
> > switch xenomai-gch. The same error as well. Hence, I changed the CC to
> > Ubuntu arm-linux-gnueabihf package. The same error too. The errors are as
> > follow.
> >
> > checking for ARM machine... configure: error: Selecting a machine with
> > --enable-arm-mach is mandatory
> >
> > and the command is  ./configure CFLAGS="-march=armv7-a -mfpu=vfp3"
> > LDFLAGS="-march=armv7-a -mfpu=vfp3" --with-core=cobalt --enable-smp
> > --enable-pshared --build=x86_64-linux-gnu --host=arm-linux-gnueabihf
> >
> > if I added --enable-arm-mach, I get error messages "checking for ARM
> > machine... configure: error: Invalid machine selected: "yes"".
> >
> > Googles don't seem to get any positive resolution. Appreciate any
> > comments.
>
> You are trying to compile an outdated version of Xenomai, Xenomai
> version 2.5 or earlier. You can have access to the installation
> instructions for that particular version in the sources (the file is
> named README.INSTALL at the top of the sources tree), or on the
> website, using the URL:
>
> http://xenomai.org/documentation/xenomai-2.5/README.INSTALL
>
> for instance, if installing the version 2.5. Replace 2.5 with the
> version you are actually installing.
>

I use Xenomai-3 of which I use patches namely
kernel/cobalt/arch/arm/patches/ipipe-core-3.18.12-arm-4.patch patched the
kernel 3.18.12. And under Xenomai-3, I autoreconf -fi to create a configure
file and finally make it xenomai libs and test apps. Under the installed is
has two directory, dev and usr. Under the usr/ it has xenomai/bin, etc.

Have I missed out anything? in terms getting it the test apps as well as
the related device files to work.


> --
>                                             Gilles.
> https://click-hack.org
>
