Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA50232437
	for <xenomai@lists.linux.dev>; Tue, 14 Jan 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868117; cv=none; b=gYHuevE7G7EVTBg6ApmSQ+Ni5kmQ9WhBx7GFgYCLq7BsuUzlOvsz8H+q8QYTUt9eeUui8I1gmzmXAKiaw4Ti/4XXz2oDEBiraBhHdDXizKwERfv1bp0XE8FAOfEfQdfA6rqAx3+RLIAgd4rpWJtxkfVTkT56+WBw7TBBrvLxZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868117; c=relaxed/simple;
	bh=9R3rHtuFXyI3Sj81PEk9+Cl3yUWuDgrNFLAB9SMUSpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KebotFSLiqub/HoGgL4Y/QlkPwwt6c8MnpxilxMWsZjsi4hyDBzWNlmjlpJWBcUPkBSt7fbxpErkyJuUvNmqznrEVotCvAMdpZXbpghI2fgjETHF7w6CkvDV02FpWoq1TS/4MGf4D5ror9hFn0paAR0UJVG3T4P+36wimA2O4v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCzalzaI; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCzalzaI"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54024aa9febso4946712e87.1
        for <xenomai@lists.linux.dev>; Tue, 14 Jan 2025 07:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736868114; x=1737472914; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9R3rHtuFXyI3Sj81PEk9+Cl3yUWuDgrNFLAB9SMUSpU=;
        b=QCzalzaImP0O6/4w+45eEQHF3pJfEjVbty56suDSM0dlpMrGUMfuB8CqxsXi7WHG3H
         nEmX6JvJFS0dbgmlAID1wBEhwx7CB3wlGIX6qvcnNu/nqJFrcmW6aUBA94EJgMImKp+g
         RO0W+OcQ7sh5I4xSFr2vTmxU4FfP3hZ/ZOKoN6CGXQJBiOu3WBLQq+wB/LHTH/4ZvY1k
         t3WrA7Pq++jl5sOGq9kfH5A/3+3E19n0peC2Yj7DtguP0MyqDoWe3E2XqxdVn1o2cecg
         dS/ZbkNDaJ5cJAmnKNGVHX2Tlgr8WIoA5X+VUVSBTJCPNyhfJsdftzw28/7J/bOIGd0d
         m4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736868114; x=1737472914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9R3rHtuFXyI3Sj81PEk9+Cl3yUWuDgrNFLAB9SMUSpU=;
        b=r463Ktz+0kHo1cFKjNrkKMNfRkGsWTEUFKZ350D5WQTf7N75Aq8Rv/eQCp75cIiRIF
         57B5Zj/p6Dtap+SnbotXCNLNMTWaFLU1JB/t1AtOtkRQQwKI+llTOSVAD8vaOD7edLR4
         kqR7X1a7dTrTdgNQyCzcwUNsrsrIrJPDFJffNSoF3yhYQ3dd7SRpEkmF/bgcjbgUXmOb
         53iTKlNnMvuoBEug4OY+A6LsyOcRe6D01D0ya/uuJL8tlFe9HgzIeOlj7fNJXl6YE7+E
         rGEX9ko5eyE7mV2spiUes7AYMKx/UQPzLIt5TAEzmU+Ha2OUzUQxgn06b2cAncf4+Oyp
         K62g==
X-Gm-Message-State: AOJu0YzNceLAJ5rOquomGYo//H865eWQ+fhUQOqjlAilpXqYvtMFPb83
	N+37a9QM97+L3ajWyTOF4HBLIdxIwh4YbvXxQl+vlDhCOfohhFyzQILDCAtwB1iesAPrdTKORSh
	mnnc542MQVEhImIRgCs7jFSmah/421G23DwHUizc8
X-Gm-Gg: ASbGncs+gnNk6MjJb3Zc7jswOwnPD7xpTN+7TOcICobCkKCLI2CJcfGLPKD9u+BIwX8
	jb/L9xbIouUWX7enzPWr/nFikf/Y9bm7Rhx0j3Q==
