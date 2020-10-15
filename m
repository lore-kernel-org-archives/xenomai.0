Date: Thu, 15 Oct 2020 16:15:09 +0800
From: Fino Meng <fino.meng@linux.intel.com>
Subject: Re: PEAK RTCAN on Xenomai conflict with VT-d configuration
Message-ID: <20201015081508.GA30792@linux.intel.com>
References: <CY4PR05MB330496E52094CEEC40D8A67C8E020@CY4PR05MB3304.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR05MB330496E52094CEEC40D8A67C8E020@CY4PR05MB3304.namprd05.prod.outlook.com>
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

On Thu, Oct 15, 2020 at 06:02:53AM +0000, Edward Liao via Xenomai wrote:
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

Did u config this card as pass-through to the RTVM (Xenomai in this case)? 
If your team don't familar how to config ACRN yet, maybe the fast way is
post one card to our office, then we can reproduce the issue in our lab
and debug it,

BR fino

> 
> To check the CPU x86 virtualization technic if is supported:
>   cat /proc/cpuinfo | grep vmx
> 
> Please feel free to contact us if you need any further information.
> 
> Thank you for taking the time to read this e-mail.
> 
> Best Regards,
> Edward Liao
> SEC-System Platform Dept. Section V
> ADLINK Technology Inc.
> TEL: +886-2-82265877 Ext: 8803
> Skype: jay16814
> Email : edward.liao@adlinktech.com<mailto:edward.liao@adlinktech.com>
> [cid:image001.png@01D3E3BE.A746E910]
> 
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: image003.jpg
> Type: image/jpeg
> Size: 2572 bytes
> Desc: image003.jpg
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20201015/1b5a4552/attachment.jpg>

