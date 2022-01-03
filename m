Message-ID: <6cce7df8-56f3-c991-6fb4-96d5dff40f2d@siemens.com>
Date: Mon, 3 Jan 2022 07:35:21 +0100
MIME-Version: 1.0
Subject: Re: 'make bzImage' compile error at x86_64 platform: FAILED
 unresolved symbol udp_sock
Content-Language: en-US
References: <CAFV-vNBrxyj2XJ2=M3w7ZtiyqmL+SZ_H0ma8JOeyJ+7m+jvnDw@mail.gmail.com>
 <CAFV-vNC36t-NaByyEJcnR_4EVKzuS-BG8O+Tha=aJf2TTN6nGQ@mail.gmail.com>
 <CAFV-vNAPDEdYhNzVAyWQA=Tmb8DLu5csxDEnxh-eLdDaE-nZ6A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <CAFV-vNAPDEdYhNzVAyWQA=Tmb8DLu5csxDEnxh-eLdDaE-nZ6A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jiayu Cao <bitterblossom5486@gmail.com>, xenomai@xenomai.org

On 21.12.21 10:18, Jiayu Cao via Xenomai wrote:
> Alright, I compiled the kernel at Ubuntu 18.04 with GCC version 7.5.0
> successfully. The solution is kind of silly but it does work. Just
> wondering that mistake is related to Ubuntu or GCC version...
> 

I would start with looking for "udp_sock" in the delta between upstream
and that Ubuntu kernel. Or try if the same compiler from 20.04 also
triggers this when compiling an official Dovetail release. In that
latter case, the issue may relate to different default compiler settings
under Ubuntu.

Jan

> Jiayu Cao <bitterblossom5486@gmail.com> 于2021年12月21日周二 16:36写道：
> 
>> I downloaded linux-dovetail source code from
>> https://source.denx.de/Xenomai/linux-dovetail, then I got the same
>> problem too. I compiled the kernel image on the ubuntu20 virtual machine.
>> So I guess it might be the issue of OS version or VM?
>>
>> Jiayu Cao <bitterblossom5486@gmail.com> 于2021年12月21日周二 12:02写道：
>>
>>> Hi Xenomai development group:
>>>
>>> I am working on Xenomai 3.2.1 and Ubuntu 20.04 OS.
>>> I am trying to build a kernel image based on the linux-oem-5.10.0-1044.46
>>> kernel, which is a Ubuntu kernel and the mainline base version is *Linux
>>> 5.10.46*. The kernel's source code folder path
>>> is ~/linux-oem-5.10-5.10.0/.
>>> Then I extracted the Dovetail patch to linux-oem-5.10-5.10.0/ folder ,
>>> which version is *patch-5.10.46-dovetail1.patch.bz2*. Then I typed the
>>> following commands:
>>> ```
>>> cd linux-oem-5.10-5.10.0/
>>>
>>> ~/Downloads/xenomai-v3.2.1/scripts/prepare-kernel.sh --arch=x86_64
>>> --dovetail=patch-5.10.46-dovetail1.patch
>>>
>>> make menuconfig
>>> # I did no extra configuration in the kernel configuration and just save
>>> a .config file.
>>> # Actually I've tried to compile the image multiple times with different
>>> configurations, but I got the same error each time.
>>>
>>> make bzImage
>>> # Got error here
>>> ```
>>>
>>> And the error log is:
>>> ```
>>>   LD      .tmp_vmlinux.btf
>>>   BTF     .btf.vmlinux.bin.o
>>>   LD      .tmp_vmlinux.kallsyms1
>>>   KSYMS   .tmp_vmlinux.kallsyms1.S
>>>   AS      .tmp_vmlinux.kallsyms1.S
>>>   LD      .tmp_vmlinux.kallsyms2
>>>   KSYMS   .tmp_vmlinux.kallsyms2.S
>>>   AS      .tmp_vmlinux.kallsyms2.S
>>>   LD      vmlinux
>>>   BTFIDS  vmlinux
>>> FAILED unresolved symbol udp_sock
>>> make: *** [Makefile:1205: vmlinux] Error 255
>>> ```
>>> The purely Linux kernel without Dovetail patch could be compiled
>>> successfully, thus I tried to compare the* .config* file under these two
>>> situations (success and failed) with 'meld' tool.
>>> However, I only watched some modifications about the XEN virtual machine.
>>> I also googled it but cannot figure out any related solutions.
>>>
>>> Could you provide some solutions for me? Thanks for your help!
>>>
>>> Sincerely,
>>> Jiayu.
>>>
>>

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

