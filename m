Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EA81F163
	for <xenomai@lists.linux.dev>; Thu, 13 Jul 2023 15:57:03 +0000 (UTC)
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 86D33100003
	for <xenomai@lists.linux.dev>; Thu, 13 Jul 2023 15:56:56 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 950DE740035
	for <xenomai@xenomai.org>; Thu, 13 Jul 2023 15:56:55 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230713155655df5fccfcc36f877ece
        for <xenomai@xenomai.org>;
        Thu, 13 Jul 2023 17:56:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=gXOZndPetJHVtH0u4ojg1zPxbTtC6zBtV+2T/eOOkXI=;
 b=ER8N0QzyxYqjhnM2lPNn1QSiGCwCE8x+OlOoP2eS4VUGfE+GVs6HgxYRvrekXafhWkSoo0
 uUI7MeCAhkly4NgiYmoLwOVxGzCmlPnBd6O7xsxzj1woo0WIx/eM48hDyBFIeLdrb3bQZC4O
 C7SktqQqU+9w/Myv5XA+Ja12/WRNI=;
Message-ID: <a7e4f5d61a527afea5cb413d2c07dd0f0227ad64.camel@siemens.com>
Subject: Re: UDP checksum incorrect when using RTnet network driver
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Brandon Ho <brho@relativityspace.com>, "xenomai@xenomai.org"
	 <xenomai@xenomai.org>
Cc: Jay Sridharan <jsridharan@relativityspace.com>
Date: Thu, 13 Jul 2023 17:56:54 +0200
In-Reply-To: <SA1P110MB1278E19EF6B5E38108A221CED337A@SA1P110MB1278.NAMP110.PROD.OUTLOOK.COM>
References: 
	<SA1P110MB1278E19EF6B5E38108A221CED337A@SA1P110MB1278.NAMP110.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
Authentication-Results: spool.mail.gandi.net;
	dkim=pass header.d=siemens.com header.s=fm1 header.b=ER8N0Qzy;
	dmarc=pass (policy=reject) header.from=siemens.com;
	spf=pass (spool.mail.gandi.net: domain of fm-68982-20230713155655df5fccfcc36f877ece-2_lIa1@rts-flowmailer.siemens.com designates 185.136.65.227 as permitted sender) smtp.mailfrom=fm-68982-20230713155655df5fccfcc36f877ece-2_lIa1@rts-flowmailer.siemens.com

Hi Brandon,

On Thu, 2023-07-13 at 15:45 +0000, Brandon Ho wrote:
> Hi,
>=20
> I have been playing around with trying to send UDP messages over RTnet bu=
t have run into a weird bug where the UDP packets sent with the RTnet netwo=
rk driver end up with an incorrect checksum.
>=20
> Currently I do not run RTmac or tdma. The script I am running to send the=
 UDP packets is the example Xenomai native script from the RTnet repo:
> https://sourceforge.net/p/rtnet/code/ci/master/tree/examples/xenomai/nati=
ve/frag-ip.c
>=20
> I use this script largely unchanged (just changing the dest/local ip to t=
hat of my devices)
>=20
> A couple more details:=20
>=20
> My startup script for RTnet is as follows
>=20
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82 modprobe rtnet >/dev/null || exit 1
>         modprobe rtipv4 >/dev/null || exit 1
>         modprobe $RT_DRIVER >/dev/null || exit 1
>         echo $ETHERNET_PCI_BUS_NUM > /sys/bus/pci/devices/$ETHERNET_PCI_B=
US_NUM/driver/unbind
>         echo $ETHERNET_PCI_BUS_NUM > /sys/bus/pci/drivers/$RT_DRIVER/bind
>         modprobe rtpacket >/dev/null || exit 1
>         modprobe rtudp >/dev/null || exit 1
>         modprobe rt_loopback >/dev/null || exit 1
>=20
>         $RTIFCONFIG rtlo up 127.0.0.1  =20
>         $RTIFCONFIG rteth0 up $IP_ADDR netmask $NETMASK
>         sleep 3
>=20
>         $RTROUTE solicit $HOST_IP dev rteth0
>=20
> The IP_ADDR is the local address of the device and the HOST_IP refers to =
the end host I'd like to send packets to -- all other vars follow the conve=
ntion in the default rtnet startup script. I am able to rtping my end host =
successfully.
>=20
> When I wireshark on the end host (device receiving the UDP packets), I se=
e that the checksum is consistently wrong, but the data payload is correct.=
 When I unload the rt driver from the network card (rt_e1000e) and load bac=
k the normal driver (e1000e) the checksum is correct. Just wondering what m=
ight be wrong.

Which component does the checksum calculation in this scenario? The
application, the driver or via HW offloading (if supported by the
HW...) the HW itself?

Maybe double check that you don't have two checksums. Might happen if
the application already provides a checksum and the device (or driver)
adds one more because of incorrect configuration.

Sorry, no more ideas so far...

>=20
> System info: (this is what I see when I run xeno-config --info)
> Xenomai version: Xenomai/cobalt v3.2.2 -- #62edc8a (2023-02-24 18:50:51 +=
0100)
> Linux xxxx-xxxxxxxx-2 5.15.98-xen3.2+ #4 SMP IRQPIPE Thu Mar 23 02:04:47 =
UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
> Kernel parameters: BOOT_IMAGE=3D/boot/vmlinuz-5.15.98-xen3.2+ root=3DUUID=
=3Df236e094-4a8a-49e8-829f-42f54b1eb5d8 ro quiet splash i915.enable_rc6=3D0=
 i915.enable_dc=3D0 noapic nosmap xenomai.smi=3D1 xenomai.allowed_group=3D3=
0000 cpuidle.off=3D1 vt.handoff=3D7
> Cobalt core 3.2.2 detected
> Compiler: gcc version 11.3.0 (Ubuntu 11.3.0-1ubuntu1~22.04)
> Build args:
>=20
> Thanks!

