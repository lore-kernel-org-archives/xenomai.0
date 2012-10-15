MIME-Version: 1.0
In-Reply-To: <507C2A38.4030308@xenomai.org>
References: <507C2940.7000005@gmail.com>
	<507C2A38.4030308@xenomai.org>
Date: Mon, 15 Oct 2012 16:42:24 +0100
Message-ID: <CANfTc7LUsE5xh_=xF02o9Rh_PSMYRnu_EVkZh3QMgYYwVsBbhw@mail.gmail.com>
From: Stefan Videv <videvstefan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Problem Compiling/Building UserSpace Support for ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Thanks, Gilles! Worked a threat!

-- Stefan

On Mon, Oct 15, 2012 at 4:22 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 10/15/2012 05:18 PM, Stefan Videv wrote:
> > Hello!
> >
> > I've been trying to compile the user-space support for the latest
> > version of Xenomai for ARM but failing.
> >
> > After downloading the source files, and running
> >
> > ./configure --build=i686-pc-linux-gnu --host=arm-linux-gnueabi
> > CFLAGS="-march=armv7-a -mfpu=vfp3" LDFLAGS="-march=armv7-a"
>
> That is because your toolchain compiles by default for thumb. Add -marm
> to CFLAGS, thumb user-space are currently unsupported.
>
> --
>                                             Gilles.
>
