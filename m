Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F0D23F260
	for <xenomai@lists.linux.dev>; Wed, 15 Jan 2025 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736929970; cv=none; b=GGMimW7GS1vIQbAV1lQiiY2quf+uEdIlLAzGWVLDUyR7nZqHBYc4FoubBq8wKHMcYagaksvlgoBG5wLkLJ+o3KPDFuu4Tj2V73iKycmsHUB4mggCWBa6NHWCAKYntI6uWUrJYOyq644dQXncnmrSwrsOOfwCJOGSUvw9oB9dDj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736929970; c=relaxed/simple;
	bh=pjZFP0DxhorQNZThe2LX4j18nmodpjbClRehTUyZ0K0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BmBYZjT+OQ18ImJzrOto9n9Sv8eT/PPXtDOlHp0o+vK0OKQLAAKAeFAfO4scftgKDxBWOuSnrXYvowWr10hpXiOYTjjmR+kvg3+QFEfG8X6C5JE8zkIfx0zzbrdXDGpKgNLuOeBHjgZj4bglUdl9RCVMQGz+C0UhQgXBjM9njKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=JJywzrHh; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="JJywzrHh"
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9C3A20007;
	Wed, 15 Jan 2025 08:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1736929964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tKmPzg/5VMfTFXg8J3i3pO6Plz+m5W61Yi5IgfyFSrE=;
	b=JJywzrHhBk3oIXSJmqANKK94KhZi51Z5c0I2658OPNDEGidsoJFuM8/+vZu9Y0KuEtth8I
	mpmgnVzPHIpJ+fCoX9Z2Dl+0AdAnE/1Bb5e4laJqx/Putz00q2RfANeu3FhiaUki0MuWnL
	NKiH7ZKA/NX7QsAAwc/bKEOqzb6AU45L7T6gBFo7zvnDgbyTotLTEQtbtNjSfJVIXywFNX
	GDMd+X7bNqT+Fdchsfypz/ALM3UW4S0lwFvMshV39A9KooJVsI8EchdAnswjWzyUgcLfpA
	QJL96ae79tRNIhbfiIIZAGhk6fRGa14yw7gcFE8VEB8ghcL+ubC79lP2zarSPw==
From: Philippe Gerum <rpm@xenomai.org>
To: Nan Chow <morthlee@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Fwd: /sys/class/evl/net/vlans: No such file or =?utf-8?Q?dire?=
 =?utf-8?Q?ctory=E2=80=9D?= on
 rpi4b using evl
In-Reply-To: <CABnSPHYivXcQUdGTyqOS=k=Axjax9K2SMUY6L8=Yw=HjiRsAqg@mail.gmail.com>
	(Nan Chow's message of "Wed, 15 Jan 2025 10:31:58 +0800")
References: <CABnSPHZg11FCXDwap0+=Q-QwizS0MwALuQg2bR9ndy1fBVCi2A@mail.gmail.com>
	<87plkpxx9y.fsf@xenomai.org>
	<CABnSPHYO_cMG_3uGKnmd6cPtom9jFDrMcutE+JBqfdEHk4ay_w@mail.gmail.com>
	<CABnSPHYivXcQUdGTyqOS=k=Axjax9K2SMUY6L8=Yw=HjiRsAqg@mail.gmail.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 15 Jan 2025 09:32:40 +0100
Message-ID: <8734hka34n.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org

Nan Chow <morthlee@gmail.com> writes:

> ---------- Forwarded message ---------
> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Nan Chow <morthlee@gmail.com>
> Date: 2025=E5=B9=B41=E6=9C=8815=E6=97=A5=E5=91=A8=E4=B8=89 10:29
> Subject: Re: /sys/class/evl/net/vlans: No such file or directory=E2=80=9D=
 on
> rpi4b using evl
> To: Philippe Gerum <rpm@xenomai.org>
>
>
> Hi Philippe,
>
> Thanks for your help. /sys is mounted, but /sys/class/evl/net is not
> presented. I have enabled CONFIG_EVL_NET=3Dy.
>
> I also tested other branches (6.6.41), but HDMI does not work in this bra=
nch
>
> Philippe Gerum <rpm@xenomai.org> =E4=BA=8E2025=E5=B9=B41=E6=9C=8814=E6=97=
=A5=E5=91=A8=E4=BA=8C 22:53=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Nan Chow <morthlee@gmail.com> writes:
>>
>> > Hi all,
>> >
>> > I am developing EtherCAT master based on EVL, and my target hardware
>> > platform is Raspberry Pi 4b. I used the =E2=80=9Cvendor/rpi/v6.6.47=E2=
=80=9D branch
>> > and successfully compiled the image and dtb files with oob network
>> > enabled. Following the instructions in =E2=80=9CThe EVL network stack =
for the
>> > impatient=E2=80=9D, I could attach a VLAN device with tag 42 to the re=
al
>> > 'eth0' device, and sssign an arbitrary address to that VLAN device,
>> > and tell EVL that the VLAN device is an out-of-band networking port.
>> > But, when I did the last step, =E2=80=9Cecho 42 > /sys/class/evl/net/v=
lans=E2=80=9D,
>> > there was an error =E2=80=9C/sys/class/evl/net/vlans: No such file or
>> > directory=E2=80=9D.
>> >
>> > My question is, does the RPi4b support OOB real-time ethernet now? And
>>
>> Only partial support, see [1].
>>
>> > if so, what may be the reason for the error?
>> >
>> > Thanks for any kind help!
>>
>> 1) Is /sys mounted? 2) Which part of this path is not present (e.g. is
>> /sys/class/evl/net present)?
>>
>> [1]
>> https://v4.xenomai.org/dovetail/kernel-api/net/#dovetail-net-full-oob
>>
>> --
>> Philippe.

The reason is that such vendor-specific kernel tree is already severely
outdated since it has not been maintained. This was a quick port of evl
done a few months out of courtesy to help a user struggling with merge
issues when trying to rebase the evl tree on top of the Raspberry vendor
tree. I can see a truckload of important net-related commits missing
from it compared to evl upstream code for v6.6.y [1]. One of them moves
the /sys/devices/virtual/evl/control/vlans to /sys/class/evl/net/vlans,
hence the issue you mention.

At the very least, you should align v6.6-rpi-evl on v6.6.y-evl with
respect to dovetail+evl support. FWIW, the mainline kernel this project
is tracking boots the pi4b without any issue, we are exclusively using
such tree for developing evl.  Using the vendor kernel might only make
sense when support for some Raspberry-specific device is required, for
which no/incomplete driver is available from the mainline kernel.  This
said, even in that case, one would rather pull the missing code from the
vendor tree and merge it into one's own fork of the mainline evl kernel,
if possible.

[1] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/tree/v6.6.y-evl-reb=
ase?ref_type=3Dheads

--=20
Philippe.
