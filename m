Date: Fri, 8 Jul 2016 21:49:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160708194905.GQ9465@hermes.click-hack.org>
References: <CAPXCTbbQ1Lo7voRB1sVOtnZ0yjwhZBgUnzi1YX2rv_CL1z8f0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPXCTbbQ1Lo7voRB1sVOtnZ0yjwhZBgUnzi1YX2rv_CL1z8f0g@mail.gmail.com>
Subject: Re: [Xenomai] Compiling testsuite and utils
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Eder Alves de Moura <edermoura@gmail.com>
Cc: xenomai@xenomai.org

On Fri, Jul 08, 2016 at 04:30:17PM -0300, Eder Alves de Moura wrote:
> Dears,
> 
> I am starting with Xenomai and rt systems and I want to compile it for
> a raspberry pi 2/3 and beaglebone black but first I compiled it to a
> PC and, apparently it is working fine.
> 
> $ dmesg | grep -i xenomai
> [    3.224489] [Xenomai] scheduling class idle registered.
> [    3.224491] [Xenomai] scheduling class rt registered.
> [    3.224515] [Xenomai] disabling automatic C1E state promotion on
> Intel processor
> [    3.224521] [Xenomai] SMI-enabled chipset found, but SMI workaround disabled
>                          (see xenomai.smi parameter). You might encounter
> [    3.224592] I-pipe: head domain Xenomai registered.
> [    3.224916] [Xenomai] Cobalt v3.0.2 (Exact Zero)
> 
> 
> 
> But after install I could not compile the tools for xenomai, running
> 
> $ mkdir $build_root && cd $build_root
> $ $xenomai_root/configure --with-core=cobalt --enable-smp --enable-pshared \
>   --host=i686-linux CFLAGS="-m32 -O2" LDFLAGS="-m32"
> 
> I am receiving the following message
> 
> checking whether we build for Cobalt or Mercury core... cobalt
> checking build system type... x86_64-pc-linux-gnu
> checking host system type... i686-pc-linux-gnu
> checking for a BSD-compatible install... /usr/bin/install -c
> checking for i686-linux-gcc... no
> checking for gcc... gcc
> checking whether the C compiler works... no
> configure: error: in `/home/pc/tools/xenomai-3-3.0.2':
> configure: error: C compiler cannot create executables
> See `config.log' for more details

Are you sure you have everything installed for gcc -m32 to work? I
mean, did you try to compile an "hello world" application with gcc
-m32 to see if the compilation works? Also, what is the point of
compiling in 32 bits mode, why not using a 64 bits kernel and
user-space?

-- 
					    Gilles.
https://click-hack.org

