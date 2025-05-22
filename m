Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444C01EB5DC
	for <xenomai@lists.linux.dev>; Thu, 22 May 2025 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747950925; cv=none; b=IhdQszAGhpvzn6vPsn2neBahkFcShXbV6xFsHl9MRbsNa7ZB+Emgw3T80Lw9V/I1ftJpg0jj1Yd4ajQAkaTjZiOMTaUxqKLM1JcBU1Tqbz6aTvgc5xedKNxvMGybNtoc+Iwc7UrpNv6ju8PzIxEdnwGyYj+Z6I8C7rywb6tQWJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747950925; c=relaxed/simple;
	bh=b7a1yp4DkVW4/yD4cr0qNGmzKtZVMup9mz5fNz52dkQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Af3hhOI+VDmByWE0b6Qy/TDHmkGWqsTk4aIb9PUQmKqaDpgObqgr0w/RFU1qmPw/xogBkLGYbVaVRDTott/EXuUKUe3D13KONxtJ4HKrIzyX2NJtDtpJdmL3TobMAOz82wi8e9yXqIs1JQCeCfmk4BU+FTg81whZF2uCkKRfKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=DD4a19xH; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="DD4a19xH"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202505222155086fc842749926193f3f
        for <xenomai@lists.linux.dev>;
        Thu, 22 May 2025 23:55:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=zCfQ/ulG72Gbnr5qE18oyGHZHgl9iKY49+AyzbvNMMI=;
 b=DD4a19xHwxvKiPB1gMM04olnMLOznS+Ku23yQCPU67waOAjm9Z1fFsQGIjS9V0mL6qYdlm
 MI3mIBbD65WwdVJMdK/16UcFeeEnXyBrl+kGUt96evOE9G8AB31ymYFOl6874MbqFJJgMm7P
 +VxL7coZyqOljbuaTm94NKwmTjJFdPH3tNyUjWAFixOJhqEf9vC3V4yHMb2EGFohestywgxR
 +bJmtc/Zw/l9zIUWEcthlu6VCnZVJubNpFd0J75FacLwlPRl+tegZ3IGGxRNkQkRWuJWweit
 9Jk6FHv5vooogkASwz9MzT8SltRts+JSC7HLPRXxoqA1jjfaDOS2vuaA==;
Message-ID: <a8b12a956a438b7165dcfb5dd40293ecd43d4472.camel@siemens.com>
Subject: Re: Xenomai 3 and Linux Dovetail Compatibility Table
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Yann Le Chevoir <yann.lechevoir@cae.com>, Jan Kiszka	
 <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Date: Thu, 22 May 2025 23:55:07 +0200
In-Reply-To: <DB9PR09MB6032858C6B27EDD03E9A0DC88199A@DB9PR09MB6032.eurprd09.prod.outlook.com>
References: 
	<DB9PR09MB60325FCC7AEFE1880D9698EF81A62@DB9PR09MB6032.eurprd09.prod.outlook.com>
	 <DB9PR09MB6032B14E3FA653EB1FD4BDEC81A62@DB9PR09MB6032.eurprd09.prod.outlook.com>
	 <582f231a-3e17-4b4a-804e-7f43ebda3c48@siemens.com>
	 <DB9PR09MB6032858C6B27EDD03E9A0DC88199A@DB9PR09MB6032.eurprd09.prod.outlook.com>
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

Hi Yann,

On Thu, 2025-05-22 at 18:08 +0000, Yann Le Chevoir wrote:
> Dear Jan, all,
>=20
> Thank you for your previous answer, it is always appreciated.
>=20
> I have started evaluating Xenomai 3.3 with Dovetail 6.6 (not what you rec=
ommended, but it was our starting point with the NXP kernel).
> The next step was to move to Kernel 6.12, as you suggested.
> Following that, I plan to evaluate Xenomai 4.
>=20
> Xenomai 3.3 with Dovetail 6.6 looks promising on our IMX8MP.
> I also wanted to test it on the IMX8QM. It boots and "works," but I reali=
zed that Dovetail 6.6 does not fully support the device tree for the IMX8QM=
 (no PCIe).
> The same issue exists with 6.12. It appears that support was merged in Do=
vetail 6.14.
> Unless I am mistaken about the support for IMX8QM in kernels 6.6 and 6.12=
, please correct me.

Two points:

- Be warned, we already discontinued maintenance for 6.6.
  We maintain 6.12, 6.1 and 5.10 for the time being.

- The board support / device tree is inherited from Linux. That's not=20
  dovetail specific. If the support was merged in 6.14 dovetail will
  support it within the same version.

>=20
> I need more guidance on the Xenomai philosophy.
>=20
> In the past, with I-Pipe, I applied the patch to our NXP kernel. I did no=
t use the Xenomai fork but rather the NXP fork with the I-Pipe patch applie=
d.
> I am wondering: instead of using Dovetail, could I create a patch and app=
ly the Dovetail diff on top of the NXP fork? I haven't tried this yet and I=
 am wondering if the task would be insurmountable.
>=20

Doable, but maybe not that convenient. We do no longer offer that auto-
generated patch, but we maintain -rebase branches at [1] for every
release. You could fetch the patches from there.

Even better: Move away from maintaining / using vendor kernels. Push
everything upstream and with that allow us (dovetail) to inherit all
the bits within the next release cycle. That is obviously a long term
story and maybe out of your control.=20

> I am now attempting to get Dovetail 6.14 working to see how it goes. I wa=
nted to ask my question at the same time.
> Do you have any other suggestions for achieving full support for a recent=
 NXP evaluation board when using a kernel from the Xenomai community?
>=20

We normally follow the Linux LTS model - keeping the last kernel
released in a year under maintenance. Means you might have to start
with a non LTS version (like 6.14) and migrate to the next LTS end of
the year - if you want / have to.

[1] https://source.denx.de/Xenomai/linux-dovetail

