Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13F3382
	for <xenomai@lists.linux.dev>; Tue, 14 Jan 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863232; cv=none; b=Xt21ZqMpmTPqqB8wmVj5iruQ2mwvKNfIK/vUNB0e/TWPPLfbZNQZdYj+8ywqq00qh/C7bDuEMhHv+Nc3aoLLWxh4y4buZvxfcdCBCcOuHawWdMgVk7TpBTSF4gXCaE31CkkyKjZukDvaicusHP16tJBj5bIssYuQFt840akL+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863232; c=relaxed/simple;
	bh=Dl0bHmkWUHTjYKV0rk1Ms1JmCJtXVeBmWG2P9Lxewsk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oLz7vk/AZvmM+OssvizSVnLbsPqumFoEKtRa2mD4hH9+bgmMj5nkQO5lk1HSTUj/Twcv6liC6Pjz08bJlD5FgipHNYfCvOJT/htPJIAXiWCyM3jpqAckS9Xa9cj8tDPknwnDbLXRUMRud71fHqp7vflxNyPUbzU9W64qKEaNivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xmn+gLb8; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xmn+gLb8"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71e3eb8d224so1436579a34.2
        for <xenomai@lists.linux.dev>; Tue, 14 Jan 2025 06:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736863229; x=1737468029; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dl0bHmkWUHTjYKV0rk1Ms1JmCJtXVeBmWG2P9Lxewsk=;
        b=Xmn+gLb8F5/S1WqGd6FyXALf19mu69KeYw0+owOh/RhNPazXCzwwO97nHfjOsACKqs
         fiB66QRkdageibiOVl9u01aaHqRjEKJBpYqM78qUHCIpRG2TFeVNpbagARJNO6uJqGIZ
         9opEdN0j035/IajWLTlkFoy02yYPn6Xasldxtc9Rw/ai9O47/LZtCEJPHXhKBFQ30vpC
         TfMrZWCPjr8JiGxqJ8MBhu4T3z8FGwQtomlmeyNKo1wpVDCY5FrMDVOLcLqxCtTP/3Br
         eH6LYjEm7tGA8XHThWhHayXrPjoBVe2B85jSkKI3qa9D6w+X4drzX2MhPHUf5kSA7pjD
         1lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736863229; x=1737468029;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dl0bHmkWUHTjYKV0rk1Ms1JmCJtXVeBmWG2P9Lxewsk=;
        b=li6mLbp+xrifMZDC5gqldARC0MEOCWRQ6lMXH//HSG86IQ2buK5GL3AXqLIOfYqyxp
         gasDVAG3pgs7DWafCmC6fQkfnTbL4HdXadfTPsH5eCuMXLxdGjXEPIxUdQIiIRVCR5Ri
         MjsUFs1ts0yiM3B8XI0PfbcZGV53R0eeFmeMlucl5UZRL+4+tuDj3NhWhWgL+t5Zbena
         twGYEshOHFhd8BR/+U8hediSqboTXCDl0zXlmuuwb9jaxHmxrXnyAPy8TT7pH1QGxbzi
         TJwJF2JtHlahO+t7xKexB4zjRbg+jF2DLv7VeoMh68q+w3b+HWV6VYMExS+ldkmN/xua
         4lPg==
X-Gm-Message-State: AOJu0YzHHqfZRCBgZs/YcvPr4r9msJPeu4X6utfoIfxVzPpnxM1O4SiK
	+J2dnDMweFq91ZeAK+9RNtOHxoAcXCDM74B9r2z4K8oPLUOgDDdcXg+sIuT5bCRrixrBnJ9Tqkf
	WwBoMYnpsl0DNP7pei0bz1ixD3jjAu+zd
X-Gm-Gg: ASbGncv6HvYRYJMaQ/1v6J2DhvMYzV8zQ2DydLWYwHmowSNOYSNkpu8pnA3BsfFkjmN
	EL4b96taXykT1asS4ISlSe+Ki7I6zIK2HRODRgQ==
X-Google-Smtp-Source: AGHT+IHIDCR79FrYy5pDny8UeqUiAScqiCGPqZXM94eHeh+hu46utlx5gstniFYfqIfmPAICGSKEK6ul6xvQ1dIitIY=
X-Received: by 2002:a05:6871:a0c8:b0:29d:c6ef:cf1d with SMTP id
 586e51a60fabf-2aa06549ec9mr12994195fac.7.1736863229404; Tue, 14 Jan 2025
 06:00:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Nan Chow <morthlee@gmail.com>
Date: Tue, 14 Jan 2025 22:00:03 +0800
X-Gm-Features: AbW1kvb11EhFZ8PZ9z2QUlwyoeJAPXwlgiDAJvTKYrdWHTNwfyhOVR8alUUogvs
Message-ID: <CABnSPHZg11FCXDwap0+=Q-QwizS0MwALuQg2bR9ndy1fBVCi2A@mail.gmail.com>
Subject: =?UTF-8?Q?=2Fsys=2Fclass=2Fevl=2Fnet=2Fvlans=3A_No_such_file_or_directory?=
	=?UTF-8?Q?=E2=80=9D_on_rpi4b_using_evl?=
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I am developing EtherCAT master based on EVL, and my target hardware
platform is Raspberry Pi 4b. I used the =E2=80=9Cvendor/rpi/v6.6.47=E2=80=
=9D branch
and successfully compiled the image and dtb files with oob network
enabled. Following the instructions in =E2=80=9CThe EVL network stack for t=
he
impatient=E2=80=9D, I could attach a VLAN device with tag 42 to the real
'eth0' device, and sssign an arbitrary address to that VLAN device,
and tell EVL that the VLAN device is an out-of-band networking port.
But, when I did the last step, =E2=80=9Cecho 42 > /sys/class/evl/net/vlans=
=E2=80=9D,
there was an error =E2=80=9C/sys/class/evl/net/vlans: No such file or
directory=E2=80=9D.

My question is, does the RPi4b support OOB real-time ethernet now? And
if so, what may be the reason for the error?

Thanks for any kind help!
