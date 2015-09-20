MIME-Version: 1.0
In-Reply-To: <20150920081716.GH22852@hermes.click-hack.org>
References: <CAFkYNwbawB8iHkJA51FpuQFDDY2aYBj2_aMontPadSBf=VZ8AA@mail.gmail.com>
 <20150919151106.GD22852@hermes.click-hack.org>
 <20150919151423.GE22852@hermes.click-hack.org>
 <CAFkYNwZSskEBYeHOK1UEXi7iGucm5x=O7wBB9YQ+1A_Gu9iGgA@mail.gmail.com>
 <CAFkYNwZS5Js_22DMKozYciMwVUKxPbUJ0-FoAxoY50rfxtcBQA@mail.gmail.com>
 <20150920081716.GH22852@hermes.click-hack.org>
Date: Sun, 20 Sep 2015 21:39:08 +1200
Message-ID: <CAFkYNwY_sQxtHYfB=Y-bcpGyfaENWjAwnx0Yc7VvWcEPaUH+fg@mail.gmail.com>
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

I got the ,/configure to proceed a step further.It still complains that
checking whether the C compiler works... no
configure: error: in `/home/qws/PandaBoard-ee/xenomai-3':
configure: error: C compiler cannot create executables
See `config.log' for more details

configure:2960: arm-linux-gnueabihf- --version >&5
/home/qws/PandaBoard-ee/xenomai-3/configure: line 2962:
arm-linux-gnueabihf-: command not found
configure:2971: $? = 127
configure:2960: arm-linux-gnueabihf- -v >&5
/home/qws/PandaBoard-ee/xenomai-3/configure: line 2962:
arm-linux-gnueabihf-: command not found
configure:2971: $? = 127
configure:2960: arm-linux-gnueabihf- -V >&5
/home/qws/PandaBoard-ee/xenomai-3/configure: line 2962:
arm-linux-gnueabihf-: command not found
configure:2971: $? = 127
configure:2960: arm-linux-gnueabihf- -qversion >&5
/home/qws/PandaBoard-ee/xenomai-3/configure: line 2962:
arm-linux-gnueabihf-: command not found
configure:2971: $? = 127
configure:2991: checking whether the C compiler works
configure:3013: arm-linux-gnueabihf- -march=armv7-a -mfpu=vfp3
-march=armv7-a -mfpu=vfp3 conftest.c  >&5
/home/qws/PandaBoard-ee/xenomai-3/configure: line 3015:
arm-linux-gnueabihf-: command not found
configure:3017: $? = 127
configure:3055: result: no

Any comments would be very appreciated, please?

Thank you



On 20 September 2015 at 20:17, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On Sun, Sep 20, 2015 at 08:04:31PM +1200, vibnwis wrote:
> > Any idea how to set the --host for Linaro toolchain?
>
> Actually, this is documented in Xenomai build instructions:
> https://xenomai.org/installing-xenomai-3-x/#Cross-compilation
>
> --
>                                             Gilles.
> https://click-hack.org
>
