Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033FD3BE16C
	for <xenomai@lists.linux.dev>; Tue, 13 Oct 2026 23:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791935822; cv=none; b=oM8NZArVuigBIt50WQl4pl024YKLDvkRQF/EOdzC1plPyWkirSwxXbdOOGCayFsRTdLhN59+2/j/ukZc4XnDhBFjZgJqw4y7RSdylMWuJiF6HKQ56fcoN2t2Thz+BkUUZudDJ7ZRZGd9Vlw5jBcRnerHgwPfss+e+o4quI4O0A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791935822; c=relaxed/simple;
	bh=YVR7eiYA1G09E7lAEgMKMDIjEneUeL7rMxNNk5FOiZI=;
	h=Message-Id:To:Cc:References:In-Reply-To:Date:Subject:From:
	 Mime-Version:Content-Type; b=nclsxA3Hd7V641l6wxZxT/BelNRXxZFzPjq+ePlsxpdOBgekTgfQNz6lSWST2X6+Qq5JvVZk/1PEqPwr8xnZ3ykf/9WFqzRcH0Ptk/4zz6wWvPs7pueAyqhqN17dwf94xXbGARXu52lBNu/Qwn6wp/xfAzV3Dktgdml26UCq3kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn; spf=none smtp.mailfrom=sinsegye.com.cn; arc=none smtp.client-ip=115.124.28.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sinsegye.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sinsegye.com.cn
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06834763|-1;BR=01201311R161ec;CH=green;DM=|CONTINUE|false|;DS=SPAM|spam_ad|0.986721-0.000201543-0.0130775;FP=17148009799601448299|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=liuyang@sinsegye.com.cn;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jc8GsmN_1791935812;
Received: from localhost(mailfrom:liuyang@sinsegye.com.cn fp:SMTPD_---.jc8GsmN_1791935812 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 14 Oct 2026 07:56:53 +0800
Message-Id: <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.73962a4a.e628.4a00.aded.2f4a807b8f01@feishu.cn>
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>
Cc: "Jan Kiszka" <jan.kiszka@siemens.com>, 
	"Philippe Gerum" <rpm@xenomai.org>, <xenomai@lists.linux.dev>, 
	<songjianwei@sinsegye.com.cn>
References: <20260920032219.1799313-1-liuyang@sinsegye.com.cn> <b75042383d2c13a7714aa538c4cbbaf59575add1.camel@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.27e5e5db.849f.4897.86af.4aed0afaa453@feishu.cn> <8f3e2103-29a1-405e-b664-f1f1af82c4c5@siemens.com> <ed7c43ef85386e7d9b7bfcd2895307dc2948cb81.5bb5075f.c6ee.417d.8f02.9923dc98b410@feishu.cn> <00f73467-9ce0-44fb-b969-9861f415cc46@siemens.com>
	<e8d56be0e119bb0c7fa030eb23d3e899e9ac20b8.camel@siemens.com>
In-Reply-To: <e8d56be0e119bb0c7fa030eb23d3e899e9ac20b8.camel@siemens.com>
Date: Wed, 14 Oct 2026 07:56:50 +0800
Subject: Re: [PATCH] KVM: SVM: Fix physical interrupt handling during vmentry/vexit
From: =?utf-8?q?=E5=88=98=E6=9D=A8?= <liuyang@sinsegye.com.cn>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+16acec543+296618+xenomai.org+liuyang@sinsegye.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi
=C2=A0=C2=A0=C2=A0 I used the `stress` tool on Linux to generate load on di=
sk, memory and CPU. Meanwhile inside the VM, I ran `stressmypc` to apply th=
e same set of pressure on disk, memory and CPU. After a 24-hour stress test=
, no further issues were observed.

My test env:
=C2=A0=C2=A0=C2=A0 platform: AMD Ryzen 7 7700 / AMD Ryzen 7 8845HS
=C2=A0=C2=A0=C2=A0 bios: enable AMD-V
=C2=A0=C2=A0=C2=A0 libvirt xml:
=C2=A0=C2=A0 <domain type=3D'kvm' xmlns:qemu=3D'http://libvirt.org/schemas/=
domain/qemu/1.0'>
=C2=A0 <name>sp5020-A221-vm</name>
=C2=A0 <uuid>a9f1c255-35be-41cc-a440-42adbb1934a9</uuid>
=C2=A0 <metadata>
=C2=A0=C2=A0=C2=A0 <libosinfo:libosinfo xmlns:libosinfo=3D"http://libosinfo=
.org/xmlns/libvirt/domain/1.0">
=C2=A0=C2=A0 =C2=A0=C2=A0 <libosinfo:os id=3D"http://microsoft.com/win/10"/=
>
=C2=A0=C2=A0=C2=A0 </libosinfo:libosinfo>
=C2=A0 </metadata>
=C2=A0 <memory unit=3D'KiB'>10485760</memory>
=C2=A0 <currentMemory unit=3D'KiB'>10485760</currentMemory>
=C2=A0 <memoryBacking>
=C2=A0=C2=A0=C2=A0 <hugepages/>
=C2=A0 </memoryBacking>
=C2=A0 <vcpu placement=3D'static'>6</vcpu>
=C2=A0 <iothreads>1</iothreads>
=C2=A0 <os>
=C2=A0=C2=A0=C2=A0 <type arch=3D'x86_64' machine=3D'q35'>hvm</type>
=C2=A0=C2=A0=C2=A0 <loader readonly=3D'yes' type=3D'pflash'>/usr/share/OVMF=
/OVMF_CODE_4M.fd</loader>
=C2=A0=C2=A0=C2=A0 <boot dev=3D'hd'/>
=C2=A0=C2=A0=C2=A0 <smbios mode=3D'host'/>
=C2=A0 </os>
=C2=A0 <features>
=C2=A0=C2=A0=C2=A0 <acpi/>
=C2=A0=C2=A0=C2=A0 <apic/>
=C2=A0=C2=A0=C2=A0 <hyperv mode=3D'custom'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <relaxed state=3D'on'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <vapic state=3D'on'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <spinlocks state=3D'on' retries=3D'8191'/>
=C2=A0=C2=A0=C2=A0 </hyperv>
=C2=A0=C2=A0=C2=A0 <vmport state=3D'off'/>
=C2=A0 </features>
=C2=A0 <cpu mode=3D'host-passthrough' check=3D'none' migratable=3D'off'>
=C2=A0=C2=A0=C2=A0 <topology sockets=3D'1' dies=3D'1' cores=3D'6' threads=
=3D'1'/>
=C2=A0 </cpu>
=C2=A0 <clock offset=3D'localtime'>
=C2=A0=C2=A0=C2=A0 <timer name=3D'rtc' tickpolicy=3D'catchup'/>
=C2=A0=C2=A0=C2=A0 <timer name=3D'hypervclock' present=3D'yes'/>
=C2=A0 </clock>
=C2=A0 <on_poweroff>destroy</on_poweroff>
=C2=A0 <on_reboot>restart</on_reboot>
=C2=A0 <on_crash>destroy</on_crash>
=C2=A0 <pm>
=C2=A0=C2=A0=C2=A0 <suspend-to-mem enabled=3D'no'/>
=C2=A0=C2=A0=C2=A0 <suspend-to-disk enabled=3D'no'/>
=C2=A0 </pm>
=C2=A0 <devices>
=C2=A0=C2=A0=C2=A0 <emulator>/usr/bin/qemu-system-x86_64</emulator>
=C2=A0=C2=A0=C2=A0 <disk type=3D'block' device=3D'disk'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <driver name=3D'qemu' type=3D'raw' cache=3D'none'=
 io=3D'native' discard=3D'unmap' iothread=3D'1'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <source dev=3D'/dev/nvme0n1'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <target dev=3D'vda' bus=3D'virtio'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x=
05' slot=3D'0x00' function=3D'0x0'/>
=C2=A0=C2=A0=C2=A0 </disk>
=C2=A0=C2=A0=C2=A0 <controller type=3D'pci' index=3D'0' model=3D'pcie-root'=
/>
=C2=A0=C2=A0=C2=A0 <controller type=3D'pci' index=3D'1' model=3D'pcie-root-=
port'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <model name=3D'pcie-root-port'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <target chassis=3D'1' port=3D'0x8'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x=
00' slot=3D'0x01' function=3D'0x0' multifunction=3D'on'/>
=C2=A0=C2=A0=C2=A0 </controller>
=C2=A0=C2=A0=C2=A0 <controller type=3D'pci' index=3D'2' model=3D'pcie-root-=
port'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <model name=3D'pcie-root-port'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <target chassis=3D'2' port=3D'0x9'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x=
00' slot=3D'0x01' function=3D'0x1'/>
=C2=A0=C2=A0=C2=A0 </controller>
=C2=A0=C2=A0=C2=A0 <controller type=3D'pci' index=3D'3' model=3D'pcie-root-=
port'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <model name=3D'pcie-root-port'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <target chassis=3D'3' port=3D'0xa'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x=
00' slot=3D'0x01' function=3D'0x2'/>
=C2=A0=C2=A0=C2=A0 </controller>
=C2=A0=C2=A0=C2=A0 <controller type=3D'pci' index=3D'4' model=3D'pcie-root-=
port'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <model name=3D'pcie-root-port'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <target chassis=3D'4' port=3D'0xb'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x=
00' slot=3D'0x01' function=3D'0x3'/>
=C2=A0=C2=A0=C2=A0 </controller>
=C2=A0=C2=A0=C2=A0 <controller type=3D'pci' index=3D'5' model=3D'pcie-root-=
port'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <model name=3D'pcie-root-port'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <target chassis=3D'5' port=3D'0xc'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x=
00' slot=3D'0x01' function=3D'0x4'/>
=C2=A0=C2=A0=C2=A0 </controller>
=C2=A0=C2=A0=C2=A0 <controller type=3D'pci' index=3D'6' model=3D'pcie-root-=
port'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <model name=3D'pcie-root-port'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <target chassis=3D'6' port=3D'0xd'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x=
00' slot=3D'0x01' function=3D'0x5'/>
=C2=A0=C2=A0=C2=A0 </controller>
=C2=A0=C2=A0=C2=A0 <controller type=3D'pci' index=3D'7' model=3D'pcie-root-=
port'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <model name=3D'pcie-root-port'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <target chassis=3D'7' port=3D'0xe'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x=
00' slot=3D'0x01' function=3D'0x6'/>
=C2=A0=C2=A0=C2=A0 </controller>
=C2=A0=C2=A0=C2=A0 <controller type=3D'pci' index=3D'8' model=3D'pcie-root-=
port'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <model name=3D'pcie-root-port'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <target chassis=3D'8' port=3D'0xf'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x=
00' slot=3D'0x01' function=3D'0x7'/>
=C2=A0=C2=A0=C2=A0 </controller>
=C2=A0=C2=A0=C2=A0 <controller type=3D'pci' index=3D'9' model=3D'pcie-root-=
port'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <model name=3D'pcie-root-port'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <target chassis=3D'9' port=3D'0x10'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x=
00' slot=3D'0x02' function=3D'0x0' multifunction=3D'on'/>
=C2=A0=C2=A0=C2=A0 </controller>
=C2=A0=C2=A0=C2=A0 <controller type=3D'pci' index=3D'10' model=3D'pcie-root=
-port'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <model name=3D'pcie-root-port'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <target chassis=3D'10' port=3D'0x11'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x=
00' slot=3D'0x02' function=3D'0x1'/>
=C2=A0=C2=A0=C2=A0 </controller>
=C2=A0=C2=A0=C2=A0 <controller type=3D'pci' index=3D'11' model=3D'pcie-root=
-port'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <model name=3D'pcie-root-port'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <target chassis=3D'11' port=3D'0x12'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x=
00' slot=3D'0x02' function=3D'0x2'/>
=C2=A0=C2=A0=C2=A0 </controller>
=C2=A0=C2=A0=C2=A0 <controller type=3D'pci' index=3D'12' model=3D'pcie-root=
-port'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <model name=3D'pcie-root-port'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <target chassis=3D'12' port=3D'0x13'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x=
00' slot=3D'0x02' function=3D'0x3'/>
=C2=A0=C2=A0=C2=A0 </controller>
=C2=A0=C2=A0=C2=A0 <controller type=3D'pci' index=3D'13' model=3D'pcie-to-p=
ci-bridge'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <model name=3D'pcie-pci-bridge'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x=
0c' slot=3D'0x00' function=3D'0x0'/>
=C2=A0=C2=A0=C2=A0 </controller>
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 <controller type=3D'usb' index=3D'0' model=
=3D'qemu-xhci' ports=3D'15'/>
=C2=A0=C2=A0=C2=A0 <controller type=3D'sata' index=3D'0'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x=
00' slot=3D'0x1f' function=3D'0x2'/>
=C2=A0=C2=A0=C2=A0 </controller>
=C2=A0=C2=A0=C2=A0 <controller type=3D'virtio-serial' index=3D'0'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x=
02' slot=3D'0x00' function=3D'0x0'/>
=C2=A0=C2=A0=C2=A0 </controller>
=C2=A0=C2=A0=C2=A0 <interface type=3D'network'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <mac address=3D'52:54:00:8a:b7:73'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <source network=3D'network'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <model type=3D'virtio'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <address type=3D'pci' domain=3D'0x0000' bus=3D'0x=
00' slot=3D'0x05' function=3D'0x0'/>
=C2=A0=C2=A0=C2=A0 </interface>
=C2=A0=C2=A0=C2=A0 <channel type=3D'unix'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <source mode=3D'bind' path=3D'/var/lib/libvirt/qe=
mu/f16x86_64.agent'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <target type=3D'virtio' name=3D'org.qemu.guest_ag=
ent.0'/>
=C2=A0=C2=A0 =C2=A0=C2=A0 <address type=3D'virtio-serial' controller=3D'0' =
bus=3D'0' port=3D'1'/>
=C2=A0=C2=A0=C2=A0 </channel>
=C2=A0=C2=A0=C2=A0 <input type=3D'mouse' bus=3D'ps2'/>
=C2=A0=C2=A0=C2=A0 <input type=3D'keyboard' bus=3D'ps2'/>
=C2=A0=C2=A0=C2=A0 <audio id=3D'1' type=3D'none'/>
=C2=A0=C2=A0=C2=A0 <video>
=C2=A0=C2=A0 =C2=A0=C2=A0 <model type=3D'none'/>
=C2=A0=C2=A0=C2=A0 </video>
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 <memballoon model=3D'virtio'>
=C2=A0=C2=A0 =C2=A0=C2=A0 <stats period=3D'10'/>
=C2=A0=C2=A0=C2=A0 </memballoon>
</domain>

=C2=A0 =C2=A0 Test method: Run `stress -c 8 -d 8 -i 8 --vm 10` on the host.=
 Inside the Win10 guest, run `stressmypc`. Also execute `latency -P99 -p100=
 -t0 -c1 -h` on the host.

=C2=A0=C2=A0 =C2=A0 Expected result:
=C2=A0=C2=A0=C2=A0 The whole system and the virtual machine operate normall=
y without issues after 24h.
=C2=A0=C2=A0 =C2=A0
=C2=A0=C2=A0 =C2=A0
Best regards
liuyang

> From: "Florian Bezdeka"<florian.bezdeka@siemens.com>
> Date:=C2=A0 Tue, Oct 13, 2026, 22:29
> Subject:=C2=A0 Re: [PATCH] KVM: SVM: Fix physical interrupt handling duri=
ng vmentry/vexit
> To: "Jan Kiszka"<jan.kiszka@siemens.com>, "=E5=88=98=E6=9D=A8"<liuyang@si=
nsegye.com.cn>, "Philippe Gerum"<rpm@xenomai.org>
> Cc: <xenomai@lists.linux.dev>, <songjianwei@sinsegye.com.cn>
> Hi all,
>=C2=A0
> how do we proceed with this patch? As already expressed, the patch
> itself looks good to me, I'm just a bit unsure if that is all that needs
> to be done to properly support SVM.
>=C2=A0
> @Philippe: Any comments on that from your side?
>=C2=A0
> That brings me back to the questions regarding testing.
>=C2=A0
> @liuyang:
>=C2=A0
> - Did you run more stress tests in the meantime?
> - Do you plan to bring in a proper test case for SVM? Maybe something
> =C2=A0 as suggested by Jan based on qemu/kvm?
>=C2=A0
> Once merged without improving the test situation first, the "test
> improvement" will most likely never happen.
>=C2=A0
> Best regards,
> Florian
>=C2=A0
>=C2=A0
> On Wed, 2026-09-23 at 08:03 +0200, Jan Kiszka wrote:
> > On 23.09.26 07:52, =E5=88=98=E6=9D=A8 wrote:
> > > Hi Florian, Jan,
> > >=C2=A0
> > > Thank you for your feedback and for reviewing the patch. I would like=
 to clarify my test setup, as I may have given a wrong impression earlier.
> > >=C2=A0
> > > Regarding stress testing: I did not run any stress or IO workload on =
either the host or the guest. The issue reproduces simply by booting the sy=
stem=C2=A0
> > > and starting a virtual machine. About one minute after the VM starts,=
 the whole system hangs. After applying the patch, everything works normall=
y.=C2=A0
> > > I tested this on AMD Ryzen 7 8845HS and AMD Ryzen 7 7700.
> > >=C2=A0
> > > More importantly, we have been using linux-dovetail + AMD KVM on a 5.=
15 kernel with Xenomai 3.2.3 for a long time without any such problem.=C2=
=A0
> > > The hang only appeared after we upgraded to the 6.12 kernel.
> > >=C2=A0
> >=C2=A0
> > And that is exactly why we need test cases so that it does not take you
> > to update to 7.4 one day and find the next regression only late.
> > Anything which runs as part of CI can catch things already when we are
> > porting to the next kernel version.
> >=C2=A0
> > Jan
> >=C2=A0
> > > Best regards,
> > > liuyang
> > >=C2=A0
> > > > From: "Jan Kiszka"<jan.kiszka@siemens.com>
> > > > Date:=C2=A0 Wed, Sep 23, 2026, 13:34
> > > > Subject:=C2=A0 Re: [PATCH] KVM: SVM: Fix physical interrupt handlin=
g during vmentry/vexit
> > > > To: "=E5=88=98=E6=9D=A8"<liuyang@sinsegye.com.cn>, "Florian Bezdeka=
"<florian.bezdeka@siemens.com>
> > > > Cc: <xenomai@lists.linux.dev>, <songjianwei@sinsegye.com.cn>, "Phil=
ippe Gerum"<rpm@xenomai.org>
> > > > On 23.09.26 04:08, =E5=88=98=E6=9D=A8 wrote:
> > > > > Thank you for your reply. My test setup is as follows:=C2=A0
> > > > > We use KVM+QEMU on an AMD platform, with CPU passthrough and AMD =
integrated GPU passthrough.=C2=A0
> > > > > The codebase is linux-dovetail 6.12.90 + Xenomai 3.3.2. The issue=
 I encountered was=C2=A0that=C2=A0about one minute
> > > > > =C2=A0after the virtual machine started, the entire system would =
hang. After I tried applying the above patch,=C2=A0
> > > > > everything=C2=A0is running normally now. I'm not sure if there ar=
e other places that also need to be modified.
> > > > > =C2=A0I have tested on both AMD Ryzen 7 8845HS and AMD Ryzen 7 77=
00.
> > > > > You can use an AMD platform and start any virtual machine on the =
latest linux-dovetail kernel.
> > > > > =C2=A0
> > > > =C2=A0
> > > > ...or fully emulate SVM in QEMU - much slower but possibly also exp=
osing
> > > > remaining races (if any) differently.
> > > > =C2=A0
> > > > In any case and I as already pointed out the last time KVM came up:=
 We
> > > > need KVM workload aside RT in our regular test pipeline. Could be
> > > > combined with switchtest or at least become part of the background =
load
> > > > that we run during latency tests. And if that requires having a phy=
sical
> > > > AMD machine in test rack, then we need to add one. But maybe QEMU i=
s
> > > > sufficient for that as well.
> > > > =C2=A0
> > > > > Thanks.
> > > > > > From: "Florian Bezdeka"<florian.bezdeka@siemens.com>
> > > > > > Date:=C2=A0 Tue, Sep 22, 2026, 21:15
> > > > > > Subject:=C2=A0 Re: [PATCH] KVM: SVM: Fix physical interrupt han=
dling during vmentry/vexit
> > > > > > To: "liuyang"<liuyang@sinsegye.com.cn>, <xenomai@lists.linux.de=
v>
> > > > > > Cc: <songjianwei@sinsegye.com.cn>, "Philippe Gerum"<rpm@xenomai=
.org>
> > > > > > Hi,
> > > > > > =C2=A0
> > > > > > first of all:=C2=A0
> > > > > > Thanks for reporting that issue. Highly appreciated.=C2=A0
> > > > > > Some comments below.
> > > > > > =C2=A0
> > > > > > [ Cc: +Philippe ]
> > > > > > =C2=A0
> > > > > > On Sun, 2026-09-20 at 11:22 +0800, liuyang wrote:
> > > > > > > commit b2a37d35 ("KVM: SVM: Use raw_local_irq_{disable,enable=
} in
> > > > > > > svm_vcpu_enter_exit") replaced the explicit cli/sti around VM=
RUN with
> > > > > > > raw_local_irq_disable()/raw_local_irq_enable().
> > > > > > =C2=A0
> > > > > > The translation into the dovetail world:
> > > > > > commit b2a37d35 removed updating the hardware interrupt state.
> > > > > > =C2=A0
> > > > > > The code below now touches both states, the hardware + virtual =
IRQ mask.
> > > > > > That is not an 1:1 replacement.
> > > > > > =C2=A0
> > > > > > > =C2=A0
> > > > > > > As a result, the pipeline may still believe that physical int=
errupts are enabled
> > > > > > > while they are actually masked. If a physical interrupt is ta=
ken during the
> > > > > > > VMRUN/VMEXIT window, the out-of-band stage can observe an inc=
onsistent
> > > > > > > interrupt state, leading to a stuck vCPU.
> > > > > > > =C2=A0
> > > > > > > Restore the explicit sti/cli around VMRUN so that the Dovetai=
l pipeline stays
> > > > > > > consistent across the guest entry/exit path.
> > > > > > > =C2=A0
> > > > > > > Fixes: b2a37d35 ("KVM: SVM: Use local_irq_{disable,enable}_fu=
ll in svm_vcpu_enter_exit")
> > > > > > =C2=A0
> > > > > > The Fixes part is not really correct. We never touched / suppor=
ted the
> > > > > > AMD / SVM part of KVM on dovetail.
> > > > > > =C2=A0
> > > > > > Looking at the Intel / VMX part (see commit=C2=A0
> > > > > > f6885fab3c2b ("KVM: x86: dovetail: enable coexistence with out-=
of-band
> > > > > > scheduling") in 7.2-dovetail-rebase, I assume there is more wor=
k to do.
> > > > > > =C2=A0
> > > > > > How did you test that? Did you (IO) stress the host as well as =
the
> > > > > > guest?
> > > > > > =C2=A0
> > > > > > Seems I have no AMD system at hand ATM, so unclear how I could =
test
> > > > > > that.
> > > > > > =C2=A0
> > > > > > =C2=A0
> > > > > > > Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
> > > > > > > ---
> > > > > > > =C2=A0arch/x86/kvm/svm/svm.c | 4 ++--
> > > > > > > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > > =C2=A0
> > > > > > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > > > > > index e02a38da5..0e19d42b7 100644
> > > > > > > --- a/arch/x86/kvm/svm/svm.c
> > > > > > > +++ b/arch/x86/kvm/svm/svm.c
> > > > > > > @@ -4406,7 +4406,7 @@ static noinstr void svm_vcpu_enter_exit=
(struct kvm_vcpu *vcpu, bool spec_ctrl_in
> > > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * IRQs are being enabled/d=
isabled. =C2=A0Note! =C2=A0GIF=3D0 for the entirety of
> > > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * this path, so IRQs aren'=
t actually unmasked while running host code.
> > > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> > > > > > > - =C2=A0 =C2=A0 =C2=A0 =C2=A0raw_local_irq_enable();
> > > > > > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0local_irq_enable_full();
> > > > > > > =C2=A0
> > > > > > =C2=A0
> > > > > > local_irq_enable_full() enables both, the hardware as well as t=
he
> > > > > > virtual IRQs. The virtual part of that should be fine, I'm unsu=
re if we
> > > > > > should (unconditionally) touch the hardware state.
> > > > > > =C2=A0
> > > > =C2=A0
> > > > This should be fine, look at the comment of the original code above=
.
> > > > =C2=A0
> > > > I vaguely recall that guest entry has another IRQ mask that protect=
s the
> > > > atomic section between the host switching certain bits to the guest
> > > > state and the actual guest entry instruction that switches the rest=
,
> > > > sets the guests virtual IRQ mask, and restores that GIF to 1 so tha=
t the
> > > > host will receive IRQs targeting itself (via a guest exit).
> > > > =C2=A0
> > > > Jan
> > > > =C2=A0
> > > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amd_clear_divider();
> > > > > > > =C2=A0
> > > > > > > @@ -4416,7 +4416,7 @@ static noinstr void svm_vcpu_enter_exit=
(struct kvm_vcpu *vcpu, bool spec_ctrl_in
> > > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> > > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0__svm_vcpu_run(svm, spec_ctrl_intercepted);
> > > > > > > =C2=A0
> > > > > > > - =C2=A0 =C2=A0 =C2=A0 =C2=A0raw_local_irq_disable();
> > > > > > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0local_irq_disable_full();
> > > > > > > =C2=A0
> > > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0guest_state_exit_irqoff();
> > > > > > > =C2=A0}
> > > > > > > --=C2=A0
> > > > > > > 2.34.1
> > > > > > =C2=A0
> > > > > > Best regards,
> > > > > > Florian
> > > > > > =C2=A0
> > > > > > --=C2=A0
> > > > > > Siemens AG, Foundational Technologies
> > > > > > Linux Expert Center
> > > > > > =C2=A0
> > > > > =C2=A0
> > > > =C2=A0
> > > > =C2=A0
> > > > --=C2=A0
> > > > Siemens AG, Foundational Technologies
> > > > Linux Expert Center
> > > > =C2=A0
> >=C2=A0
> >=C2=A0
> > --=C2=A0
> > Siemens AG, Foundational Technologies
> > Linux Expert Center
>=C2=A0
