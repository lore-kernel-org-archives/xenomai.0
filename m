MIME-Version: 1.0
In-Reply-To: <20150920081125.GG22852@hermes.click-hack.org>
References: <CAFkYNwbawB8iHkJA51FpuQFDDY2aYBj2_aMontPadSBf=VZ8AA@mail.gmail.com>
 <20150919151106.GD22852@hermes.click-hack.org>
 <20150919151423.GE22852@hermes.click-hack.org>
 <CAFkYNwZSskEBYeHOK1UEXi7iGucm5x=O7wBB9YQ+1A_Gu9iGgA@mail.gmail.com>
 <CAFkYNwZS5Js_22DMKozYciMwVUKxPbUJ0-FoAxoY50rfxtcBQA@mail.gmail.com>
 <20150920081125.GG22852@hermes.click-hack.org>
Date: Mon, 21 Sep 2015 00:02:54 +1200
Message-ID: <CAFkYNwainOiZv64r+r46=7mXMTvxS_rdb7gifzpCZHzE3Jvh9Q@mail.gmail.com>
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

Hi Gilles and all,

Having had bad experience with Linaro toolchain, arm-linux-gnueabihf-, I
now change to arm-none-linux-. Unfortunately, I still get the same error
messages.

checking for arm-none-linux-gcc... arm-none-linux-gnueabi-
checking whether the C compiler works... no
configure: error: in `/home/qws/PandaBoard-ee':
configure: error: C compiler cannot create executables
I have googled for hours, but couldn't get anything positive.

Please help.

Thank you

On 20 September 2015 at 20:11, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Sun, Sep 20, 2015 at 08:04:31PM +1200, vibnwis wrote:
> > Thanks, I managed to get .configure by executing autoreconf -i. However,
> I
> > am facing another problem.
> >
> > $xenomai_root/configure CC=arm-linux-gnueabihf- CFLAGS="-march=armv7-a
> > -mfpu3=vfp" LDFLAGS="-march=armv7-a -mfpu=vfp3" --build=i686-pc-linux-gnu
> > --host=${CC}  --with-core=cobalt
> > (...)
> > Any idea how to set the --host for Linaro toolchain?
>
> My answer to your first mail already contained the answer to that
> question.
>
> --
>                                             Gilles.
> https://click-hack.org
>
