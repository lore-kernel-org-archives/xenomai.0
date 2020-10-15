Subject: Re: PEAK RTCAN on Xenomai conflict with VT-d configuration
References: <CY4PR05MB330496E52094CEEC40D8A67C8E020@CY4PR05MB3304.namprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5a31fcc4-0236-8e2d-8ab1-c20809c6e01a@siemens.com>
Date: Thu, 15 Oct 2020 10:11:01 +0200
MIME-Version: 1.0
In-Reply-To: <CY4PR05MB330496E52094CEEC40D8A67C8E020@CY4PR05MB3304.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Edward Liao <edward.liao@adlinktech.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: Victor Fu <victor.fu@adlinktech.com>, William Liang <william.liang@adlinktech.com>

On 15.10.20 08:02, Edward Liao via Xenomai wrote:
> Hi, Xenomai Team:
> 
> We have a problem when using PEAK real-time CAN deploy with a virtualization project called ACRN, which is an open source project, the primary contributor are Intel Team.
> 
>   https://projectacrn.github.io/latest/introduction/index.html
> 
> The main purpose in our project is apply PEAK RTCAN with Xenomai run in ACRN real-time VM. The Intel CPU enhancement techniques for virtualization VT-d configuration in BIOS which is conflict with Xenomai PEAK RTCAN.
> Here is our hardware resource and kernel version:
> 
>   CPU: Intel i7-9850HE
>   OS: Ubuntu 18.04 x86_64
>   Kernel: 4.19.59
>   Xenomai: 3.1
>   PEAK CAN model: PEAK PCAN-miniPCIe (IPEH-003048)
>   https://www.peak-system.com/PCAN-miniPCIe.285.0.html?&L=1
> 
> The following PEAK's official forum discussion link who also have the same issue with PEAK RTCAN on Xenomai, but the user do not need a scenario run with virtual machine. So, the user disable VT-d setting and the problem solved. In this time we have to run PEAK RTCAN within a real-time VM, then cannot just disable VT-d setting to avoid the conflict. Hope Xenomai Team can help us to solve the problem.
> 
>   https://forum.peak-system.com/viewtopic.php?f=59&t=5720
> 
> Please also have a look the ACRN Project run with Xenomai on guest OS.
> 
>   https://projectacrn.github.io/latest/tutorials/using_xenomai_as_uos.html
> 
>   https://github.com/intel/linux-stable-xenomai
> 
> The basic steps to reproduce the conflict is enable VT-d in BIOS if is supported. Run PEAK RTCAN demo with Xenomai Cobalt Core, then can reproduce just like the forum topic(PEAK-CAN miniPCIe devices failed on Xenomai 3.0.5) said. It is not necessary to prepare ACRN Project in system anyway.

Conceptually, VT-d can be transparent to the guest. Means, even if you
program the guest driver (in this case the Xenomai CAN driver) in a way
as if there is no virtualization, things will "just work". This is how
KVM/QEMU works, and also how we address this in Jailhouse (a hypervisor
very similar to ACRN).

If you want to rule out the ACRN hypervisor as the source of problems,
cross-check by putting your Xenomai guest into a KVM machine and pass
the CAN PCI adapter through (via vfio). If the problem persists, the
hardware is very likely the issue. If not, you should talk to the ARCN
developers.

Is the problem in your case also that interrupts do not get through, and
maybe the hypervisor reports that some blocking of "compatible
interrupts"? Are we talking about MSI, MSI-X or INTx interrupts for this
card?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

