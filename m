Date: Mon, 29 Nov 2010 19:50:14 +0100
From: inflo <inflo@domain.hid>
Message-Id: <20101129195014.b79eb9be.inflo@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: inflo@domain.hid
Subject: [Xenomai-help] xenomai user lib build error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>


hi,
i wanna build xenomai user libs for powerpc 40x (405GP) cpu. The patching (preparing) of the linux kernel (2.6.36.7) works with the adeos patch.

But when i want to build the user libs, i get the error that e.g. linux/errno.h could not be found. linux/errno.h is in /usr/src/linux-2.6.35.7/include/linux/errno.h so it must be a false setup path i think, but i dont know where i should do that?

i configure and build the stuff like the README.INSTALL tells, just with another cross compile prefix

scripts/prepare-kernel.sh --arch=powerpc \
  --adeos=$xenomai_root/ksrc/arch/powerpc/patches/adeos-ipipe-2.6.35.7-ppc-1.5-*.patch \
  --linux=$linux_tree
cd $linux_tree
make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- O=$build_root menuconfig

[select the kernel and Xenomai options, save the configuration]
make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- O=$build_root uImage
[manually install the kernel image, system map and modules to the proper location]
cd $build_root
$xenomai_root/configure  --host=powerpc-linux-gnu \
  CC=powerpc-linux-gnu-gcc LD=powerpc-linux-gnu-ld
make DESTDIR=$staging_dir install

The kernel builds without errors, but the xenomai stuff doesnt find the missing headers like linux/errno.h, but i dont know why?

thanks for help
flo

-- 
inflo <inflo@domain.hid>

