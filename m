Date: Fri, 16 Oct 2020 11:26:49 +0800
From: Fino Meng <fino.meng@linux.intel.com>
Subject: Re: PEAK RTCAN on Xenomai conflict with VT-d configuration
Message-ID: <20201016032649.GA5581@linux.intel.com>
References: <CY4PR05MB330496E52094CEEC40D8A67C8E020@CY4PR05MB3304.namprd05.prod.outlook.com>
 <20201015081508.GA30792@linux.intel.com>
 <CY4PR05MB3304144F9911BFA9D34555778E030@CY4PR05MB3304.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR05MB3304144F9911BFA9D34555778E030@CY4PR05MB3304.namprd05.prod.outlook.com>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Edward Liao <edward.liao@adlinktech.com>
Cc: xenomai@xenomai.org

On Fri, Oct 16, 2020 at 02:46:59AM +0000, Edward Liao wrote:
> Hi, Jan and Fino:
> 
> > Conceptually, VT-d can be transparent to the guest. Means, even if you program the guest driver (in this case the Xenomai CAN driver) in a way as if there is no virtualization, things will "just work". This is how KVM/QEMU works, and also how we address this in Jailhouse (a hypervisor very similar to ACRN).
> >
> > If you want to rule out the ACRN hypervisor as the source of problems, cross-check by putting your Xenomai guest into a KVM machine and pass the CAN PCI adapter through (via vfio). If the problem persists, the hardware is very likely the issue. If not, you should talk to the ARCN developers.
> >
> > Is the problem in your case also that interrupts do not get through, and maybe the hypervisor reports that some blocking of "compatible interrupts"? Are we talking about MSI, MSI-X or INTx interrupts for this card?
> 
> We reproduce the same problem just like the PEAK forum discussion the user said:
> "data seems to send sucessfully, but for the second call of 'rtcansend', the program are stuck in the send function."
> That means you can only send data once, then stuck in the socket send() function. If you want to send another data, you have to run ./rtcanconfig again, send(./rtcansend) another data, then stuck again. On the other hand, the ./rtcanrecv never receive any data, no matter how to configure it.
> 
>     https://forum.peak-system.com/viewtopic.php?f=59&t=5720&start=10
> 
> In the above test scenario, we have not yet integrated with ACRN. The PEAK RTCAN will have the problem, only if active the Intel VT for Directed I/O technology(VT-d) in BIOS. If deactivate it, the problem solved. But ACRN need VT-d support, so we cannot just disable it.
> 
> > Did u config this card as pass-through to the RTVM (Xenomai in this case)? 
> > If your team don't familar how to config ACRN yet, maybe the fast way is post one card to our office, then we can reproduce the issue in our lab and debug it,
> 
> We available pass-through PCIe device from Service OS to RTVM after followed the ACRN instructions, it is definitely can show PEAK PCIe device in the list on RTVM with command lspci. The situation in RTVM the same as above test scenario, no matter run with or without ACRN, the RTCAN will stuck at socket send() function after one send when VT-d configuration is enabled.

I see, understand it better. looks difficult~ 

> 
> Just like Fino said, one of the fast way is post the card to the office, and help to solve the problem. Fino, could you send me the office address and the recipient info in private way(another e-mail)? We're now acquiring the approval in our business unit for lending the device.

already send my office address to your email.

BR fino

> 
> Thanks for Xenomai Team help.
> 
> Best Regards,
> Edward Liao
> 
> 
> 
> 
> -----Original Message-----
> From: Fino Meng <fino.meng@linux.intel.com> 
> Sent: Thursday, October 15, 2020 4:15 PM
> To: Edward Liao <edward.liao@adlinktech.com>
> Cc: xenomai@xenomai.org
> Subject: Re: PEAK RTCAN on Xenomai conflict with VT-d configuration
> 
> On Thu, Oct 15, 2020 at 06:02:53AM +0000, Edward Liao via Xenomai wrote:
> > Hi, Xenomai Team:
> > 
> > We have a problem when using PEAK real-time CAN deploy with a virtualization project called ACRN, which is an open source project, the primary contributor are Intel Team.
> > 
> >   https://projectacrn.github.io/latest/introduction/index.html
> > 
> > The main purpose in our project is apply PEAK RTCAN with Xenomai run in ACRN real-time VM. The Intel CPU enhancement techniques for virtualization VT-d configuration in BIOS which is conflict with Xenomai PEAK RTCAN.
> > Here is our hardware resource and kernel version:
> > 
> >   CPU: Intel i7-9850HE
> >   OS: Ubuntu 18.04 x86_64
> >   Kernel: 4.19.59
> >   Xenomai: 3.1
> >   PEAK CAN model: PEAK PCAN-miniPCIe (IPEH-003048)
> >   https://www.peak-system.com/PCAN-miniPCIe.285.0.html?&L=1
> > 
> > The following PEAK's official forum discussion link who also have the same issue with PEAK RTCAN on Xenomai, but the user do not need a scenario run with virtual machine. So, the user disable VT-d setting and the problem solved. In this time we have to run PEAK RTCAN within a real-time VM, then cannot just disable VT-d setting to avoid the conflict. Hope Xenomai Team can help us to solve the problem.
> > 
> >   https://forum.peak-system.com/viewtopic.php?f=59&t=5720
> > 
> > Please also have a look the ACRN Project run with Xenomai on guest OS.
> > 
> >   
> > https://projectacrn.github.io/latest/tutorials/using_xenomai_as_uos.ht
> > ml
> > 
> >   https://github.com/intel/linux-stable-xenomai
> > 
> > The basic steps to reproduce the conflict is enable VT-d in BIOS if is supported. Run PEAK RTCAN demo with Xenomai Cobalt Core, then can reproduce just like the forum topic(PEAK-CAN miniPCIe devices failed on Xenomai 3.0.5) said. It is not necessary to prepare ACRN Project in system anyway.
> 
> Did u config this card as pass-through to the RTVM (Xenomai in this case)? 
> If your team don't familar how to config ACRN yet, maybe the fast way is post one card to our office, then we can reproduce the issue in our lab and debug it,
> 
> BR fino
> 
> > 
> > To check the CPU x86 virtualization technic if is supported:
> >   cat /proc/cpuinfo | grep vmx
> > 
> > Please feel free to contact us if you need any further information.
> > 
> > Thank you for taking the time to read this e-mail.
> > 
> > Best Regards,
> > Edward Liao
> > SEC-System Platform Dept. Section V
> > ADLINK Technology Inc.
> > TEL: +886-2-82265877 Ext: 8803
> > Email : edward.liao@adlinktech.com<mailto:edward.liao@adlinktech.com>
> > [cid:image001.png@01D3E3BE.A746E910]
> > 
> > -------------- next part -------------- A non-text attachment was 
> > scrubbed...
> > Name: image003.jpg
> > Type: image/jpeg
> > Size: 2572 bytes
> > Desc: image003.jpg
> > URL: <http://xenomai.org/pipermail/xenomai/attachments/20201015/1b5a4552/attachment.jpg>

