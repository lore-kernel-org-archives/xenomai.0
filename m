Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB0D19C55C
	for <xenomai@lists.linux.dev>; Thu, 31 Oct 2024 11:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373673; cv=none; b=lF3W5QPPSBFbLgrm8ldOdWtuWP+iECRbTUQxsOzCN04eyGbGve+3+GvIqIZmQP4tTaS8DaR6MNte588gu8PmkvB31buRBfABZdV4JzUmt3E9hVfXkjo43UFwNaYrTEqf7MbBNPaCrhGxQHcfZ92+SVts7FuOrFnf0xRinzQrDhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373673; c=relaxed/simple;
	bh=aBd7LlC5sUS7oQy9eMHW3h2z5dU5uOrL4NjlUItN0g0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jwom7TdPv21IoipqZppX9U2d+dMXE+c06b9pPzqnBP120QC1ysKKOiMkrKVetKAaKeNICgJEhV+Wpc3gNqSVvxn64HxiCSJxHdmd8FU7TXv7j6sgBOK2DSRJPXAvXHG2Sc8W0jt+deGWwFivJC1TAW8l9DuN3Q0jShsJyJqsA0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=A9M0vHy4; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="A9M0vHy4"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20241031111855f2d476f9a454b2a0aa
        for <xenomai@lists.linux.dev>;
        Thu, 31 Oct 2024 12:20:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=VeuidiYX73kJjclT5Ngt9yqH/wJSeONCempXJhRn7Ec=;
 b=A9M0vHy4usgd/G8R9irQVrH/iOKj7PKX9ibaEMJkNvmJ0fCWNW/g4kwV5JAGQQjgcQv4dq
 muTTPAw4Q6wS1YceLaK/sY5iP32Y8skdQ+Va9m1tlC2rZfRHk4f9kIyeEvsyPLcs4CyNNRya
 8YDqsU01stclh5bbC6L/41YthT/Nut2xiR7f0oyaM7TWPhMvbDxZbPHBdBNxTdfVVy07DUqJ
 W02mkmWn3qGeq9jEKG4pYXNRXAoO8kNXJvOZUT9y11rMfeiHqGJWQj8Yp+5VF6J8e2/e7FgX
 N3A3KZk1BxJaiobD4wjO+sHcQcYZEgGNgkJAX6thWu3o917eQhvb5Quw==;
Message-ID: <71139a9c193d776b890f11ebb01ae7a3e9dbd7bb.camel@siemens.com>
Subject: Re: hand up when boot
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: =?UTF-8?Q?=E5=AD=99=E6=B6=9B?= <suntaoworks@163.com>, 
	xenomai@lists.linux.dev
Date: Thu, 31 Oct 2024 12:18:55 +0100
In-Reply-To: <10a77915.2e93.192e07bd1d7.Coremail.suntaoworks@163.com>
References: <10a77915.2e93.192e07bd1d7.Coremail.suntaoworks@163.com>
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

On Thu, 2024-10-31 at 10:51 +0800, =E5=AD=99=E6=B6=9B wrote:
> dear all,I use linux kernel 5.15.36, xenomai 3.2.4, dovetail 5.15.9
> for zynq 7020 developing. when I open config_smp, it hands up when=C2=A0
> kernel boot.It's ok when i close config_smp or close=C2=A0
> config_xenomai.zynq 7020 uses arm A9 core,so i patch by=C2=A0
> --arch=3Darm.I can't find how to solve it,please help me.Thanks.

Hi,

was this mail/text translated with some online tool? I'm not sure if
I'm able to parse / understand it correctly.

Here comes a try:

Let's start with versions:
- Xenomai 3.2.4
- Dovetail 5.15.9
- Linux 5.15.36

What are you trying to boot up? Linux or Dovetail?

> It's OK when I close config_smp

"close" doesn't make sense here, maybe you mean "disable"? I also
assume that you are referring to the kernel configuration option
CONFIG_SMP.

> or config_xenomai

Another guess: You mean kernel configuration option CONFIG_XENOMAI.

> zynq 7020 uses arm A9 core

Seems to be an ARMv7, so 32 bit processor.


Summary:
You have problems booting up (Linux and/or Dovetail, still unclear)
with CONFIG_SMP and CONFIG_XENOMAI enabled at the same time while all
other combinations (especially CONFIG_SMP and !CONFIG_XENOMAI) work?

We are regularly testing the armv7 support on two machines
  - The beagle-bone-black (non SMP)
  - qemu (SMP)
so I'm quite sure that the SMP combination works. You might have to
find out if there is any difference in your setup / hardware.

Do you have any additional information available? A boot log taken from
a serial console might help to identify problems.

Best regards,
Florian


