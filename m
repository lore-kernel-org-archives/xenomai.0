Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7748D20ED
	for <xenomai@lists.linux.dev>; Wed, 15 Jan 2025 02:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736908349; cv=none; b=SjgA95K3p9b6DeHC3vAx7TNGAsFoRyfWdwyqjIkU5vTpwuAL6PXX49cvtL0i1vU3yvryKvecSVhdEaMW7tAhe2D30/FKCERIR9qpslgud5brSa6dvFkWeWcyCovGKvNXiFJxcXBYlW3rMEbjI4MrpmhdvjlH4eGTIZKEUt3NfFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736908349; c=relaxed/simple;
	bh=bS/cKpYe9PlBCi8WJzamz7Fto7r53CMU36RLc0/2PKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=cGjjwCU+pg0f0yXakesRHjudFTwqC3Bxa1RJIujcvzC7QXUVk643HW2WUM/kgLH33X5qLk2yYLcCGSv5ewKqsnkPxdRyZSI+VN9DhjrtZuzM68f2FGS71lyHSG/w8NVJAYUNBIkffm07vtTx+Nh8eBsONRbIpIcrXdTvk9sOzdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyePForK; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyePForK"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb9a0a2089so3166315b6e.1
        for <xenomai@lists.linux.dev>; Tue, 14 Jan 2025 18:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736908345; x=1737513145; darn=lists.linux.dev;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS/cKpYe9PlBCi8WJzamz7Fto7r53CMU36RLc0/2PKc=;
        b=XyePForK9gqL76pa2EvYJZRePF1kRUlVt5W8SWwm3Tp6r0L9NkONPxkO/QnxdOSRy0
         cg4w6o36bM3ReV2CiuCSRLVZmTUPmZumh5rNrUF+ckXqSpaHqlyjCMaLEBH9Mmoda/NL
         sIhh+6++zl6mbBrWLoEj7TVJqVsDXW3Zh6Gm3sTGJTrrIrOm/gGU2Wah1yg5OSM9SrES
         XmKfk5GGPAdjXPykFe8q0ywBA6E6pd9RDQSsA23MrTEnWbO+KLsGrWAnRxZmXlkH+J/F
         toe0/vpmJ1EavDSUhs1oMT5U9iFnDZe9fgX1zLbVLigwQTz90M9BWn28bqCMMj8R/gW6
         RMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736908345; x=1737513145;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bS/cKpYe9PlBCi8WJzamz7Fto7r53CMU36RLc0/2PKc=;
        b=sJPSneXy0h7cV2YJHvLrauVFzf1Wv25FIM16BqIWl0cgzePnWDNvtkQ7S0IV53X+7N
         iywgy3VGbnAR/TL4i3ysOSj/m4cnWNYkctitEQ24J0dIxBEDkEnHLMI6Psq9mIy1I4Jt
         MS1b8/aVX9Ndsi3ecKge6i+H5/PEiv7k7XM9oiZOp6lE/HP4GxKuPnFSbHUC7O9xMt6t
         duZj5cB5HcSZDWTLnl/hazutW1Q5KXvih+kMOLu59MOkOcAgIN7XME+05BPklKK9q/LS
         Jo5NRURH40maOUUpCaJcbKMVXCNtghkt6FSird7ZZKC9a+7uSlLdRSDOFpUC0nGD0Zjl
         EAWg==
X-Gm-Message-State: AOJu0YwlDBDAvqnq1VfFeu7S4ASZRXTF2AbHXinLYf5Rt/pwH1FOF7SV
	+z0Ryytna1gKxbWttXLy36ANcv0PZlz76AaleunyM1QBwy+U+kkae0uPXt2XIN0+rLk95AMwWbH
	6SldRrBJYjT/eSLo1GDPtTrUlLp2XNA==
X-Gm-Gg: ASbGncvrVJ7yHknBt4ikr3j5t7CTSVNwqx7UZlITqvr8BnDbir6uma4izOg3nQYo6k8
	02+5K5iDvxNylNDGALS5rFKsWgbj93jsrkwss0w==
X-Google-Smtp-Source: AGHT+IE1PCr7WgENqBjbTaoOQ3h7IhuHCAQIgCsK5x+OJpqC5B+P8El1AjqpfqHxCBHvfbqtj+OYmoKLGGJABRAumsE=
X-Received: by 2002:a05:6808:2f11:b0:3eb:58b5:85fa with SMTP id
 5614622812f47-3ef2ed3effdmr16669479b6e.33.1736908345260; Tue, 14 Jan 2025
 18:32:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CABnSPHZg11FCXDwap0+=Q-QwizS0MwALuQg2bR9ndy1fBVCi2A@mail.gmail.com>
 <87plkpxx9y.fsf@xenomai.org> <CABnSPHYO_cMG_3uGKnmd6cPtom9jFDrMcutE+JBqfdEHk4ay_w@mail.gmail.com>
In-Reply-To: <CABnSPHYO_cMG_3uGKnmd6cPtom9jFDrMcutE+JBqfdEHk4ay_w@mail.gmail.com>
From: Nan Chow <morthlee@gmail.com>
Date: Wed, 15 Jan 2025 10:31:58 +0800
X-Gm-Features: AbW1kvaCApik5IZo3Osp0S9cOac_qG1SAb1EEFqfnZXpf5vqQdLFNvmNjkZNQYQ
Message-ID: <CABnSPHYivXcQUdGTyqOS=k=Axjax9K2SMUY6L8=Yw=HjiRsAqg@mail.gmail.com>
Subject: =?UTF-8?Q?Fwd=3A_=2Fsys=2Fclass=2Fevl=2Fnet=2Fvlans=3A_No_such_file_or_direc?=
	=?UTF-8?Q?tory=E2=80=9D_on_rpi4b_using_evl?=
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Nan Chow <morthlee@gmail.com>
Date: 2025=E5=B9=B41=E6=9C=8815=E6=97=A5=E5=91=A8=E4=B8=89 10:29
Subject: Re: /sys/class/evl/net/vlans: No such file or directory=E2=80=9D o=
n
rpi4b using evl
To: Philippe Gerum <rpm@xenomai.org>


Hi Philippe,

Thanks for your help. /sys is mounted, but /sys/class/evl/net is not
presented. I have enabled CONFIG_EVL_NET=3Dy.

I also tested other branches (6.6.41), but HDMI does not work in this branc=
h

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
