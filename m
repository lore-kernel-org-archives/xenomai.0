Date: Mon, 02 Jul 2007 23:16:01 +0200
From: Stephan Guenther <guenther@domain.hid>
Message-ID: <C2AF37B1.DCD4%guenther@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Subject: [Xenomai-help] Xenomai & Gumstix cross compiling
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

Hello,
I have to install Xenomai on a gumstix (ARM architecture). So I did the
following:

1) I looked for a compatible Gumstix Build root (one with a kernel version
matching a Xenomai Patch). That was Gumstix SVN revision 936 (2.6.15
kernel).

2) I startet the Gumstix Buildroot and interrupted it as soon as the kernel
was downloaded. At this point, it is a vanilla kernel to which gumstix
specific patches will be applied later in the build root process.
I extractet the kernel, applied the correct Adeos patch and the Xenomai
patches by running "scripts/prepare-kernel.sh <path_to_adeos_patched_kernel>
-- arch=arm"

3) I bzipped the resulting kernel and copied it in the Gumstix build root
(so it will not be downloaded or overwritten again). Then I startet the
Gumstix build root process again and configured everything without errors.
The Xeonmai options where available.
After the process had finished I copied the image on my gumstix. The gumstix
is booting up correctly and loading the Xenomai domain - everything seems to
be alright.

4) Now I had to cross compile Xenomai on my i386 host. I used ELDT (Embedded
Linux Development Tools) and run the following commands in the xenomai root
directory:

xenomai_root/configure --build=i686-linux --host=arm-linux CC=arm-linux-gcc
LD=arm-linux-ld
make DESTDIR=/home/.../xenobin install

After this I copied the contents of the subdirectories xenobin/dev and
xenobin/usr on my gumstix.
If I try to run the test binaries (i.e. /usr/xenomai/bin/latancy or
/usr/xenomai/bin/share/.../latancy/run) it gives me that strange error:

/usr/xenomai/bin/xeno-load: line 239: /usr/xenomai/bin/latency: No such file
or directory

But this file exists and it has the correct permissions set.  A "file
latency" on the x86 host gives the following:

ELF 32-bit LSB executable, ARM, version 1, for GNU/Linux 2.3.4, dynamically
linked (uses shared libs), not stripped

Seems to be ok for me.


What is wrong? Has anyone tried to patch a gumstix with Xenomai before? Are
there tutorials about cross compiling for ARM?


Best regards, 
Stephan Guenther



