From: Umair Ali <ali.umair@tut.fi>
Date: Wed, 11 Nov 2015 11:16:21 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A706050@mb2010-3.intra.tut.fi>
References: <2396B4D2166B62479FBBE370D4A7C1F30A705D34@mb2010-3.intra.tut.fi>
 <20151103114717.GA26720@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A705DA6@mb2010-3.intra.tut.fi>
 <20151103144651.GC26720@hermes.click-hack.org>
 <2396B4D2166B62479FBBE370D4A7C1F30A705E86@mb2010-3.intra.tut.fi>,
 <20151105213337.GD31487@hermes.click-hack.org>
In-Reply-To: <20151105213337.GD31487@hermes.click-hack.org>
Content-Language: en-US
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Pcap replay tool for xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hello, =0A=
=0A=
I have installed the xenomai 3.0.1 as a patch with the following versions.=
=0A=
"Linux cpc 3.14.39-xenomai-3.0.1 #2 SMP PREEMPT Tue Nov 10 18:02:47 EET 201=
5 i686 i686 i686 GNU/Linux".=0A=
=0A=
I have realtek NIC with 8139too drivers. I was able to bind the rt_8139too =
drivers with the realtek NIC like below=0A=
"root@cpc:/home/cpc/Desktop# tree /sys/bus/pci/drivers/rt_8139too/=0A=
/sys/bus/pci/drivers/rt_8139too/=0A=
=86=80=80 0000:05:04.0 -> ../../../../devices/pci0000:00/0000:00:1e.0/0000:=
05:04.0=0A=
=86=80=80 bind=0A=
=86=80=80 module -> ../../../../module/rt_8139too=0A=
=86=80=80 new_id=0A=
=86=80=80 remove_id=0A=
=86=80=80 uevent=0A=
=84=80=80 unbind"=0A=
 =0A=
Now my question is that is there any way we can test the driver or use it t=
he way we can use the 8139too drivers on non real time kernel. Although i h=
ave configured the rtnet.conf file with drive name and nic device id and Ip=
 address. But still i can not see the ether interface up. I have two NIC. E=
th0 interface is with broadcom driver and eth1 is with realtek drivers. Ifc=
onfig command shows only eth0 and lo interfaces only. and if i run the comm=
and 'ifconfig eth1 up' it gives error 'No such device'. So is there any way=
 i can use the rt_81390 as normal interface. =0A=
=0A=
Thanks & Regards=0A=
Ali Umair=0A=
=0A=
=0A=
________________________________________=0A=
From: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]=0A=
Sent: Thursday, November 05, 2015 11:33 PM=0A=
To: Umair Ali=0A=
Cc: Xenomai=0A=
Subject: Re: [Xenomai] Pcap replay tool for xenomai=0A=
=0A=
On Thu, Nov 05, 2015 at 03:17:45PM +0000, Umair Ali wrote:=0A=
> Hello Gilles,=0A=
>=0A=
> I have managed to install the xenomai on Ubuntu 13.04 (kernel=0A=
> 3.08).=0A=
=0A=
Not sure what you mean with kernel 3.08 here, since you talk about=0A=
3.10 later on.=0A=
=0A=
> The version of the xenomai is 3.0.1 and kernel version is=0A=
> 3.10.32. The following is the output after the reboot=0A=
=0A=
RTnet requires I-pipe patch for kernel 3.14 or later.=0A=
=0A=
=0A=
> I have also observed that module 8139too is also running. As i am=0A=
> new to the linux so i want to make sure if i have installed the=0A=
> xenomai with rtnet correctly. Can you tell me is there a way i=0A=
> stop the 8139too module and make rt_8139too module as default=0A=
> driver for NIC.=0A=
=0A=
Yes, you can unbind the device from the 8139too driver, then bind it=0A=
to rt_8139too, or start the rt_8139too module after unbinding from=0A=
8139too. To know how to manual bind/unbind devices from drivers,=0A=
see:=0A=
https://lwn.net/Articles/143397/=0A=
=0A=
=0A=
> And then use TCPreplay command such as "tcpreplayy=0A=
> --pps=3D4000 --intf1=3Deth0 stream.pcap" to play back the pcap file as=0A=
> we can do in the non real kernel.=0A=
=0A=
As I already told you, the code is identical to send raw packets=0A=
with Linux and Xenomai, but the compilation is different. So, if=0A=
tcpreplay is not compiled for Xenomai, it will not use Xenomai APIs.=0A=
I suggest you start reading a bit about Xenomai to understand what=0A=
it does and how it works, starting from here:=0A=
http://xenomai.org/start-here/=0A=
=0A=
--=0A=
                                            Gilles.=0A=
https://click-hack.org=0A=

