Message-ID: <45D98774.7070400@domain.hid>
Date: Mon, 19 Feb 2007 12:18:12 +0100
MIME-Version: 1.0
Subject: Re: [Xenomai-help] getting started (Part 2)
References: <45D887EF.8010404@domain.hid>
	<17880.36271.503322.588359@domain.hid>
In-Reply-To: <17880.36271.503322.588359@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
From: Roland Tollenaar <rwatollenaar@domain.hid>
Reply-To: rolandtollenaar@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-help@domain.hid

Hi

I have followed the directives of Richard and Gilles (thanks) and now 
have a rough idea of what the steps should be to install Xenomai. I 
still have some questions before I start.

I apologize in advance for amount of text surrounding the not so many 
questions. I have tried to be a clear as possible.

A
The first part of the installation is preparing the kernel
I have 2.6.16 kernel so I have downloaded the
adeos-ipipe-2.6.16-i386-1.5-02.patch.
I have no idea what architecture I have but i386 sounds familiar. :)
How can I test what architecture I have?
Is this the correct patch?
Calling prepare-kernel.sh with its arguments seems straight-forward 
after that.

B
Compiling the kernel. My biggest worry here is the configuration. 
Knowing nothing of such configurations I would like to avoid having to 
make uneducated guesses in this stage. Is it possible to get hold of the 
current kernel configuration and load that in the
make menuconfig
stage?
If yes, how?

C
Subsequently calling
make
then
make modules_install install
What happens in this install step? What files/directories are installed 
and where? Reason I ask is because I am running from liveUSB and booting 
with syslinux so I will have to write the kernel image (vmlinuz on my 
system) to /dev/sda1 (via where ever it is mounted of course) and not to 
/boot/ on that same drive.

Another question in this regard is that my current kernel image is 
called vmlinuz not bzImage the documentation talks about all the time. 
What is the difference? Can I rename the bzImage to vmlinuz. Take note 
of the fact that the USB has a FAT filesystem. Thus symbolic links do 
not work and I instead have to make copies instead.

Then captain's universe mutters about creating the initial RAM-disk (if 
I need one). How do I know whether I need one? I know that running from 
a liveUSB I do need what is called initrd.gz in the boot process, but is 
this what the documentation is talking about?

How do I finally set up the new kernel to be booted. Is it sufficient to 
write it (vmlinuz) to the position where the current kernel image is 
located? (safely renaming the current kernel image to "vmlinuz-old" of 
course :))

Sorry again for so many newbie questions.

RR



Gilles Chanteperdrix wrote:
> Roland Tollenaar wrote:
>  > Could anyone direct me to somewhat more 
>  > "my-first-xenomai&kernel-experience" instructions?
> 
> Hi Roland,
> 
> You will find detailed information on how to build a kernel there:
> http://www.digitalhermit.com/linux/Kernel-Build-HOWTO.html
> 
> Once you have read that, the instructions in Xenomai README.INSTALL
> should be enough to learn the rest.
> 
> If you have some problem during the build process, do not hesitate to
> ask questions here.
> 

