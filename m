MIME-Version: 1.0
Sender: had2006@gmail.com
Date: Tue, 3 Mar 2015 08:49:41 +0000
Message-ID: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Xenomai/cobalt: low_init(): binding failed: Function not
 implemented error issued when trting to run latency app on xeno 3.x-rc3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org, Helder Daniel <hdaniel@ualg.pt>

Hi,

I use Xenomai (and RTAI  before) to introduce real time Linux in a course I
ran at the university of Algarve :

http://tutoria.ualg.pt/2014/course/view.php?id=2067

This year we moved to Xenomai version 3.x series.
We start using Mercury because its easier to teach students install in any
pc (at least to work as a simulator over a not full real time vanilla
kernel)

Now I am trying to install Xenomai 3.x-rc3 with dual-core cobalt kernel.
I already installed Mercury single kernel, over a vanilla kernel and a
PREEMPT_RT patched kernel and run successfully the demo apps, like
"latency", and some simple apps,kernel and user space, that i developed for
previous Xenomai and RTAI versions (following the migration documentation)

However with Mercury flavour I couldn't make the registry to work, to share
some named Xenomai syncronization objects,like mutexes across different
processes,although xenomai be configured with:

./configure --with-core=mercury --enable-registry

When trying to run apps it gives me an error saying that the registry
daemon is not working:

   3"004.187| WARNING: [main] cannot connect to registry daemon
   3"004.187| BUG: [main] initialization failed, EAGAIN

Also could not find registry at /var/run/xenomai/...
This folder is not even present.

But Apps were compiled with xenomai support, using xeno-config to get the
parameters. The makefile that i use with my apps:

target =  simple
skin   :=  native       #or in v3.x SKIN   :=  alchemy

CFLAGS := $(shell xeno-config --skin=$(skin) --cflags)
LDFLAGS := $(shell xeno-config --skin=$(skin) --ldflags)

$(target): $(target).c
$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)



Disabling registry support passing the switch:

--no-registry

Apps run fine, however I have no registry support to share objects between
different processes. I can not bind to a Xenomai object created by one
process from other process.

So I tried to install cobalt to see if I could work with the registry (and
also to try it :))

I patch a kernel 2.14.28 with patch ipipe-core-3.14.28-x86-7.patch

I think this is the right patch for that kernel.
It give me no errors when patching, but I am not sure because I tried
before to patch kernel 2.16.2 with ipipe-core-3.16-x86-2.patch
it gave me also no errors when patching, but then I suspected that maybe it
is the wrong kernel source and that this patch is to apply on a 3.16
kernel(3.16 not 3.16.2). Is this right?

So I patch another kernel, from kernel.org archives, with another patch:

kernel 2.14.28 with ipipe-core-3.14.28-x86-7.patch

hoping thats the right patch to this kernel.

When I run make menuconfig the Xenomai/cobalt section was present so i
think the patch was applied correcty.

I configure it according to xenomai install notes:

http://xenomai.org/installing-xenomai-3-x/#Configuring_and_compiling_the_Cobalt_kernel

namely:

CONFIG_X86_MINIMUM_CPU_FAMILY=5 #Pentium 4

# CONFIG_CPU_FREQ is not set
# CONFIG_CPU_IDLE is not set
# CONFIG_APM is not set
# CONFIG_ACPI is not set
# CONFIG_ACPI_PROCESSOR  is not set

# CONFIG_CONTEXT_TRACKING_FORCE is not set
# CONFIG_CC_STACKPROTECTOR is not set
# CONFIG_INTEL_IDLE is not set
# CONFIG_INPUT_PCSPKR is not set

# CONFIG_KGDB  is not set

And append to version name the version as ipipe:

CONFIG_LOCALVERSION="-ipipe"

I created 2 debian packages to install. One with kernel image and the other
with the headers:

make-kpkg --initrd kernel_image kernel_headers

So I install it with:

dpkg -i linux-headers-3.14.28-ipipe_3.14.28-ipipe-10.00.Custom_i386.deb
dpkg -i linux-image-3.14.28-ipipe_3.14.28-ipipe-10.00.Custom_i386.deb

Then I recompile Xenomai to cobalt:

> make clean
> ./configure --with-core=cobalt --enable-registry
> make install

I configure xeno PATHs and libs:

a) add to the end of /etc/ld.so.conf

/usr/xenomai/lib

and execute: ldconfig

b) add to the end of /etc/profile :

export PATH=$PATH:/usr/xenomai/bin
export MANPATH=$MANPATH:/usr/xenomai/share/man/

then I reboot it with new patched kernel 3.14.28 and
then when trying to run:

/usr/xenomai/bin/latency

it gives the error:

Xenomai/cobalt: low_init(): binding failed: Function not implemented error

The same with Apps of my own.

I tried to find for xenomai in boot log with:

dmesg | grep -i xenomai

it returns me:

[    0.868031] [Xenomai] scheduling class idle registered.
[    0.868031] [Xenomai] scheduling class rt registered.
[    0.868031] [Xenomai] init failed, code -19

Also I noticed in the boot messages some issue with xenomai and udev:

udevd[337]: specified group 'xenomai' unknown

I already tried to find help in the mailing list archives but i could not
find a solution (maybe i did not look at the right messages :( )

It is possible that I am applying the wrong patch for the wrong kernel?

I thank any suggestion you may have.

PS: I am running on Debian 7.8 on a virtual machine (VMWare player 7) on a
AMD Athlon processor and also on a dual core
Intel core 2 duo P8600.
I did not try to install on a physical pc yet because the idea is to get a
VMware image Xenomai ready for student to run rigth at the beginning of the
course.
However previous versions of xenomai were sucessfuly ran over VMware, so I
was not expecting issues here (but maybe I should try on a physicl pc)





great work with Xenomai :)


Helder



-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
