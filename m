Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FD313D246
	for <xenomai@lists.linux.dev>; Thu, 23 May 2024 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716454020; cv=none; b=MuqOEuCzTGNq+Ti/+NlrwGqtR+v1Q4tKWgKxiUr47/QZkcqfT94bVoFKz/3ultDdwHY7GPrLaC/nKWdfa+qaCqyW4PV0cfbOwuz6/cL4MVv3bl2Zg94VmqJiArXfk1Sx2VDYxWammCgtMv18ik2rnHHUkrKr3LAFVAZQtkBnOj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716454020; c=relaxed/simple;
	bh=b2Pi8t1Or9vKzNUwEuvuVWNvi24qcosE+pAs4nCkrZA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t5YlzmY2Lf/MXbDlMnDj0JUbIFCq/3yGEXyoapHqtsWFWbDwDEMjHNepif35kJ6VMHmXCU4b0BQk4cGLYBEKVgDzMQtIG9TQZB4MdJav365Fhv9xX7Zo+hvZNmUQtKvTWuQvRT9m3ZnhZ1EOfHfof+SeYXIlJkZkGAEDC8LQEHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=pRRM7t29; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="pRRM7t29"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240523084645a7f0cc8286e2c5ee14
        for <xenomai@lists.linux.dev>;
        Thu, 23 May 2024 10:46:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=b2Pi8t1Or9vKzNUwEuvuVWNvi24qcosE+pAs4nCkrZA=;
 b=pRRM7t29RfyH6YPWesie+uV+CXWRDq9TrhovXxWTas7w3dbdQLk5qc1G3rRMTfXaKjerY9
 +SMr7pzXSTuCgpJpP3F7H7s3UPeA7MZEMJBKoSl/2YtFog4ct1q3TjCP1TooFJaRutJ3TZZ+
 Fxi3IVO8Cn4KnGWrGnAqrAv6aiZCA=;
Message-ID: <82b54361348112dc220d25db6c12f284898ddd2d.camel@siemens.com>
Subject: Re: [PATCH 2/3] rpi4: Add rpi4 (Raspberry Pi 4) as target platform
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "Jiang, Yi (T CED OES-DE)" <yi.jiang@siemens.com>, "Kiszka, Jan (T CED)"
 <jan.kiszka@siemens.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Date: Thu, 23 May 2024 10:46:44 +0200
In-Reply-To: <92eb843ac00112e48b460f6b87e4c615dc8fb943.camel@siemens.com>
References: <20240521134841.21749-1-yi.jiang@siemens.com>
	 <20240521134841.21749-2-yi.jiang@siemens.com>
	 <81ab4ff0-6eff-4944-83fe-336c965b9ed3@siemens.com>
	 <dafbc406f9f93c4a77d3e95fcd5f5d8fa2f792c5.camel@siemens.com>
	 <92eb843ac00112e48b460f6b87e4c615dc8fb943.camel@siemens.com>
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

On Wed, 2024-05-22 at 12:35 +0000, Jiang, Yi (T CED OES-DE) wrote:
> > Confused.
> >=20
> > - My original patch did not touch the arm64 defconfig.
> > =C2=A0 So I'm still listed as author ("From:" inside the body) but the
> > patch
> > =C2=A0 content is different.
> >=20
>=20
> Yes, we do not need to keep rpi4.cfg any more, because the original
> content of rpi4.cfg has been merged to arm64_defconfig.

If that really works (especially for the older ipipe kernels for
tersting xenomai stable branches) the patch needs some reworking.

Florian
