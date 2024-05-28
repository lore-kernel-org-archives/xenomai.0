Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F2313FEE
	for <xenomai@lists.linux.dev>; Tue, 28 May 2024 07:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879612; cv=none; b=HwXOG/s/OojB5iljAwVGvRD+ucuzeSBE26eZsvD6/bB/txjIARJly+XxxEXUXVPHRXQ3Y4m/gUQACvIbztmcgmc33+MssZP0lGi74ZDSIqXDcXPcp/8nPfZXFUgaLRFcHcIo/Pk5nUYDd5AwIhMwLKiZK8hCf0rwvceFobULKjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879612; c=relaxed/simple;
	bh=iFbiR58KaZFH79B24pI4BU0dE0pN6R2aI6we0j7QT9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n3Gi/zg7SUv5r/lGGvyXGmzADc9lucHCBkd8OwSQr40VLh6rjYHQZhMfFtL8HoDQRFU/LAlPPMIqLGjwnLgv15d90jlGrBJTukNI4VPxBXOoG+WgY9UVHtq7gUU88i9gjMB+rDRs3YGWT+7YDdwpZ500FJPlwDtQfS9jAaHiQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDlI85An; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDlI85An"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2bff7b9503aso341294a91.1
        for <xenomai@lists.linux.dev>; Tue, 28 May 2024 00:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716879610; x=1717484410; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JItbsAIaylSpBzTuVu/1LWuvr0LMik1rRtVvEgb0O/k=;
        b=cDlI85AnXAqYGXp+mkKk/FTzOzk28npFczYUks4O/WAawXfhhraPWXDimHg264HZRx
         oQUsHDEibh8f/+iUJD/CvV5aMl6iAC0GnR9dOWIL9kfo8/OtU/QTFyZ7ojHPc9+nzBWw
         UVnorPYhyulXxnHQLf8KrpWn610c4WzXtgXnzm5w5qB/ypN+hEsetcEvgCyUl4tkLgKS
         tUWnDJEL48pkzS4V8GOqWQbSlXgokN1UG+xgvHHKbfo0GExNzCn3JRv2+TDhYbjJgzrO
         Kq2SI0S/fMFoG1XLXDjJa9041pKJC4EsfMLj2k8qU4vz1Mu76fFIkZ5T3Zl2A0tNm0Ni
         WeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716879610; x=1717484410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JItbsAIaylSpBzTuVu/1LWuvr0LMik1rRtVvEgb0O/k=;
        b=NHSPYIwOT2qR9Dt3aDMUdUkKqYKtxvTeQXkgDV64Obf7FBxsZJFtwiwhNGp8QSJNQm
         hc0u5NWGJLF0ANILldBVHfIPw2AAM1yK3Z4winW6GexOWDF1e73AEQ2c+lET3MnQFKue
         BRI62zV3pbh42LYWPBduS/A+j0R0zApm2SR4VcIUVZBjIpeJ+8Yi4SPqIXIfCWZeN6J8
         wruq4Yy2wtIqmfitgjDVNUNszmpcX2F2RrTAwn/B+UeWVavB5f6ycYkg2EoPSnR8FJru
         sMKNIdeS417tx4GMgRIh3zY6ZuVQzNOiBn4C1we4Sf7psYyg0O3ekQnH3zksb7isCbWt
         KwGw==
X-Forwarded-Encrypted: i=1; AJvYcCVdrNFATOAK+c4pfMNqeWzV1zlZCpzgdxrBLtGMAVpDaHY34PYMBXnGl4nj377Ecfqv/BYuoy0owlqVBKskEaqqOc9NLwOkQg==
X-Gm-Message-State: AOJu0YwIjjO2RDE8nBwbOwbqv6CgIlHivoPVSCEkOn76ItqPwkTXATG4
	BCOFaBVZ0k44GjtgZIWFfj58PifCAB3M58+g35ds/F0mqFqqnRPh4L4nkwSY6SDUPy5SDuAHsbI
	FQWqsyq3Ek+jA7AMVRIGIgFyJlvo=
X-Google-Smtp-Source: AGHT+IGhApeMcQtMsnc8PLF6UpfMIDR8FvJbly9+6Qx19VqkKB5A7lXUV8lqV84LYIDUZ6Sp8BhBx3VxigKeSTpdvKM=
X-Received: by 2002:a17:90b:3113:b0:2bd:f3ee:c903 with SMTP id
 98e67ed59e1d1-2bf5e0b818cmr11089448a91.0.1716879610016; Tue, 28 May 2024
 00:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAH0t8y01h5W8Hsa=xvUJCyQM5VeA8CSTftBvLYrzbzQHenv7zw@mail.gmail.com>
 <PH7PR11MB749952ADE786FE1D78EA1A91F2F12@PH7PR11MB7499.namprd11.prod.outlook.com>
 <5de1a72a-ce0c-492a-b5ba-5bdc659df4a7@siemens.com>
