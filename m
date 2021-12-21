MIME-Version: 1.0
From: Jiayu Cao <bitterblossom5486@gmail.com>
Date: Tue, 21 Dec 2021 12:02:02 +0800
Message-ID: <CAFV-vNBrxyj2XJ2=M3w7ZtiyqmL+SZ_H0ma8JOeyJ+7m+jvnDw@mail.gmail.com>
Subject: 'make bzImage' compile error at x86_64 platform: FAILED unresolved
 symbol udp_sock
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Xenomai development group:

I am working on Xenomai 3.2.1 and Ubuntu 20.04 OS.
I am trying to build a kernel image based on the linux-oem-5.10.0-1044.46
kernel, which is a Ubuntu kernel and the mainline base version is *Linux
5.10.46*. The kernel's source code folder path is ~/linux-oem-5.10-5.10.0/.
Then I extracted the Dovetail patch to linux-oem-5.10-5.10.0/ folder ,
which version is *patch-5.10.46-dovetail1.patch.bz2*. Then I typed the
following commands:
```
cd linux-oem-5.10-5.10.0/

~/Downloads/xenomai-v3.2.1/scripts/prepare-kernel.sh --arch=x86_64
--dovetail=patch-5.10.46-dovetail1.patch

make menuconfig
# I did no extra configuration in the kernel configuration and just save a
.config file.
# Actually I've tried to compile the image multiple times with different
configurations, but I got the same error each time.

make bzImage
# Got error here
```

And the error log is:
```
  LD      .tmp_vmlinux.btf
  BTF     .btf.vmlinux.bin.o
  LD      .tmp_vmlinux.kallsyms1
  KSYMS   .tmp_vmlinux.kallsyms1.S
  AS      .tmp_vmlinux.kallsyms1.S
  LD      .tmp_vmlinux.kallsyms2
  KSYMS   .tmp_vmlinux.kallsyms2.S
  AS      .tmp_vmlinux.kallsyms2.S
  LD      vmlinux
  BTFIDS  vmlinux
FAILED unresolved symbol udp_sock
make: *** [Makefile:1205: vmlinux] Error 255
```
The purely Linux kernel without Dovetail patch could be compiled
successfully, thus I tried to compare the* .config* file under these two
situations (success and failed) with 'meld' tool.
However, I only watched some modifications about the XEN virtual machine.
I also googled it but cannot figure out any related solutions.

Could you provide some solutions for me? Thanks for your help!

Sincerely,
Jiayu.
