Date: Thu, 5 May 2016 10:25:39 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160505082539.GL1761@hermes.click-hack.org>
References: <CAJ2oMhKmN34tBFwYr0W1bAkBsmPyiSC+CGVEXkZhV7C4Jid01Q@mail.gmail.com>
 <20160503204457.GI1761@hermes.click-hack.org>
 <20160503211715.GJ1761@hermes.click-hack.org>
 <CAJ2oMh+JM7ukb+QoZ7ksa_NpJwFNH7hiCCRLUHpSubv67yBukw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMh+JM7ukb+QoZ7ksa_NpJwFNH7hiCCRLUHpSubv67yBukw@mail.gmail.com>
Subject: Re: [Xenomai] xenomai & zynq
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ran Shalit <ranshalit@gmail.com>
Cc: xenomai@xenomai.org

On Thu, May 05, 2016 at 08:41:15AM +0300, Ran Shalit wrote:
> On Wed, May 4, 2016 at 12:17 AM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
> > On Tue, May 03, 2016 at 10:44:57PM +0200, Gilles Chanteperdrix wrote:
> >> On Tue, May 03, 2016 at 11:21:16PM +0300, Ran Shalit wrote:
> >> > Hello,
> >> >
> >> > I hope someone will have idea about the following.
> >> > I try to build xenomai 3 .
> >> > The configure seems to works fine, but
> >> >  make <DESTDIR> install, gives errors:
> >> > ".....
> >> > Making install in init
> >> > make[4]: Entering directory
> >> > `/home/ubuntu/zynq/xenomai_3/xenomai-3.0.2/lib/boilerplate/init'
> >> >   CC       libbootstrap_a-bootstrap.o
> >> > In file included from ../../../include/xenomai/init.h:21:0,
> >> >                  from bootstrap.c:23:
> >> > ../../../include/boilerplate/setup.h:27:2: error: unknown type name 'cpu_set_t'
> >> >   cpu_set_t cpu_affinity;
> >> >   ^
> >> > ../../../include/boilerplate/setup.h: In function 'get_program_name':
> >> > ../../../include/boilerplate/setup.h:107:2: error: implicit
> >> > declaration of function 'basename'
> >> > [-Werror=implicit-function-declaration]
> >> >   return basename(__base_setup_data.arg0 ?: "program");
> >> >   ^
> >> > ...."
> >> > I configure it as following:
> >> >   ./configure CFLAGS="-march=armv7-a -mfpu=neon"
> >> > LDFLAGS="-march=armv7-a -mfpu=neon"   --build=i686-pc-linux-gnu
> >> > --host=arm-xilinx-eabi --with-core=cobalt
> >> >
> >> > But When I change the host cross compiles from
> >> > host=arm-xilinx-eabi
> >> > to
> >> > host=arm-none-linux-gnueabi
> >> >
> >> > than  build is completed without errors.
> >> >
> >> > Is there anything wrong with the configuration I use with zynq ?
> >> > I am not sure if arm-none-linux-gnueabi can be used instead of arm-xilinx-eabi.
> >> > Is there anyone who used xenomai with zynq ?
> >>
> >> arm-xilinx-eabi is a compiler without glibc or uclibc. Xenomai needs
> >> glibc or uclibc, so can not be compiled with arm-xilinx-eabi.
> >> arm-none-linux-gnueabi is fine. However, you may want to find a
> >> toolchain for Zynq with glibc, because the Zynq has an FPU, and
> >> arm-none-linux-gnueabi (usually) uses soft floats, so is not an
> >> optimal choice for Zynq.
> >
> > You probably want arm-xilinx-linux-gnueabi mentioned on this page:
> > http://www.wiki.xilinx.com/Install+Xilinx+Tools
> >
> > --
> >                                             Gilles.
> > https://click-hack.org
> 
> Gilles,
> 
> Thank you very much for this !
> I found out that a newer xilinx toolchain does support glibc now.

The toolchain with glibc support is not new. It has always been
provided for Linux, because it is needed to compile Linux
user-space support, for the Petalinux distribution. So, it has been
available for at least as long as Petalinux has been available for
Zynq.

The arm-xilinx-eabi toolchain is made to compile "bare-metal" code,
without Linux. You can use it to compile the Linux kernel, because
the Linux kernel is in fact "bare metal" code which does not require
a libc, but you can not use it to build Linux user-space programs.

The Zynq wiki has a lot of information, maybe you should consider
reading it before jump to conclusions about things you ignore.

-- 
					    Gilles.
https://click-hack.org

