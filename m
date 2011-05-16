Message-ID: <4DD13882.8000708@domain.hid>
Date: Mon, 16 May 2011 16:45:22 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <89B30389DB4AE240AC1227F3FDBB7CCF029B910A@ontex.i.omicron.de>	<4DCD2EE8.2010904@domain.hid>	<89B30389DB4AE240AC1227F3FDBB7CCF029B910B@ontex.i.omicron.de>	<4DD102DA.9080206@domain.hid>
	<4DD107AD.5000307@domain.hid>
	<89B30389DB4AE240AC1227F3FDBB7CCF029B910F@ontex.i.omicron.de>
In-Reply-To: <89B30389DB4AE240AC1227F3FDBB7CCF029B910F@ontex.i.omicron.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] build xenomai userspace app, illegal instruction
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Koenig, Florian" <F.Koenig@domain.hid>
Cc: xenomai@xenomai.org

Hello,

On 05/16/2011 03:27 PM, Koenig, Florian wrote:
> Hi,
> i started from new and have done the following:
> 
> 
> i deleted /opt/eldk-4.2 and installed it new with:
> $ ./install -d /opt/eldk-4.2 ppc_4xx

BTW: also be aware of ELDK_FIXOWER and ELDK_MAKEDEV.b

> Then i setup env-vars and goto /usr/src/xenomai-2.5.6:
> $ export ARCH=powerpc
> $ export DESTDIR=/opt/eldk-4.2/ppc_4xx
> $ export PATH=$PATH:/opt/eldk-4.2/usr/bin:/opt/eldk-4.2/bin
> 
> Then i configured xenomai userspace with:
> $ ./configure --host=powerpc-linux      (without --prefix=)
> $ make
> $ make install
> 
> Then i goto /usr/src/xenomai/examples and run:
> $ make XENO=/opt/eldk-4.2/ppc_4xx/usr/xenomai/bin
> 
> And then it returns, where it searches for includes in
> -I/lib/modules/2.6.32-5-686/build/include/xenomai/posix
> Which is my local x86 kernel, not the powerpc kernel?

The kernel is used just for build Xenomai kernel modules. For
cross-compilation you must provide "KSRC=<path-to-your-kernel>. But it's
*not* used for building user-space apps.

> make XENO=/opt/eldk-4.2/ppc_4xx/usr/xenomai/
> --xeno-cflags is deprecated, use --skin=name --cflags instead --xeno-ldflags
> is deprecated, use --skin=name --ldflags instead
> make[1]: Entering directory `/usr/src/xenomai-2.5.6/examples/rtdm/driver-api'
> powerpc-linux-gcc -I/opt/eldk-4.2/ppc_4xx/usr/xenomai/include -D_GNU_SOURCE
> -D_REENTRANT -Wall -pipe -D__XENO__   -L/opt/eldk-4.2/ppc_4xx/usr/xenomai/lib
> -lxenomai -lpthread  -lnative -lrtdm -Xlinker -rpath -Xlinker
> /opt/eldk-4.2/ppc_4xx/usr/xenomai/lib  tut01-skeleton-app.c   -o
> tut01-skeleton-app
> tut01-skeleton-app.c:54: warning: second argument of 'main' should be 'char
> **'

Looks good now. The path is pointing to the Xenomai installation dir:
/opt/eldk-4.2/ppc_4xx/usr/xenomai/

> After copying trivial-periodic to 405GP cpu, it returns illegal instruction.

Hm, in a previous mail I asked if the installed Xenomai programs from
the test suite like "latency" or "cyclictest" do work. Is that the case?
If not, it's most likely not a build problem.

> Is /opt/eldk-4.2 meant to be the rootfs of the 405GP cpu ? I use a initramfs,
> which is placed in /usr/src/initramfs, so i only copy the xenomai lib/ folder
> from /opt/eldk-4.2/ppc_4xx/lib into my initramfs/lib folder.

It's up to you to define the rootfs and install the Xenomai programs into:

  $ export DESTDIR=/usr/src/initramfs
  $ cd xenomai-2.5.6
  $ make install

That's likely to much data. The following should work as well:

  $ make install-exec


Wolfgang.

