Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088946E611
	for <xenomai@lists.linux.dev>; Tue, 28 May 2024 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889001; cv=none; b=U/zup2+2c5Dn+qN0Pc3rfJL5j+ISLuDU8I0aw9ALXTUTze7gWIovdy1PCgTaXcTjbcs7DkLZs067ggMvcT0SHzqdITpGxoI5rHfNT+2lBG4yiOj6Zdfgguy17GUxqu2L1Hr1NKGerAycSmZOD/yCxRmKVrYt6VBeXVU6CG1mnXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889001; c=relaxed/simple;
	bh=9sQTDI8cv30pXwBnIWacwxgxrRi74xsrFPpOvz529kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GG+vJwUfOmQjlk2+poQ6kpx2RKQD57G4hRE9nBc/fW5kooWpHpnpblMbM9zvBp5hwTs66fwWNn5PKe+3XUR6dECo9hSsTDlKRmiT+6CKGND6E3wV0PsShDxGGlXa4CR4jAsnHedBAf1Ju8AlKS+BAFYlJ+yACvdoJMVASJn/zyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxAqrpeM; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxAqrpeM"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-657a07878easo544602a12.0
        for <xenomai@lists.linux.dev>; Tue, 28 May 2024 02:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716888999; x=1717493799; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTNIhsPvWYpJ5o1RZHp7U7kP3SwEsrJZKLLj7nTAaVw=;
        b=FxAqrpeMKkLhR5xozrHZ7wPmwigvmp45P/1aTWmViWUag5yxHB3XIwijwMH3vq3ELG
         26SCETBaoDMP87bA/lo7/d9xFuHJy6ZswH2CW8ITenwU+l6Ni5edckBykyBX0Opq4MEb
         EMY0iEtTG76fzsURu6vVPcteBB95lIdukdjiCdwF1NRiEjwsIG9xry69Les+nmeS9dv5
         S3jq0UYOKn5g833SMRFQL4SL3B4tp4Iyc3ZwJtE17V3oDYYniarZK8aJ5pbEgs6Xc7El
         BW7bWVqZoq2THnWV3K0qPsC4ZhgfE0H6d08NIPNi9ihGIv0PVWjKmLyVKxvlaI+Aa2it
         b3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716888999; x=1717493799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTNIhsPvWYpJ5o1RZHp7U7kP3SwEsrJZKLLj7nTAaVw=;
        b=a/UwBz5I5z0j9xLbY7pO23JUOSOVFInSc5OB5Og4/WaLSjnT2vxo+48gRHIvU8JJXs
         8T3O9YBprZLK34wq7zG2f033JSdAeq4dtjme/MK1SC84Pe55ro5MuUYxUE0Ae5J2FU3t
         CHjwtB2qrym9Sd/wtCjlfhfq7bHDGCDaJqgiBKJlb++92tGTYB0w+EWgFYLuG5qzit1w
         22pCztpd7Wi5dlcRjCRYvEWRKix6Rte9wxHyQBUWlWqgzixJFjBHTRzSI+kZN6ea4oCe
         JEml4TFqChjg+4oEy3HHr+g9POv6zHLPPV53+iu8UmQvU1OYIwjX5C5L+ADP0pSaV+M3
         ndxg==
X-Forwarded-Encrypted: i=1; AJvYcCW4u+KnjevDfZL2ulDx+G6Tcsqd47AyxUMFpEOdhd5b/PNexlUsJMWL42TrYvwF0NatCbkImtd40kAzDIaYsl8mNhKEV/GsPg==
X-Gm-Message-State: AOJu0YzgIAnwRjYYoS6wd1ZI7BtBPtCWXyElhawKALvp7Bq5oOstyuNl
	Ks5rbp00TcV6Uog70KF/nL7nEUoyFabiTtl6LbNkjf2OGlik0ot6mAVOVwtu7wTeJsnSkHqTxml
	ZoV0fe2/MkMbDBAjH+lVeIccukYw=
X-Google-Smtp-Source: AGHT+IF9ddIen49/toMgHcCukyS9QGtDpc689EaHd3Cs7Fk8LM0zp2zF9Bk0lMrCvjI/YBiWNXVu9G/5QdeXdNp0G/4=
X-Received: by 2002:a17:90a:e996:b0:2bf:4c7a:e47a with SMTP id
 98e67ed59e1d1-2bf5f71a61bmr12778079a91.42.1716888999217; Tue, 28 May 2024
 02:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAH0t8y01h5W8Hsa=xvUJCyQM5VeA8CSTftBvLYrzbzQHenv7zw@mail.gmail.com>
 <PH7PR11MB749952ADE786FE1D78EA1A91F2F12@PH7PR11MB7499.namprd11.prod.outlook.com>
 <5de1a72a-ce0c-492a-b5ba-5bdc659df4a7@siemens.com> <PH7PR11MB7499FB6B26032D1645F9BDD6F2F12@PH7PR11MB7499.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7499FB6B26032D1645F9BDD6F2F12@PH7PR11MB7499.namprd11.prod.outlook.com>