X-Google-Smtp-Source: AGHT+IG7+K31k9Pr8Bbdt8ak3M/SnniWp6p/JBxZ4BvH0peblqLzKf0iSkkI/aKs2jp/tckCJBkpErWOXsbSbMtUJ8A=
X-Received: by 2002:a05:6512:2394:b0:540:2a15:9b5d with SMTP id
 2adb3069b0e04-54284801c47mr8731534e87.42.1736868113228; Tue, 14 Jan 2025
 07:21:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CABnSPHZg11FCXDwap0+=Q-QwizS0MwALuQg2bR9ndy1fBVCi2A@mail.gmail.com>
 <87plkpxx9y.fsf@xenomai.org>
In-Reply-To: <87plkpxx9y.fsf@xenomai.org>
From: Qichen Qiu <ruiqurm@gmail.com>
Date: Tue, 14 Jan 2025 23:21:40 +0800
X-Gm-Features: AbW1kvZaoaMfvb9MDMiAzLXY9i_TYP3WNW_sjM74JG8dBhVuNabueCaHPYPQqwU
Message-ID: <CAHR=ZXFO-zG8hyjpYFSQ3PmhQQt90LTF=p377TH2jaVZ3NuvmQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=2Fsys=2Fclass=2Fevl=2Fnet=2Fvlans=3A_No_such_file_or_direct?=
	=?UTF-8?Q?ory=E2=80=9D_on_rpi4b_using_evl?=
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Although the EtherCAT master supports VLAN, many EtherCAT slaves may
drop these frames. For example, we tested this with the LAN9255, though
we=E2=80=99re unsure about other EtherCAT slaves.

Would EVL consider directly supporting filtering based on the EtherCAT
 identifier? Specifically, when the receiver thread detects an Ethernet
frame with the identifier 0x88A4, it could treat it as an OOB
packet. When sending a packet, pass some flags so the OOB stack
won't attach anything to the original Ethercat packet.

Given the widespread use of EtherCAT in industrial applications with
Xenomai, this feature could be highly beneficial for developers who use
the user-space Ethercat driver, like SOEM.

Philippe Gerum <rpm@xenomai.org> =E4=BA=8E2025=E5=B9=B41=E6=9C=8814=E6=97=
=A5=E5=91=A8=E4=BA=8C 22:53=E5=86=99=E9=81=93=EF=BC=9A
>
> Nan Chow <morthlee@gmail.com> writes:
>
> > Hi all,
> >
> > I am developing EtherCAT master based on EVL, and my target hardware
> > platform is Raspberry Pi 4b. I used the =E2=80=9Cvendor/rpi/v6.6.47=E2=
=80=9D branch
> > and successfully compiled the image and dtb files with oob network
> > enabled. Following the instructions in =E2=80=9CThe EVL network stack f=
or the
> > impatient=E2=80=9D, I could attach a VLAN device with tag 42 to the rea=
l
> > 'eth0' device, and sssign an arbitrary address to that VLAN device,
> > and tell EVL that the VLAN device is an out-of-band networking port.
> > But, when I did the last step, =E2=80=9Cecho 42 > /sys/class/evl/net/vl=
ans=E2=80=9D,
> > there was an error =E2=80=9C/sys/class/evl/net/vlans: No such file or
> > directory=E2=80=9D.
> >
> > My question is, does the RPi4b support OOB real-time ethernet now? And
>
> Only partial support, see [1].
>
> > if so, what may be the reason for the error?
> >
> > Thanks for any kind help!
>
> 1) Is /sys mounted? 2) Which part of this path is not present (e.g. is
> /sys/class/evl/net present)?
>
> [1]
> https://v4.xenomai.org/dovetail/kernel-api/net/#dovetail-net-full-oob
>
> --
> Philippe.
>
