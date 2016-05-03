Date: Tue, 3 May 2016 22:44:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160503204457.GI1761@hermes.click-hack.org>
References: <CAJ2oMhKmN34tBFwYr0W1bAkBsmPyiSC+CGVEXkZhV7C4Jid01Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ2oMhKmN34tBFwYr0W1bAkBsmPyiSC+CGVEXkZhV7C4Jid01Q@mail.gmail.com>
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

On Tue, May 03, 2016 at 11:21:16PM +0300, Ran Shalit wrote:
> Hello,
> 
> I hope someone will have idea about the following.
> I try to build xenomai 3 .
> The configure seems to works fine, but
>  make <DESTDIR> install, gives errors:
> ".....
> Making install in init
> make[4]: Entering directory
> `/home/ubuntu/zynq/xenomai_3/xenomai-3.0.2/lib/boilerplate/init'
>   CC       libbootstrap_a-bootstrap.o
> In file included from ../../../include/xenomai/init.h:21:0,
>                  from bootstrap.c:23:
> ../../../include/boilerplate/setup.h:27:2: error: unknown type name 'cpu_set_t'
>   cpu_set_t cpu_affinity;
>   ^
> ../../../include/boilerplate/setup.h: In function 'get_program_name':
> ../../../include/boilerplate/setup.h:107:2: error: implicit
> declaration of function 'basename'
> [-Werror=implicit-function-declaration]
>   return basename(__base_setup_data.arg0 ?: "program");
>   ^
> ...."
> I configure it as following:
>   ./configure CFLAGS="-march=armv7-a -mfpu=neon"
> LDFLAGS="-march=armv7-a -mfpu=neon"   --build=i686-pc-linux-gnu
> --host=arm-xilinx-eabi --with-core=cobalt
> 
> But When I change the host cross compiles from
> host=arm-xilinx-eabi
> to
> host=arm-none-linux-gnueabi
> 
> than  build is completed without errors.
> 
> Is there anything wrong with the configuration I use with zynq ?
> I am not sure if arm-none-linux-gnueabi can be used instead of arm-xilinx-eabi.
> Is there anyone who used xenomai with zynq ?

arm-xilinx-eabi is a compiler without glibc or uclibc. Xenomai needs
glibc or uclibc, so can not be compiled with arm-xilinx-eabi.
arm-none-linux-gnueabi is fine. However, you may want to find a
toolchain for Zynq with glibc, because the Zynq has an FPU, and
arm-none-linux-gnueabi (usually) uses soft floats, so is not an
optimal choice for Zynq.

Regards.

-- 
					    Gilles.
https://click-hack.org

