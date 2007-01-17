Message-ID: <cbe23c50701170051r46cadf4cha5b144d17df2ec77@domain.hid>
Date: Wed, 17 Jan 2007 09:51:47 +0100
From: "Eric Noulard" <eric.noulard@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] Compiling Linux+Xenomai 32bits kernel on FC6 x86_64?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all,

I am a Xenomai beginner.

I am trying to compile and boot a 32bits (adeos/xenomai patched) Linux Kernel
on a Fedora Core 6 x86_64 system and I do run into trouble
getting an early

"runaway loop modprobe binfmt-464c"
at boot time.

I did compile the patched kernel using

cd /path/to/patched_linux_src
make ARCH=i386 O=/path/to/builddir menuconfig
make O=/path/to/builddir menuconfig
cp arch/i386/boot/bzImage /boot/vmlinuz-2.6.19-xenomai-2.3
cp System.map /boot/System.map-2.6.19-xenomai-2.3
make O=/path/to/builddir menuconfig modules_install
mkinitrd initrd-x2.6.19-xenomai-2.3.img  2.6.19-xenomai-2.3
cp initrd-x2.6.19-xenomai-2.3.img /boot

and then update grub.conf accordingly

So here is my question:

Is it possible to run/boot a 32bit xenomai on a 64 bit system
or should I really need to install a 32bit only system on my 64 bit machine?
If yes how to do this properly?
If no
   - is there a planned support for 64bit in xenomai/adeos?
   - what should I do to use Xenomai on my 64 bit machine?

Thanks in advance.
-- 
Erk