In-Reply-To: <5de1a72a-ce0c-492a-b5ba-5bdc659df4a7@siemens.com>
From: =?UTF-8?B?VGFtw6FzIFBhw6Fs?= <paal.tam@gmail.com>
Date: Tue, 28 May 2024 08:58:42 +0200
Message-ID: <CAH0t8y2+1w+4VKsJYRdEDrZoRiVmkVXT60qt3t5oOSsq7SoXbg@mail.gmail.com>
Subject: Re: rt_igc fails to bing an i225-V Ethernet device
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>, xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have an M2 size Ethernet card working in a different PC. It is also
an i225-V. It works fine in that other PC, but in this one it
generates the same error. The differences between the two cases I see
is the very high PCI slot number and the higher IRQ number with the
"IOMMU group" indication via lspci.

I tried to set the debug level other than zero in igc_main.c here:

module_param(debug, int, 0);

Numbers below 10 works only (other values generate compiler errors),
but no new kernel info appeared.

If it is a PHY error as the error code is -IGC_ERR_PHY, where should I
add debug prink to get closer to the problem?

Thank you,
Tamas

Jan Kiszka <jan.kiszka@siemens.com> ezt =C3=ADrta (id=C5=91pont: 2024. m=C3=
=A1j. 28., K, 7:22):
>
> On 28.05.24 05:30, Chen, Hongzhan wrote:
> >
> >
> >> -----Original Message-----
> >> From: Tam=C3=A1s Pa=C3=A1l <paal.tam@gmail.com>
> >> Sent: Monday, May 27, 2024 9:09 PM
> >> To: xenomai <xenomai@lists.linux.dev>
> >> Subject: rt_igc fails to bing an i225-V Ethernet device
> >>
> >> Dear All,
> >>
> >> I am experimenting an Intel NUC 12 Pro small PC (NUC12WSHi3). It has
> >> an Intel i225-V Ethernet controller, that works fine under Linux, but
> >> I cannot make it work via Xenomai (Cobalt core).
> >>
> >> I downloaded the latest Xenomai-master tree, and the
> >> v6.8-dovetail-rebase kernel tree. The building procedure went well.
> >> Xenomai also working as expected.
> >>
> >> This is the i225-V device in the system (the result of lspci -v comman=
d):
> >>
> >> 72:00.0 Ethernet controller: Intel Corporation Ethernet Controller
> >> I225-V (rev 03)
> >> Subsystem: Intel Corporation Ethernet Controller I225-V
> >> Flags: fast devsel, IRQ 16, IOMMU group 16
> >> Memory at 84200000 (32-bit, non-prefetchable) [size=3D1M]
> >> Memory at 84300000 (32-bit, non-prefetchable) [size=3D16K]
> >> Capabilities: [40] Power Management version 3
> >> Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable+ 64bit+
> >> Capabilities: [70] MSI-X: Enable- Count=3D5 Masked-
> >> Capabilities: [a0] Express Endpoint, MSI 00
> >> Capabilities: [100] Advanced Error Reporting
> >> Capabilities: [140] Device Serial Number 48-21-0b-ff-ff-5f-cf-d2
> >> Capabilities: [1c0] Latency Tolerance Reporting
> >> Capabilities: [1f0] Precision Time Measurement
> >> Capabilities: [1e0] L1 PM Substates
> >> Kernel modules: igc, rt_igc
> >>
> >> This is my init script:
> >>
> >> #!/bin/bash
> >> ifconfig enp114s0 down
> >> #remove the device first
> >> echo "0000:72:00.0" > /sys/bus/pci/drivers/igc/unbind
> >> rmmod igc
> >> modprobe rtnet
> >> modprobe rtpacket
> >> modprobe rt_igc
> >> echo "0000:72:00.0" > /sys/bus/pci/drivers/rt_igc/bind
> >> sleep 1
> >> /usr/xenomai/sbin/rtifconfig rteth0 up
> >> /usr/xenomai/sbin/rtifconfig -a
> >>
> >> This is what I see on the console (line 9 is the echo command for rt_i=
gc) :
> >>
> >> ./start_rtnet_intel: line 9: echo: write error: No such file or direct=
ory
> >> ioctl: No such device
> >>
> >>
> >> These two lines appear in dmesg:
> >>
> >> [   25.325872] igc 0000:72:00.0 enp114s0: PHC removed
> >> [   25.389790] rt_igc: probe of 0000:72:00.0 failed with error -2
> >
> > According to the error number, if it equal to IGC_ERR_PHY,  there shoul=
d be something
> > wrong with phy init.
> >
>
> Is the rt_igc code base we have sufficiently recent for this NIC generati=
on?
>
> Jan
>
> --
> Siemens AG, Technology
> Linux Expert Center
>
