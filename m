Received: from cczrelay01.in2p3.fr (cczrelay01.in2p3.fr [134.158.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131781F03C7
	for <xenomai@lists.linux.dev>; Fri, 30 May 2025 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.158.66.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748638311; cv=none; b=ACfmAGGapH+KuYM7+re34lfXhgeSoYgGNzbhYQxrIp6vY9s9eNlHYg73FEKxPiGVo1kYQLD1Jw8VMSnBdUMQ3vcMQ59PVDIwE1dzXrYiyI1RumjclZFKE/UBW9Gfj2ArMPdW2JCscv5GDF2W5QKhU+5f2pyppyMp9s9mSGjXeK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748638311; c=relaxed/simple;
	bh=WvG7Ie/b1B+6qQMmMpyvgkZLVVJrL0EF48C9g3Ss65Q=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g1xQf1dLkMlWYVCXqZPWYiVhSfSwQ76ZpJDdS/0KZh91n/JM53yH2z6jEJeeR790yOLSIhCvXR6acJ1PsqUCmZNgeN0BLVwlX6vRvis9buIv1hleVPHhliuT6ZxYZcMXSLcoqI2DaesgoJlW6VtgiTRNYr9Y+Mp1VHPtlPbKcQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lapp.in2p3.fr; spf=pass smtp.mailfrom=lapp.in2p3.fr; arc=none smtp.client-ip=134.158.66.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lapp.in2p3.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lapp.in2p3.fr
Received: from [192.168.0.68] (88-163-26-32.subs.proxad.net [88.163.26.32])
	(authenticated bits=0)
	by cczrelay01.in2p3.fr (8.14.4/8.14.4) with ESMTP id 54UKpawr009108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Fri, 30 May 2025 22:51:37 +0200
Message-ID: <d7232ade8a28894a536d697a40942416ff817550.camel@lapp.in2p3.fr>
Subject: Re: Port of a RTAI based code
From: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 30 May 2025 22:51:36 +0200
In-Reply-To: <5b7a4ded-2147-47c5-887b-c400694c9eec@siemens.com>
References: <1d29632f21dc51b0f1d5434b8ccd16239bb73c37.camel@lapp.in2p3.fr>
	 <5b7a4ded-2147-47c5-887b-c400694c9eec@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Jan,

Le vendredi 30 mai 2025 =C3=A0 09:55 +0200, Jan Kiszka a =C3=A9crit=C2=A0:
>=20
> > Would it be possible to obtain a similar behaviour using evl ? I unders=
tood
the user space processes will not be scheduled during the interrupt handler
execution. So I suppose I have split the interrupt handler and implement th=
e
process waking part in a kernel thread. But what would be the right approac=
h to
wake the user space processes from the kernel space ?
> >
>=20
>=20
> You will need to write an EVL kernel driver =20
>
([https://v4.xenomai.org/core/kernel-api/](https://v4.xenomai.org/core/kern=
el-api/)
) that implement some OOB read =20
> or ioctl which your EVL application can call. That driver will then =20
> block the application in the kernel using an in-kernel OOB mechanism - =
=20
> e.g.
[https://v4.xenomai.org/core/kernel-api/semaphore/](https://v4.xenomai.org/=
core/kernel-api/semaphore/)
. The driver also =20
> implements an OOB interrupt handler that will signal that evl semaphore =
=20
> (e.g.) and, thus, unblock the userspace thread.

Thanks for your message.

I don't understand the relationship between the user space semaphores and t=
he
kernel space ones. How can I map a evl_ksem to a evl_sem ? Is there an exam=
ple
code available ?

Emmanuel.
