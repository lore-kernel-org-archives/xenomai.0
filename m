Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E53B19A
	for <xenomai@lists.linux.dev>; Thu, 30 Jan 2025 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738260027; cv=none; b=N2mR2sNA4ooVmlmynR94txDjnbAeRaoL5QP3TQ3VZUhTQhnznHf3rMgR7koTTk6sI04nAW+KU6TRWVfCSHVHcpIEQRgDPpmoqhNFTgCMjsOH46jyfedZTjAEtavDIZd2iTh24CDqXb+iZUoDPb/KxuTz3Rg5cEgTNlfss526tGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738260027; c=relaxed/simple;
	bh=JizsldtQI8Jf2XNVhX8SCNmLAG+VvPM836/4JX636/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JwRP3DJaFIuAKivhQquMhGwtUPkA/DT+cbLPdN1+QIzGuS8198O6lJVLKKNoyO69fqEuVmfSFqTHYbkNCj+g5KHnaETlz0rpQCjUZz4Q4WCg+796+NWRIpCHbptqz9/gCxB43DuS09C6Fa8ruKzdqWuyPCk7LIGpzL++8a7jhRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=f5zuT95E; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="f5zuT95E"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47F024417A;
	Thu, 30 Jan 2025 18:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1738260022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZcl7hZ+mnY4a1bMQBLpMZQCJayIyvY3fgN12PzL/Jw=;
	b=f5zuT95Et5pTTrnSowJQ8XE2N/L0onxuMZXqO0n88p+jHNRz6WbsKlLcFrD8RQDx4RLq2J
	ZTILe5inWODcAjWqql5Z/vAn+qBxAut+7C/X2lIb67EVjj/2Y1u9tfbpLFRr94AebnyVvh
	ZAlvfL+gr++OWWlD+BUkgIs3NLwoHtKtTmUc43DAr8rrULRC5C23PfzXJc9irdpWsSLr6G
	f905HzyrbqDK+RQDXncRqRjsW+I2eV/oSc2++dzQ7qmk4bj/Bsb9vJ9Uuff0ofXOhsWjbu
	K8bu5L8jhzN+E14A4IjS68SkTXr74UZbB07FGdFhKq8CbbT7Qntn65h1etLoRA==
