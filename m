Message-ID: <4E09F05A.1020405@domain.hid>
Date: Tue, 28 Jun 2011 17:16:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTimFiO9JAdvYjpnx9bpvFo2W1zYX3g@domain.hid>	<4E0478F7.40706@domain.hid>	<BANLkTikFipPQVsa3tYPGSgEbQEzKEC7mEw@domain.hid>	<4E09DCC2.30709@domain.hid>
	<BANLkTi=1FwjGE5xVdepRhSifab-cMEHj3g@domain.hid>
In-Reply-To: <BANLkTi=1FwjGE5xVdepRhSifab-cMEHj3g@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Fwd: Regarding booting
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

On 06/28/2011 05:06 PM, suresh reddy wrote:
> On 28 June 2011 15:53, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
> 
>> On 06/28/2011 03:08 PM, suresh reddy wrote:
>>> Hi all ,
>>>
>>> i have followed  through the below mentioned procedure  and i have
>> strucked
>>> in the final step of boot process.
>>>
>>> modprobe: FATAL: Could not load /lib/modules/2.6.37.6/modules.dep: No
>> such
>>> file or directory
>>
>> The below mentioned procedure was to test whether xenomai worked on your
>> panda board, and by no means a complete installation of Xenomai. The
>> conclusion is: Xenomai works on your board.
>>
>> Now, if you want a complete installation, refer to Xenomai installation
>> instructions,
> 
> Do you mean  complete instructions as below on my host machine  as mentioned
> in 2.1 of xenomai document and
> 
> $ $xenomai_root/scripts/prepare-kernel.sh --arch=x86 \
>   --adeos=$xenomai_root/ksrc/arch/x86/patches/adeos-ipipe-2.6.29.4-x86-X.Y-ZZ.patch
> \
>   --linux=$linux_tree
> $ cd $linux_tree
> $ make [ARCH=i386] xconfig/gconfig/menuconfig # select the kernel and
> Xenomai options
> $ make [ARCH=i386] bzImage modules # then install as needed
> $ mkdir $build_root && cd $build_root
> $ $xenomai_root/configure --enable-x86-sep (*) \
>   [--host=i686-linux CFLAGS="-m32 -O2" LDFLAGS="-m32"]
> 
> $ make install
> 
> preparing and building the target kernel as mentioned in 1.1 of the document
> which i have done until now.
> 
> $ $xenomai_root/scripts/prepare-kernel.sh --arch=arm \
>   --adeos=$xenomai_root/ksrc/arch/arm/patches/adeos-ipipe-2.6.20-arm-* \
>   --linux=$linux_tree
> $ cd $linux_tree
> $ make ARCH=arm CROSS_COMPILE=arm-linux- O=$build_root csb637_defconfig
> $ make ARCH=arm CROSS_COMPILE=arm-linux- O=$build_root bzImage modules
> # [manually install the kernel image, system map and modules to the
> proper location]
> $ cd $build_root
> $ $xenomai_root/configure --build=i686-pc-linux-gnu --host=arm-linux
> --enable-arm-mach=at91rm9200 --enable-arm-tsc
> $ make DESTDIR=$staging_dir install
> 
> 
> 
> Is this completes the complete installation process ?
> 

No, the complete installation instructions of xenomai are in the file
"README.INSTALL" in Xenomai sources, here you are citing only one part
of it. But they assume you already know how to install Linux, which is
why the module installation is not detailed and we tell you "manually
install the kernel image, system map and modules to the proper location".

So, you should learn how to compile a custom version of the kernel for
your board, and when you know how to do that, following xenomai
installations will be easy.

Using google 5 minutes, I found:
http://www.omappedia.com/wiki/Building_Linux_OMAP_Kernel
http://labs.igep.es/index.php/The_Linux_kernel
http://www.cyberciti.biz/tips/compiling-linux-kernel-26.html
http://www.digitalhermit.com/linux/Kernel-Build-HOWTO.html
http://www.tuxradar.com/content/how-compile-linux-kernel

-- 
					    Gilles.

