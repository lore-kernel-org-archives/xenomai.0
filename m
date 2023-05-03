Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD2A4A11
	for <xenomai@lists.linux.dev>; Wed,  3 May 2023 13:43:26 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-2f86ee42669so5002501f8f.2
        for <xenomai@lists.linux.dev>; Wed, 03 May 2023 06:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20221208.gappssmtp.com; s=20221208; t=1683121404; x=1685713404;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUhqDKmfylvJCgVhnH3gTTfVRWuZfuyLZoKQxtgH8ko=;
        b=IoRS11GTppfvvP4Ixh6rKhuEnoBedDGTGrXEnoG+dYgk3JAjfjvXT9adWzBtGYtkro
         gWntPOMFjHODeFfb+7McEc3ThCHp/zvVVRQ7MJ6tTbmmEWqj37y/TYtdKhoHZMLoG/r5
         Z6pxPMJxEHHvqi+xo+Sq/d8rsq4rqxT5heW28BDcJ7Nm3RluCtRttGFKq/PkYWJRVmcQ
         sR58SrH9fu48oB02DhZJK44vp+wLTZjKi40TjfBJPCvFdj9SI77t7r2cvD/3jG/fllEI
         YtsMAGJbfnWUHkAOeJw+aLdrfEOmS+PUvcl+dar9baraKcF2KFOQ3GxMs7qSMu/XUkd4
         ChIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683121404; x=1685713404;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DUhqDKmfylvJCgVhnH3gTTfVRWuZfuyLZoKQxtgH8ko=;
        b=hCNm4s0ssJgwm9d13pWoSGtidD7Bk3TDKn8dDwDZq33w9h1pHr5dkCWno/3DoPlLOg
         S7BngomWPRiO19551C+OOZni8aDF2kITuC5JND7MkMtQ5nZdm8P6GPyq/QqL7IW0qk+/
         qCx/8E9/f0eii44KvJV+ZVAbyg6FHsfwDhD1M0lVCsMEOcFJ+T/fGIf2I/4c7OZcqwkP
         CdJ3dE3yP/Rt3zqwPaxc9WLiBk4Iyz/8ZBHMWWXY88a70FApDlOfMUs8am8RImd6bom9
         RYFBiFj+IuZpaG06yZO5xC1q7hNLYZepIw4OfBw9+621t27sjG5qqjd/6prHxxNybWm4
         6uoA==
X-Gm-Message-State: AC+VfDzon5jnG2/PaDGRpPgxDd5e0SY5dqClYATQhZzyzTJoLPi7gDcY
	udgIYaQfWjURnt/9mrWac80GDMKyOQbYeHDaO5E=
X-Google-Smtp-Source: ACHHUZ7m6elTNwjAwVEMDVorif0V1N2tNLlr2T94CIEHFWpE5wQxo+hMkvSQH2ys8FN2uPtuZ5Kbaw==
X-Received: by 2002:a5d:4a85:0:b0:2ef:bc0b:e70 with SMTP id o5-20020a5d4a85000000b002efbc0b0e70mr97037wrq.54.1683121404219;
        Wed, 03 May 2023 06:43:24 -0700 (PDT)
Received: from [192.168.101.56] (i19-lef02-th2-212-194-241-67.ft.lns.abo.bbox.fr. [212.194.241.67])
        by smtp.gmail.com with ESMTPSA id f17-20020a5d50d1000000b002e5f6f8fc4fsm33661043wrt.100.2023.05.03.06.43.23
        for <xenomai@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 06:43:23 -0700 (PDT)
Message-ID: <5a8afa1e-d6d7-df9f-2895-6832ffa9673f@smile.fr>
Date: Wed, 3 May 2023 15:43:23 +0200
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From: Julien Aube <julien.aube@smile.fr>
Subject: Question about a freeze under Xenomai 3.2.1
To: xenomai@lists.linux.dev
Content-Language: fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,


I'm currently porting an old code from Xenomai 2 to Xenomai 3/Dovetail.

I'm using kernel 5.10.177-dovetail1 as this is the latest version I 
could work with xenomai 3.2.1.
The driver I'm porting makes heavy use of RTDM.

The platform is a Zynq 7030 (dual cortex-9).

I uses buildroot 2022.11 to build.

I hit a strange issue and ask for an advice before having to setup JTAG 
/ opencd , as you may have seen
the same issue before.

On the aforementioned platform , everything goes well as long as I do 
not enable SMP.
If I do, what happens is that Ethernet's phy detection hangup forever :

> Registering platform device 'Fixed MDIO bus.0'. Parent at platform
> device: 'Fixed MDIO bus.0': device_add
> bus: 'platform': add device Fixed MDIO bus.0
> device: 'fixed-0': device_add
> bus: 'mdio_bus': add driver Micrel KS8737
> [...]
> bus: 'mdio_bus': add driver Microchip KSZ9477
> bus: 'platform': add driver macb
> bus: 'platform': driver_probe_device: matched device e000c000.ethernet 
> with driver macb
> bus: 'platform': really_probe: probing driver macb with device 
> e000c000.ethernet
> macb e000c000.ethernet: no pinctrl handle
> device: 'e000c000.ethernet-ffffffff': device_add

If I disable SMP in the linux config kernel , here is what I have :

> Registering platform device 'Fixed MDIO bus.0'. Parent at platform
> device: 'Fixed MDIO bus.0': device_add
> bus: 'platform': add device Fixed MDIO bus.0
> device: 'fixed-0': device_add
> bus: 'mdio_bus': add driver Micrel KS8737
> [...]
> bus: 'mdio_bus': add driver Microchip KSZ9477
> bus: 'platform': add driver macb
> bus: 'platform': driver_probe_device: matched device e000c000.ethernet 
> with driver macb
> bus: 'platform': really_probe: probing driver macb with device 
> e000c000.ethernet
> macb e000c000.ethernet: no pinctrl handle
> device: 'e000c000.ethernet-ffffffff': device_add
> device: 'e000c000.ethernet-ffffffff:01': device_add
> bus: 'mdio_bus': add device e000c000.ethernet-ffffffff:01
> bus: 'mdio_bus': driver_probe_device: matched device 
> e000c000.ethernet-ffffffff:01 with driver Micrel KSZ9031 Gigabit PHY
> bus: 'mdio_bus': really_probe: probing driver Micrel KSZ9031 Gigabit 
> PHY with device e000c000.ethernet-ffffffff:01
> Micrel KSZ9031 Gigabit PHY e000c000.ethernet-ffffffff:01: no pinctrl 
> handle
> driver: 'Micrel KSZ9031 Gigabit PHY': driver_bound: bound to device 
> 'e000c000.ethernet-ffffffff:01'
> bus: 'mdio_bus': really_probe: bound device 
> e000c000.ethernet-ffffffff:01 to driver Micrel KSZ9031 Gigabit PHY
> device: 'eth0': device_add
> macb e000c000.ethernet eth0: Cadence GEM rev 0x00020118 at 0xe000c000 
> irq 24 (xx:xx:xx:xx:xx:xx)

Kernel command line is rather simple :

 > console=ttyPS0,115200 earlyprintk root=/dev/nfs rw 
nfsroot=192.168.101.56:/home/rootfs/rootfs_2022,vers=4,tcp ip=dhcp


=> Is this something you already faced ?
If not , do you have any insight on debugging method besides JTAG ?

Thanks


Julien Aube