From: =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>
Date: Tue, 28 May 2024 11:35:11 +0200
Message-ID: <CAH0t8y2ibgH-yuGS_GZphqmVO3o5k25gKZUchBXt9oy9E=9aCQ@mail.gmail.com>
Subject: Re: rt_igc fails to bing an i225-V Ethernet device
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Cc: "Kiszka, Jan" <jan.kiszka@siemens.com>, xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

After applying the patch, it works fine!
Thank you very much!

Best regards,
Tamas

Chen, Hongzhan <hongzhan.chen@intel.com> ezt =C3=ADrta (id=C5=91pont: 2024.=
 m=C3=A1j.
28., K, 9:31):
>
>
>
> >-----Original Message-----
> >From: Jan Kiszka <jan.kiszka@siemens.com>
> >Sent: Tuesday, May 28, 2024 1:22 PM
> >To: Chen, Hongzhan <hongzhan.chen@intel.com>; Tam=C3=A1s Pa=C3=A1l
> ><paal.tam@gmail.com>; xenomai <xenomai@lists.linux.dev>
> >Subject: Re: rt_igc fails to bing an i225-V Ethernet device
> >
> >On 28.05.24 05:30, Chen, Hongzhan wrote:
> >>
> >>
> >>> -----Original Message-----
> >>> From: Tam=C3=A1s Pa=C3=A1l <paal.tam@gmail.com>
> >>> Sent: Monday, May 27, 2024 9:09 PM
> >>> To: xenomai <xenomai@lists.linux.dev>
> >>> Subject: rt_igc fails to bing an i225-V Ethernet device
> >>>
> >>> Dear All,
> >>>
> >>> I am experimenting an Intel NUC 12 Pro small PC (NUC12WSHi3). It has
> >>> an Intel i225-V Ethernet controller, that works fine under Linux, but
> >>> I cannot make it work via Xenomai (Cobalt core).
> >>>
> >>> I downloaded the latest Xenomai-master tree, and the
> >>> v6.8-dovetail-rebase kernel tree. The building procedure went well.
> >>> Xenomai also working as expected.
> >>>
> >>> This is the i225-V device in the system (the result of lspci -v comma=
nd):
> >>>
> >>> 72:00.0 Ethernet controller: Intel Corporation Ethernet Controller
> >>> I225-V (rev 03)
> >>> Subsystem: Intel Corporation Ethernet Controller I225-V
> >>> Flags: fast devsel, IRQ 16, IOMMU group 16
> >>> Memory at 84200000 (32-bit, non-prefetchable) [size=3D1M]
> >>> Memory at 84300000 (32-bit, non-prefetchable) [size=3D16K]
> >>> Capabilities: [40] Power Management version 3
> >>> Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable+ 64bit+
> >>> Capabilities: [70] MSI-X: Enable- Count=3D5 Masked-
> >>> Capabilities: [a0] Express Endpoint, MSI 00
> >>> Capabilities: [100] Advanced Error Reporting
> >>> Capabilities: [140] Device Serial Number 48-21-0b-ff-ff-5f-cf-d2
> >>> Capabilities: [1c0] Latency Tolerance Reporting
> >>> Capabilities: [1f0] Precision Time Measurement
> >>> Capabilities: [1e0] L1 PM Substates
> >>> Kernel modules: igc, rt_igc
> >>>
> >>> This is my init script:
> >>>
> >>> #!/bin/bash
> >>> ifconfig enp114s0 down
> >>> #remove the device first
> >>> echo "0000:72:00.0" > /sys/bus/pci/drivers/igc/unbind
> >>> rmmod igc
> >>> modprobe rtnet
> >>> modprobe rtpacket
> >>> modprobe rt_igc
> >>> echo "0000:72:00.0" > /sys/bus/pci/drivers/rt_igc/bind
> >>> sleep 1
> >>> /usr/xenomai/sbin/rtifconfig rteth0 up
> >>> /usr/xenomai/sbin/rtifconfig -a
> >>>
> >>> This is what I see on the console (line 9 is the echo command for rt_=
igc) :
> >>>
> >>> ./start_rtnet_intel: line 9: echo: write error: No such file or direc=
tory
> >>> ioctl: No such device
> >>>
> >>>
> >>> These two lines appear in dmesg:
> >>>
> >>> [   25.325872] igc 0000:72:00.0 enp114s0: PHC removed
> >>> [   25.389790] rt_igc: probe of 0000:72:00.0 failed with error -2
> >>
> >> According to the error number, if it equal to IGC_ERR_PHY,  there shou=
ld be
> >something
> >> wrong with phy init.
> >>
> >
> >Is the rt_igc code base we have sufficiently recent for this NIC generat=
ion?
>
> No, I just ported from one specific Linux-dovetail version which was upda=
ted at that time when I was trying to implement rt_igc
>
> Regards
>
> Hongzhan Chen
> >
> >Jan
> >
> >--
> >Siemens AG, Technology
> >Linux Expert Center
>
