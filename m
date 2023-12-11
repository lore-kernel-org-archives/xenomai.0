Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3E236AFE
	for <xenomai@lists.linux.dev>; Mon, 11 Dec 2023 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="mAHWhcKM"
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20231211112847ff2d183fcdd7d745ef
        for <xenomai@lists.linux.dev>;
        Mon, 11 Dec 2023 12:28:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GtubxZESGDGFkNt9gLWwjPzN4o1EgTigRueYNLM8cTU=;
 b=mAHWhcKMb4yY9YSho4Ox1LP4YBoVKmD3KMqcxuGRG4Ak5YXMUftgEeY/PMzmnnGIfsgh9R
 BCRauxZaOo7kRkxo8UUmt4a0me9pyomLOf43yz05Z0GaOftW8jt+Vg63CSi7uWhLkjn7ljlT
 ymtBGCR8yc4WIrF2J0ngGbgDXY4/o=;
Message-ID: <bbd8eaf4c6d38c6fbc13adf564229a02a8b65c7c.camel@siemens.com>
Subject: Re: Re: Can xenomai-kernel boot on the second-generation hyper-v ?
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: mars_liu2023 <mars_liu2023@163.com>
Cc: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	xenomai <xenomai@lists.linux.dev>
Date: Mon, 11 Dec 2023 12:28:46 +0100
In-Reply-To: <31323726.c97.18c537f1296.Coremail.mars_liu2023@163.com>
References: <420e5f7c.141a.18c2e864085.Coremail.mars_liu2023@163.com>
	 <3718a82d-7421-49b0-8a4d-21b8886d2e8a@siemens.com>
	 <cd40b0a44612f1f233aba3b3e8fe3748833771c9.camel@siemens.com>
	 <87il5al8zb.fsf@xenomai.org>
	 <a7756962bd637d2738611761c600bf81d367aab9.camel@siemens.com>
	 <31323726.c97.18c537f1296.Coremail.mars_liu2023@163.com>
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

