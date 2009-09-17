Message-ID: <4AB235D9.5060602@domain.hid>
Date: Thu, 17 Sep 2009 15:12:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4303dd240909110600tf787b85td93b46086953a0d9@domain.hid>
In-Reply-To: <4303dd240909110600tf787b85td93b46086953a0d9@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problems with instalation of xenomai in ubuntu
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Flavio de Castro Alves Filho <flavio.alves@domain.hid>
Cc: xenomai@xenomai.org

Flavio de Castro Alves Filho wrote:
> Hello,
> 
> I am new with Xenomai and I am having problems in booting a compiled kernel
> into Ubuntu 8.10. I could compile the kernel with the appropriate patch,
> configured grub to load the new kernel. But, when I boot the new kernel, it
> performs all the boot configurations and at the end, when the gnome is about
> to be loaded, the computer starts to blink the display and then blocks.

Ok, I misread your description.

> 
> I am using the following configuration:
> 
> - x86 platform (my notebook ... an intel core2duo machine)
> - xenomai version 2.4.9
> - linux 2.6.30
> - ubuntu linux 8.10
> I performed the following steps:
> 
> - downloaded file linux-2.6.30.tar.bz2 from kernel.org
> - downloaded file xenomai-2.4.9.tar.bz2 from xenomai website
> - from my home directory, I decompressed both files
> - applied the patch, running the "scripts/prepare-kernel.sh" and provided
> the path for my source files "/home/flavio/linux-2.6.30". The script had
> correctly found the patch to be applied to my sources.
> - make xconfig:
>    - disabled HPET timer support

Try keeping it.

>    - disabled PC Speaker
>    - disabled Power Management Support

Only disable APM, try enabling ACPI, except the "ACPI Processor" option.

>    - disabled CPU frequency scaling
>    - enabled VxWorks emulator
>    - enabled RTAI emulator
>    - enabled Testing drivers
> - make
> - make modules
> - sudo make modules_install

If you have a proprietary graphics module, you need to recompile that
module too.

> - sudo make install
> - cd /boot
> - sudo update-initramfs -c -k 2.6.30
> - created an entry in grub list:

> 
> title Xenomai 2.4.9 Linux 2.6.30
> root (hd0,2)
> kernel /boot/vmlinuz-2.6.30 root=/dev/sda3 ro
> initrd /boot/initrd.img-2.6.30
> savedefault
> boot
> 
> Just as a remark, I performed before the same procedure, except for the
> xenomai patch, and I could execute the linux 2.6.30 kernel in my computer.
> 
> Had anybody passed by the same experience? I have no idea what the problem
> could be.

Please show us the console output anyway.

-- 
					    Gilles.

