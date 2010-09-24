Message-ID: <4C9D0A94.9030501@domain.hid>
Date: Fri, 24 Sep 2010 22:31:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <AANLkTimFXFr48DgXSj=53pNjAQB7w+mjOwwuEYQXc3KV@mail.gmail.com>
In-Reply-To: <AANLkTimFXFr48DgXSj=53pNjAQB7w+mjOwwuEYQXc3KV@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] switchtest/xeon-test fails: Help needed
 (Ubuntu/Core i7)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gajamohan Mohanarajah <gajamohan.m@domain.hid>
Cc: xenomai@xenomai.org

Gajamohan Mohanarajah wrote:
> Hi,
> 
> I'm am new to Xenomai and would appreciate any help / hint on solving
> the following problems.
> 1. My switchtest fails with ioctl(RTTST_RTIOC_SWTEST_CREATE_KTASK):
> Cannot allocate memory.
> If increasing CONFIG_XENO_OPT_SYS_HEAPSZ is the solution what is the
> recommended value ? (1024k did not work)
> (FYI: Memory 8GB )

You probably need to increase XENO_OPT_SYS_STACKPOOLSZ. The size
required is proportional to the number of cpus, so with 8 cpus, you
probably need a lot of room.

> 2. xeno-test fails with [something died a XXXX or ...]

Forget about xeno-test, it is currently broken.

> 3. I am compiling the kernel using [fakeroot make-kpkg --initrd
> --append-to-version=-xenomaiflv kernel-image kernel-headers
> --overlay-dir=$HOME/kernel-package]. After changing just the
> CONFIG_XENO_OPT_SYS_HEAPSZ via [make menuconfig], when I issue the the
> above command, the kernel goes on to a full recompile which  takes 2
> hours :(. Shouldn't it compile just the relevent parts ? (FYI i am not
> using [make-kpkg clean]). Please enlighten me on this.

That is because your distro uses rules which date back from 2.4, where
make clean was necessary to be sure that everything was taken into
account. Maybe there is some hidden flag to these tools in order to
avoid the "make clean"? Have you tried "man make-kpkg"?

You can also configure your kernel to only keep what is needed for your
real-time system. In any case, please make sure to take a look at:
http://www.xenomai.org/index.php/Configuring_x86_kernels


-- 
                                                                Gilles.