On Sun, 2023-12-10 at 19:31 +0800, mars_liu2023 wrote:
>=20
> At 2023-12-07 21:21:42, "Florian Bezdeka" <florian.bezdeka@siemens.com> w=
rote:
> > On Thu, 2023-12-07 at 08:52 +0100, Philippe Gerum wrote:
> > > Florian Bezdeka <florian.bezdeka@siemens.com> writes:
> > >=20
> > > > On Tue, 2023-12-05 at 15:40 +0900, Jan Kiszka wrote:
> > > > > On 03.12.23 15:13, mars_liu2023@163.com wrote:
> > > > > > Hi xenomai,
> > > > > >=20
> > > > > > I tried to learn the Xenomai kernel on =C2=A0Hyper-V=EF=BC=8Can=
d appear some problems.
> > > > > > xeno-kernel can't boot on the hyper-v ,so i did the following .
> > > > > > I saw such a message in other mails in the community that "prev=
ent CONFIG_HYPER from being built if interrupt pipeline is enabled",so i di=
sabled CONFIG_HYPER for =C2=A0boot xeno_kernel(version :5.10.180-xenomai.3.=
2.2)=C2=A0 on hyper-v .
> > > > > > it can work well on the fist-generation hyper-v,but it's boot f=
ailed on the second-generation hyper-v.
> > > > > > This is also the=C2=A0 case when disabled CONFIG_HYPER on norma=
l linux kernel.
> > > > > > Did i do something wrong ? it seems linux (vesrion 5.10.180) di=
sabled CONFIG_HYPER can't work on the second-generation hyper-v.
> > > > > > Is xeno-kernel(dovetail) not allowed to work on the second-gene=
ration hyper-v? if not ,how do i do it ?
> > > > > > thanks for any reply.
> > > > >=20
> > > > > I vaguely recall some very unfortunate internal dependencies of H=
yper-V
> > > > > device drivers support on CPU paravirt features, at least Kconfig=
-wise,
> > > > > but I don't recall all details. Florian, do you?
> > > >=20
> > > > No. The situation is a bit strange here. Adding Philippe, we might =
have
> > > > a typo in drivers/hv/Kconfi:
> > > >=20
> > > > Taken from drivers/hv/Kconfig:
> > > >=20
> > > > config HYPERV
> > > > 	tristate "Microsoft Hyper-V client drivers"
> > > > 	depends on ACPI && !IRQ_PIPIPELINE && \
> > > > 		((X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> > > > 		|| (ARM64 && !CPU_BIG_ENDIAN))
> > > >=20
> > > > !IRQ_PIPIPELINE will always be true (due to the typo).
> > > >=20
> > >=20
> > > Yep, was fixed in 6.4 and above.
> > >=20
> > > > That explains why one of my kernel configurations with
> > > > 	CONFIG_IRQ_PIPELINE=3Dy
> > > > 	CONFIG_HYPERV=3Dm
> > > > builds, but I have never tried to boot it up on any hyper-v enabled
> > > > machine so far.
> > > >=20
> > > > Question to Philippe: Why did you try to disable the HYPERV bits? D=
ue
> > > > to the lack of testing or is there more behind it? Building works, =
so
> > > > it must have been something hat happens during runtime...
> > > >=20
> > >=20
> > > I did not care about HYPERV, that's pretty much the reason. Which mea=
ns
> > > no use case, therefore no specific work on enabling/testing interrupt
> > > pipelining for this beast, so I forced it off. Only PARAVIRT_XXL is
> > > officially a no-go for Dovetail ATM, because the current irqflags
> > > implementation for x86 prevents it.
> > >=20
> >=20
> > Philippe, thanks for the clarification. I might have to revisit this
> > topic in the future as some colleagues had some thoughts about using
> > hyper-v during development. If we would report back that it works
> > (maybe with some necessary fixes) you would consider removing the
> > restriction?
> >=20
> > To the original thread creator: It's quite clear that you face boot
> > problems over hyper-v without hyper-v guest support in the kernel
> > (=3Ddisabled CONFIG_HYPERV). I can't say something about the different
> > versions of hyper-v regarding dovetail/xenomai yet. I have never tried
> > it. Can you follow the boot process by some kind of virtual serial
> > console? Any relevant output?
>=20
> >=20
> Reply to florian: The logs of  the xeno-kernel (disable CONFIG_HYPER) boo=
t process  on the second genernation hyper-v is as follows=EF=BC=8C
>     Begin: Running /scripts/local-block ... done
>     Begin: Running /scripts/local-block ... done
>     Begin: Running /scripts/local-block ... done.
>     done
>     Gave up waiting for suspend/resume device
>     done
>     Begin: Waiting for root file system ... Begin: Running /scripts/local=
-block ... done.
>     done
>     Gave up waiting for root file system device. Common problems
>     - Boot args (cat /proc/cmdline)
>     - Check rootdelay=3D (did the system wait long enough?)
>     Missing modules (cat /proc/modules; ls /dev)
>     ALERT! UUID=3Db74e52a4-0fcd-440c-a348-0295480d4e50 doesnot exist. Dro=
pping to a shell!
>     BusyBox v1.30.1 (Debian 1:1.30.1-6+b3) built-in shell (ash)
>     Enter 'help' for a list of built-in commands.
> Get here ,the shell can't take any input(keyboard and mouse don't work he=
re).
>=20
> Best regards

Well, your rootfs can not be found. Likely because of a missing driver.
How is the virtual hard disk modeled on that kind of hypervisor? SATA,
SCSI, virtio, ...?

Once again: It doesn't make sense trying to boot Linux without the
necessary VMM tools/drivers enabled. You can enable them right now,
this is still an accident, but if it works we might ask Philippe in the
future to remove this restriction.


