Message-ID: <4BE10B3F.20708@domain.hid>
Date: Wed, 05 May 2010 08:07:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <n2k633455b31005041938k29ad6c0br4e8092c19232ed68@domain.hid>
In-Reply-To: <n2k633455b31005041938k29ad6c0br4e8092c19232ed68@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] install xenomai for beagleboard
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Everett Wang <everteq@domain.hid>
Cc: xenomai@xenomai.org

Everett Wang wrote:
> (...)
> It runs fine. But I have some random questions.
> 
> where is the bzImage it made and modules I just made? 

bzImage is an x86 thing. Your questions is not really specific to
Xenomai, it is about compiling a Linux kernel for ARM. There are a lot
of resources on internet which will answer this question. For instance,
this is answered by Linux arm kernel FAQ #1:
http://www.arm.linux.org.uk/mailinglists/faq.php#f1
Or, Beagle specific instructions on Beagle wiki:
http://elinux.org/BeagleBoard#Linux_kernel

> Should I use a
> newer version of Code Sourcery's cross compiler? I am using
> arm-2009q1-203-arm-none-linux-gnueabi and there is an
> arm-2010q1-202-arm-none-linux-gnueabi. I have difficult to follow
> in compiling xenomai. 

Any version should be almost Ok. Except one of the 2008 version if you
want to enable stack unwinding.


> The instruction reads:
> 
> "cd $build_root
> $ $xenomai_root/configure --build=i686-pc-linux-gnu --host=arm-linux
> --enable-arm-mach=at91rm9200 --enable-arm-tsc"
> 
> I have not defined a $build_root directory and what is the right name
> to replace at91rm9200 and tsc?

the instructions also read:
--enable-arm-mach   Select ARM machine for the       none
                    current build tree, check
                    configure --help for a list
                    of valid values.
                    Passing this option is
                    mandatory when compiling
                    Xenomai for ARM

and:
# $linux_tree = path to the target kernel sources
# $xenomai_root = path to the Xenomai sources
# $build_root = path to a clean build directory
# $staging_dir = path to a directory that will hold the installed file

Again, the issue here is about compiling a package using the autotools,
there is nothing specific about Xenomai. There is a lot of resources
about this on the web. For instance:
http://sources.redhat.com/autobook/autobook/autobook_13.html#SEC13
I even wrote a tutorial for the autotools some time ago:
http://sisyphus.hd.free.fr/~gilles/pub/autotools/

-- 
					    Gilles.

