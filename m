MIME-Version: 1.0
In-Reply-To: <CAFkYNwZSskEBYeHOK1UEXi7iGucm5x=O7wBB9YQ+1A_Gu9iGgA@mail.gmail.com>
References: <CAFkYNwbawB8iHkJA51FpuQFDDY2aYBj2_aMontPadSBf=VZ8AA@mail.gmail.com>
 <20150919151106.GD22852@hermes.click-hack.org>
 <20150919151423.GE22852@hermes.click-hack.org>
 <CAFkYNwZSskEBYeHOK1UEXi7iGucm5x=O7wBB9YQ+1A_Gu9iGgA@mail.gmail.com>
Date: Sun, 20 Sep 2015 20:04:31 +1200
Message-ID: <CAFkYNwZS5Js_22DMKozYciMwVUKxPbUJ0-FoAxoY50rfxtcBQA@mail.gmail.com>
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

Thanks, I managed to get .configure by executing autoreconf -i. However, I
am facing another problem.

$xenomai_root/configure CC=arm-linux-gnueabihf- CFLAGS="-march=armv7-a
-mfpu3=vfp" LDFLAGS="-march=armv7-a -mfpu=vfp3" --build=i686-pc-linux-gnu
--host=${CC}  --with-core=cobalt
checking whether we build for Cobalt or Mercury core... cobalt
checking build system type... i686-pc-linux-gnu
checking host system type... Invalid configuration
`/home/qws/linaro-gcc/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux/bin/arm-linux-gnueabihf-':
machine
`/home/qws/linaro-gcc/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux/bin/arm-linux-gnueabihf'
not recognized
configure: error: /bin/bash config/config.sub
/home/qws/linaro-gcc/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux/bin/arm-linux-gnueabihf-
failed

I have my Linaro toolchain set as
CC=/home/qws/linaro-gcc/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux/bin/arm-linux-gnueabihf-
and by setting the --host=${CC}, the configure refuse to recognise it. I
tried without the suffix. See below.

qws@qws-MacBookPro:~/PandaBoard-ee/xenomai-3$ $xenomai_root/configure
CFLAGS="-march=armv7-a -mfpu=vfp3" LDFLAGS="-march=armv7-a -mfpu=vfp3"
--build=i686-pc-linux-gnu --host=arm-linux-gnueabihf- --with-core=cobalt
checking whether we build for Cobalt or Mercury core... cobalt
checking build system type... i686-pc-linux-gnu
checking host system type... Invalid configuration `arm-linux-gnueabihf-':
machine `arm-linux-gnueabihf' not recognized
configure: error: /bin/bash config/config.sub arm-linux-gnueabihf- failed

Any idea how to set the --host for Linaro toolchain?

Thank in advance.






On 20 September 2015 at 12:09, vibnwis <vibnwis@gmail.com> wrote:

> I downloaded ipipe-ipipe-core-3.18.20-arm-5 and tried to run ./configure,
> file not found as well. In addition, I checked in the ./scripts directory,
> none of the configure or autoreconf exist. It is not the right source I
> have downloaded? Any comments please.
>
