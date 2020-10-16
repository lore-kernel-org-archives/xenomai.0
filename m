From: Edward Liao <edward.liao@adlinktech.com>
Subject: RE: PEAK RTCAN on Xenomai conflict with VT-d configuration
Date: Fri, 16 Oct 2020 02:46:59 +0000
Message-ID: <CY4PR05MB3304144F9911BFA9D34555778E030@CY4PR05MB3304.namprd05.prod.outlook.com>
References: <CY4PR05MB330496E52094CEEC40D8A67C8E020@CY4PR05MB3304.namprd05.prod.outlook.com>
 <20201015081508.GA30792@linux.intel.com>
In-Reply-To: <20201015081508.GA30792@linux.intel.com>
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "fino.meng@linux.intel.com" <fino.meng@linux.intel.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, Victor Fu <victor.fu@adlinktech.com>, William Liang <william.liang@adlinktech.com>

Hi, Jan and Fino:

> Conceptually, VT-d can be transparent to the guest. Means, even if you pr=
ogram the guest driver (in this case the Xenomai CAN driver) in a way as if=
 there is no virtualization, things will "just work". This is how KVM/QEMU =
works, and also how we address this in Jailhouse (a hypervisor very similar=
 to ACRN).
>
> If you want to rule out the ACRN hypervisor as the source of problems, cr=
oss-check by putting your Xenomai guest into a KVM machine and pass the CAN=
 PCI adapter through (via vfio). If the problem persists, the hardware is v=
ery likely the issue. If not, you should talk to the ARCN developers.
>
> Is the problem in your case also that interrupts do not get through, and =
maybe the hypervisor reports that some blocking of "compatible interrupts"?=
 Are we talking about MSI, MSI-X or INTx interrupts for this card?

We reproduce the same problem just like the PEAK forum discussion the user =
said:
"data seems to send sucessfully, but for the second call of 'rtcansend', th=
e program are stuck in the send function."
That means you can only send data once, then stuck in the socket send() fun=
ction. If you want to send another data, you have to run ./rtcanconfig agai=
n, send(./rtcansend) another data, then stuck again. On the other hand, the=
 ./rtcanrecv never receive any data, no matter how to configure it.

    https://forum.peak-system.com/viewtopic.php?f=3D59&t=3D5720&start=3D10

In the above test scenario, we have not yet integrated with ACRN. The PEAK =
RTCAN will have the problem, only if active the Intel VT for Directed I/O t=
echnology(VT-d) in BIOS. If deactivate it, the problem solved. But ACRN nee=
d VT-d support, so we cannot just disable it.

> Did u config this card as pass-through to the RTVM (Xenomai in this case)=
?=20
> If your team don't familar how to config ACRN yet, maybe the fast way is =
post one card to our office, then we can reproduce the issue in our lab and=
 debug it,

We available pass-through PCIe device from Service OS to RTVM after followe=
d the ACRN instructions, it is definitely can show PEAK PCIe device in the =
list on RTVM with command lspci. The situation in RTVM the same as above te=
st scenario, no matter run with or without ACRN, the RTCAN will stuck at so=
cket send() function after one send when VT-d configuration is enabled.

Just like Fino said, one of the fast way is post the card to the office, an=
d help to solve the problem. Fino, could you send me the office address and=
 the recipient info in private way(another e-mail)? We're now acquiring the=
 approval in our business unit for lending the device.

Thanks for Xenomai Team help.

Best Regards,
Edward Liao




-----Original Message-----
From: Fino Meng <fino.meng@linux.intel.com>=20
Sent: Thursday, October 15, 2020 4:15 PM
To: Edward Liao <edward.liao@adlinktech.com>
Cc: xenomai@xenomai.org
Subject: Re: PEAK RTCAN on Xenomai conflict with VT-d configuration

On Thu, Oct 15, 2020 at 06:02:53AM +0000, Edward Liao via Xenomai wrote:
> Hi, Xenomai Team:
>=20
> We have a problem when using PEAK real-time CAN deploy with a virtualizat=
ion project called ACRN, which is an open source project, the primary contr=
ibutor are Intel Team.
>=20
>   https://projectacrn.github.io/latest/introduction/index.html
>=20
> The main purpose in our project is apply PEAK RTCAN with Xenomai run in A=
CRN real-time VM. The Intel CPU enhancement techniques for virtualization V=
T-d configuration in BIOS which is conflict with Xenomai PEAK RTCAN.
> Here is our hardware resource and kernel version:
>=20
>   CPU: Intel i7-9850HE
>   OS: Ubuntu 18.04 x86_64
>   Kernel: 4.19.59
>   Xenomai: 3.1
>   PEAK CAN model: PEAK PCAN-miniPCIe (IPEH-003048)
>   https://www.peak-system.com/PCAN-miniPCIe.285.0.html?&L=3D1
>=20
> The following PEAK's official forum discussion link who also have the sam=
e issue with PEAK RTCAN on Xenomai, but the user do not need a scenario run=
 with virtual machine. So, the user disable VT-d setting and the problem so=
lved. In this time we have to run PEAK RTCAN within a real-time VM, then ca=
nnot just disable VT-d setting to avoid the conflict. Hope Xenomai Team can=
 help us to solve the problem.
>=20
>   https://forum.peak-system.com/viewtopic.php?f=3D59&t=3D5720
>=20
> Please also have a look the ACRN Project run with Xenomai on guest OS.
>=20
>  =20
> https://projectacrn.github.io/latest/tutorials/using_xenomai_as_uos.ht
> ml
>=20
>   https://github.com/intel/linux-stable-xenomai
>=20
> The basic steps to reproduce the conflict is enable VT-d in BIOS if is su=
pported. Run PEAK RTCAN demo with Xenomai Cobalt Core, then can reproduce j=
ust like the forum topic(PEAK-CAN miniPCIe devices failed on Xenomai 3.0.5)=
 said. It is not necessary to prepare ACRN Project in system anyway.

Did u config this card as pass-through to the RTVM (Xenomai in this case)?=
=20
If your team don't familar how to config ACRN yet, maybe the fast way is po=
st one card to our office, then we can reproduce the issue in our lab and d=
ebug it,

BR fino

>=20
> To check the CPU x86 virtualization technic if is supported:
>   cat /proc/cpuinfo | grep vmx
>=20
> Please feel free to contact us if you need any further information.
>=20
> Thank you for taking the time to read this e-mail.
>=20
> Best Regards,
> Edward Liao
> SEC-System Platform Dept. Section V
> ADLINK Technology Inc.
> TEL: +886-2-82265877 Ext: 8803
> Email : edward.liao@adlinktech.com<mailto:edward.liao@adlinktech.com>
> [cid:image001.png@01D3E3BE.A746E910]
>=20
> -------------- next part -------------- A non-text attachment was=20
> scrubbed...
> Name: image003.jpg
> Type: image/jpeg
> Size: 2572 bytes
> Desc: image003.jpg
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20201015/1b5a4552/=
attachment.jpg>

