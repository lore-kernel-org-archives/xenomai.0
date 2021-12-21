MIME-Version: 1.0
References: <CAFV-vNBrxyj2XJ2=M3w7ZtiyqmL+SZ_H0ma8JOeyJ+7m+jvnDw@mail.gmail.com>
In-Reply-To: <CAFV-vNBrxyj2XJ2=M3w7ZtiyqmL+SZ_H0ma8JOeyJ+7m+jvnDw@mail.gmail.com>
From: Jiayu Cao <bitterblossom5486@gmail.com>
Date: Tue, 21 Dec 2021 16:36:25 +0800
Message-ID: <CAFV-vNC36t-NaByyEJcnR_4EVKzuS-BG8O+Tha=aJf2TTN6nGQ@mail.gmail.com>
Subject: Re: 'make bzImage' compile error at x86_64 platform: FAILED
 unresolved symbol udp_sock
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I downloaded linux-dovetail source code from
https://source.denx.de/Xenomai/linux-dovetail, then I got the same problem
too. I compiled the kernel image on the ubuntu20 virtual machine. So I
guess it might be the issue of OS version or VM?

Jiayu Cao <bitterblossom5486@gmail.com> =E4=BA=8E2021=E5=B9=B412=E6=9C=8821=
=E6=97=A5=E5=91=A8=E4=BA=8C 12:02=E5=86=99=E9=81=93=EF=BC=9A

> Hi Xenomai development group:
>
> I am working on Xenomai 3.2.1 and Ubuntu 20.04 OS.
> I am trying to build a kernel image based on the linux-oem-5.10.0-1044.46
> kernel, which is a Ubuntu kernel and the mainline base version is *Linux
> 5.10.46*. The kernel's source code folder path
> is ~/linux-oem-5.10-5.10.0/.
> Then I extracted the Dovetail patch to linux-oem-5.10-5.10.0/ folder ,
> which version is *patch-5.10.46-dovetail1.patch.bz2*. Then I typed the
> following commands:
> ```
> cd linux-oem-5.10-5.10.0/
>
> ~/Downloads/xenomai-v3.2.1/scripts/prepare-kernel.sh --arch=3Dx86_64
> --dovetail=3Dpatch-5.10.46-dovetail1.patch
>
> make menuconfig
> # I did no extra configuration in the kernel configuration and just save =
a
> .config file.
> # Actually I've tried to compile the image multiple times with different
> configurations, but I got the same error each time.
>
> make bzImage
> # Got error here
> ```
>
> And the error log is:
> ```
>   LD      .tmp_vmlinux.btf
>   BTF     .btf.vmlinux.bin.o
>   LD      .tmp_vmlinux.kallsyms1
>   KSYMS   .tmp_vmlinux.kallsyms1.S
>   AS      .tmp_vmlinux.kallsyms1.S
>   LD      .tmp_vmlinux.kallsyms2
>   KSYMS   .tmp_vmlinux.kallsyms2.S
>   AS      .tmp_vmlinux.kallsyms2.S
>   LD      vmlinux
>   BTFIDS  vmlinux
> FAILED unresolved symbol udp_sock
> make: *** [Makefile:1205: vmlinux] Error 255
> ```
> The purely Linux kernel without Dovetail patch could be compiled
> successfully, thus I tried to compare the* .config* file under these two
> situations (success and failed) with 'meld' tool.
> However, I only watched some modifications about the XEN virtual machine.
> I also googled it but cannot figure out any related solutions.
>
> Could you provide some solutions for me? Thanks for your help!
>
> Sincerely,
> Jiayu.
>