From: Philippe Gerum <rpm@xenomai.org>
To: Gijs van Oort <g.vanoort@utwente.nl>
Cc: xenomai@lists.linux.dev
Subject: Re: SPI on Raspberry Pi (RPi) 4 + Ubuntu24.04 + EVL does not work
In-Reply-To: <f1fd1edd-6d09-4e59-a85a-f00cf3b19727@utwente.nl> (Gijs van
	Oort's message of "Thu, 30 Jan 2025 14:55:44 +0100")
References: <f1fd1edd-6d09-4e59-a85a-f00cf3b19727@utwente.nl>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Thu, 30 Jan 2025 19:00:21 +0100
Message-ID: <87ldusyyfe.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhephfeivddttddtvdethfdvhfehveejheduuedvkeeukeefvdfgfeetteeffeelueeknecuffhomhgrihhnpeguvghngidruggvpdhpohhrthdrtggrthdpghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegvtdgrmedulegsmeeftggutdemleeklegrmeehtgegsgemsgejfhhfmegsrghfpdhhvghlohepphihrhhopdhmrghilhhfrhhomheprhhpmhesgigvnhhomhgrihdrohhrghdpnhgspghrtghpthhtohepvddprhgtphhtthhopeigvghnohhmrghisehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepghdrvhgrnhhoohhrthesuhhtfigvnhhtvgdrnhhl
X-GND-Sasl: rpm@xenomai.org

Gijs van Oort <g.vanoort@utwente.nl> writes:

> I am trying to get SPI working on the EVL kernel on a Raspberry Pi 4
> with Ubuntu 24.04 Sever 64 bits. And I fail. Can anyone shine a light
> on the problem?
>
> Basically what I tried is the following: straightforward
> cloning-configuring-building-installing (a little different though
> because I compiled inside an LXC container running Ubuntu 24 on my
> laptop since my main install is Ubuntu 22 and I don't want to mix up
> versions):
>
> 1. Get sources:
> =C2=A0=C2=A0 `git clone --depth=3D1 --branch=3Dv6.6.y-evl-rebase
> https://source.denx.de/Xenomai/xenomai4/linux-evl`
> 2. Create .config file:
> =C2=A0=C2=A0 `make O=3D../linux-evl-build ARCH=3Darm64
> CROSS_COMPILE=3Daarch64-linux-gnu- defconfig`
> 3. Update .config file to make sure EVL is on (CONFIG_EVL=3Dy) and all
> relevant SPI modules are included as module (CONFIG_SPI=3Dy;
> CONFIG_SPI_SPIDEV=3Dm; CONFIG_SPI_BCM2835=3Dm; CONfIG_SPI_BCM28356AUX=3Dm=
; I
> don't bother about SPI_OOB for the moment) with command line scripts
> (`scripts/config --module SPI_SPIDEV`)
> 4. Resolve dependencies in .config:
> =C2=A0=C2=A0 `make O=3D../linux-evl-build ARCH=3Darm64
> CROSS_COMPILE=3Daarch64-linux-gnu- olddefconfig`
> 5. Compile:
> =C2=A0=C2=A0 `make -j$(nproc) O=3D../linux-evl-build ARCH=3Darm64
> CROSS_COMPILE=3Daarch64-linux-gnu- Image modules dtbs`
> 6. Create Ubuntu24-Server-64-bits SD card for the Raspberry Pi with
> Raspberry Pi Imager
> 7. Install new kernel:
> =C2=A0=C2=A0 `sudo env PATH=3D$PATH make O=3D../linux-evl-build ARCH=3Dar=
m64
> CROSS_COMPILE=3Daarch64-linux-gnu- INSTALL_PATH=3D$FSBOOT install`
> =C2=A0=C2=A0 `sudo env PATH=3D$PATH make O=3D../linux-evl-build ARCH=3Dar=
m64
> CROSS_COMPILE=3Daarch64-linux-gnu- INSTALL_MOD_PATH=3D$FSROOT
> modules_install`
> 8. Copy the new device tree file and make sure that it is used:
> =C2=A0=C2=A0 `cp
> ../linux-evl-build/arch/arm64/boot/dts/broadcom/bcm2711-rpi-4-b.dtb
> $FSBOOT/bcm2711-rpi-4-b-evl.dtb`
> =C2=A0=C2=A0 `echo "device_tree=3Dbcm2711-rpi-4-b-evl.dtb" >>
> /media/$USER/$SD_BOOT/config.txt`
> 9. Boot the Raspberry Pi with the created Ubuntu image plus new kernel
>
> I don't bother about evl-lib at this moment (installing that will be
> trivial once SPI is running).
>
> What I get is a booting and working system (`uname -a` shows that I
> indeed run the created EVL kernel) but without working SPI. Some
> observations (all observed in the system with the new installed
> kernel, unless otherwise specified):
> * When I just run a fresh Ubuntu 24 Server install on the Raspberry Pi
>   (no EVL kernel), spi works as expected (e.g., `echo "hello" >
>   /dev/spidev0.0` as root works and gives the expected signals on the
>   SPI pins).
> * In config.txt, SPI is enabled (`dtparam=3Dspi=3Don`)
> * No SPI-related entries in /dev (`ls -al /dev/sp* -d` gives no hits)
> * SPI modules are loaded (`lsmod | grep spi` shows both spidev and
>   spi_bcm3835)
> * I do see SPI related items in /proc/device_tree : `cat
>   /proc/device-tree/soc/spi@7e204000/status` yields 'okay', suggesting
>   that at least something SPI related should be enabled (also, the
>   address 7e204000 is indeed related to the default SPI port).
> * `cat /proc/devices | grep spi` shows "153 spi", indicating that
>   there is indeed some SPI driver active with 153 as major device
>  number.
> * All in all everything seems to be okay, except the fact that there
>   is no spi related entry in /dev. Using `sudo mknod /dev/spidev0.0 c
>   153 0` does create an entry but it is not working (`echo "hello" >
>   /dev/spidev0.0` as root gives the error message "bash:
>   /dev/spidev0.0: No such device or address").
> * Contrary to a fresh Ubuntu24 install, the commands `dtparam` and
>   `dtoverlay` do not work. (on a fresh Ubuntu24 they do work and I am
>   able to enable and disable spi at runtime with both `dtparam
>   spi=3Don`/`dtparam spi=3Doff` and `dtoverlay spi0-2cs` as root. The spi
>   entries in /dev appear and disappear accordingly). On the version
>   with the EVL kernel I get the error message "mount:
>   /config/device-tree: mount point does not exist." when I try either
>   function. Could this be a hint that dtparam/dtoverlay could not work
>   at boot time (i.e., when parsing config.txt) either?
>
> Other things I tried (none of them had any noticeable effect; all
> showed the behavior listed above):
> * Last year I had a similar struggle in getting SPI to work on an
>   Ubuntu 22.04 Server for Raspberry Pi. I ended up using the work of
>   Deniz Ugur (https://github.com/DenizUgur/RPi4-EVL-4xSPI), which gave
>   a working setup (with 4 SPI's even, if only I could borrow one of
>   those for this year...). That setup used kernel 5.15.119. Apart from
>   a small patch to tweak the bcm2711-rpi-4-b.dts device tree file, and
>   a customized .config there was nothing much to it. Unfortunately,
>   trying to do the same patches (tried both literally with `patch` and
>   conceptually by applying similar changes to the .dts file manually)
>   to the 6.6 kernel did not have any effect. Note that on this system,
>   `dtparam` and `dtoverlay` did not work either; apparently it is
>   possible to get SPI working without that having to work.
> * Tried many different .config files. Always made sure that the SPI
>   related modules were included as module (also tried once or twice to
>   include them built-into the kernel (CONFIG_SPI_SPIDEV=3Dy etc) without
>   any positive effect). All .config files gave the same behavior
>  (SPI-wise).
> * Kept the bcm2711-rpi-4-b.dtb file from the fresh Ubuntu 24 image
>   instead of replacing it by the newly generated .dtb file (i.e.,
>   skipped step 8). I could not spot any difference in behavior.
> * Cloned the Raspberry Pi Linux kernel (`git clone --depth=3D1
>   https://github.com/raspberrypi/linux linux-rpi`) next to the EVL
>   kernel and copied all relevant device tree files from the Raspberry
>   Pi kernel into the EVL kernel directory; then used that for the
>   device tree generation (specifically: arch/arm*/boot/dts/broadcom,
>   arch/arm*/boot/dts/overlays, arch/arm64/configs and two .h files
>   that ar required for the dts files).
> * Copied a (known working, for Ubuntu22-kernel 5.15.119)
>   bcm2711-rpi-r-b.dtb device tree file to the new image and used that.
> * Tried EVL kernel 6.12.y
>
> Now I'm officially out of ideas, so hopefully someone can help me...
>
> Kind regards,
>
> Gijs van Oort
> University of Twente
> The Netherlands

Bottom-line: enabling EVL has zero effect on the SPI driver being
present/installed or not, it is merely extending the SPI core and
bcm2835 driver capabilities if present, without stripping out any
standard/pre-existing feature. EVL does not even know about config.txt
and other RPI-specific overlays and boot config stuff.

EVL is based on the mainline kernel, which may not have all of the
RPI-specific code from the Raspberry vendor tree. You may want to try
this kernel [1] which is a port of the EVL code originally based on
mainline on top of the RPI fork. This is 100% untested, this quick port
was a courtesy to help a user who struggled doing this by himself due to
code merge issues. This kernel should at least boot with EVL disabled in
the kernel configuration, and you should see the SPI slave devices as
expected. If so, enabling EVL would be the next step and see what
happens from there (I'm pretty sure no SPI device would disappear if the
Kconfig only changes for enabling CONFIG_EVL). You may want to check out
this past discussion [2] about [1] too.

[1] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/tree/vendor/rpi/v6.=
6.47?ref_type=3Dheads
[2] https://lore.kernel.org/xenomai/CABnSPHZg11FCXDwap0+=3DQ-QwizS0MwALuQg2=
bR9ndy1fBVCi2A@mail.gmail.com/

--=20
Philippe.
