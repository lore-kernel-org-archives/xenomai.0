Message-ID: <4DFF2D33.8090702@domain.hid>
Date: Mon, 20 Jun 2011 13:21:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTi=DsC9d_LVt3deiBCUAQq2-UubTuA@mail.gmail.com>
In-Reply-To: <BANLkTi=DsC9d_LVt3deiBCUAQq2-UubTuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] regarding freezing at booting
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: suresh reddy <sureshreddy.balijepalli@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 06/20/2011 11:52 AM, suresh reddy wrote:
> Dear xenomai,
> 
> I compiled the the kernel and builded the uImage . I transfered the uImage
> to FAT partion of SD Card  and the directories DEV and usr (That generated
> due to make DESTDIR) to root filesystem of the sd card.
> 
> i started booting from sd card . It giving me the below result and freezing.
> Iam seeing nothing on terminal after this .

It means the kernel encountered an error before the console is enabled.
Enable CONFIG_EARLY_PRINTK and pass earlyprintk on the kernel command
line to know what the problem is.

Note that since I told you to download ipipe-gch, I finalized the port
of the I-pipe patch on panda board. So, if you download the ipipe-gch
git again, you will be able to enable CONFIG_SMP.


> And i thought whether my uImage that i created was crashed , so thought of
> building it again .
> when i run the make uImage , it giving me error No rule to make target
> uImage . stop
> 
> make ARCH=arm CROSS_COMPILE=arm-none-linux-gnueabi-
> O=/home/balijepalli/pandaboard/build uImage
> make: *** No rule to make target `uImage'.  Stop.
> 
> then i ran
> test06:/home/balijepalli/pandaboard/ipipe-gch# make ARCH=arm
> CROSS_COMPILE=arm-none-linux-gnueabi- O=/home/balijepalli/pandaboard/build
> omap4_panda_defconfig
> make: *** No rule to make target `omap4_panda_defconfig'.  Stop.
> 
> so i went to to 1st step to check scripts/prepare. kernel.sh as below
>  test06:/home/balijepalli/pandaboard/xenomai-2.5.6#
> scripts/prepare-kernel.sh --linux=/home/balijepalli/pandaboard/ipipe-gch
> --arch=arm
> scripts/prepare-kernel.sh: line 350: linux_: command not found
> 
> 
>  i checked this scripts/prepare.kernel.sh by downloading the xenomai again
> but i got the same error.

I do not know what to do from this explanation. You are giving us either
too much or not enough information.

Some ideas:

The prepared kernel should be built in the sources directory or in its
own build directory. And this is an exclusive or, if you start mixing
out-of-tree build with in-source builds you start having problems.

The omap4_panda_defconfig does not exist in the I-pipe patch, you have
to configure the kernel manually (start from omap2plus_defconfig, and
disable all options related to other omaps than omap4).

You should not try and prepare a kernel which has already been prepared.

-- 
                                                                Gilles.

