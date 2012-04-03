Message-ID: <4F7B49E1.8010106@domain.hid>
Date: Tue, 03 Apr 2012 21:05:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4F4150C8.7040104@domain.hid> <4F4278ED.9090802@domain.hid>
	<4F478285.8020105@domain.hid> <4F47A161.9010704@domain.hid>
	<4F79C838.2070609@domain.hid> <4F79CBAA.6040107@domain.hid>
	<4F7A0F11.3080504@domain.hid> <4F7A128C.4040706@domain.hid>
	<4F7A133E.7000505@domain.hid> <4F7A2039.2040409@domain.hid>
	<4F7A211F.1080809@domain.hid> <4F7AACC1.6080500@domain.hid>
	<4F7AADFD.3060506@domain.hid> <4F7AD9BD.1070201@domain.hid>
	<4F7B35AA.3020604@domain.hid> <4F7B3ED4.3080003@domain.hid>
	<4F7B40DD.2030904@domain.hid> <4F7B429C.8020009@domain.hid>
	<4F7B43D4.9070800@domain.hid>
In-Reply-To: <4F7B43D4.9070800@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] Reworking ipipe timer subsystem,
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/options/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Adeos <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

On 04/03/2012 08:39 PM, Jan Kiszka wrote:
> On 2012-04-03 20:34, Gilles Chanteperdrix wrote:
>> On 04/03/2012 08:26 PM, Jan Kiszka wrote:
>>> On 2012-04-03 20:17, Gilles Chanteperdrix wrote:
>>>> Ok, I get it, I need -net nic -net user. The first is for the nic in the
>>>> guest, the second configures by what means the physical network will be
>>>> emulated. I would have liked the qemu guest to appear on my LAN, but
>>>> that will do.
>>>
>>> That requires a bridge on the host and a tap device backend. Upcoming
>>> qemu-1.1 will even have a helper daemon to create those tap devices with
>>> raised privileges and allow unprivileged QEMU instances to use them.
>>
>> ... Or you can put the interface in promiscuous mode and send raw
>> ethernet packets using the emulated NIC mac address. No bridge, no tap
>> device, no helper daemon required.
> 
> ...but still root privileges, otherwise you are unable to send/receive
> arbitrary frames over the interface.



> 
>>
>> In any case with -net user, I can not use the virtual network to mount
>> the rootfs using NFS, so, it still does not work.
> 
> That could be a bug. You happen to talk to the maintainer of this ugly
> subsystem (sigh...), and as such I would be glad if you could take a
> dump with "-net user -net nic -net dump" of the failing interaction
> between guest and host. Output will be in qemu-vlan0.pcap in your
> working directory.

No bug, it was a configuration issue (missing "insecure" in /etc/exports).


-- 
                                                                Gilles.

