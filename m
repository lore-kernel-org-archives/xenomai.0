Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990952F0C6D
	for <xenomai@lists.linux.dev>; Thu,  4 Sep 2025 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978933; cv=none; b=YUAUKkFcxdSGHOv+O3npeOL+dYWe4yMFuRJfZct0rXhSvexDLyFipC+rzn06yKxYBTX9bSmB7MNioAF0YokPAiuvU+ScY5asdjeHPAbwikBxROmAzPEsMqKG34Dt6jj3IHvoeMfzci931D7TJawGIl/elX+R129VYCC1UPVIPjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978933; c=relaxed/simple;
	bh=94BHZ979tjhKD3lOPMpEOIVNp7NoyCeeH/S+s3O/HDs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UxHkOjQctFiKueCzzsKOxY2NgbLrdB2K6VmAEd0sSG4yKpST65fNKMRe47WGHDeg6mwNauoiOmvKTmEZZGqUsQ56iDIVnDvfoMcrExcic1b5K4ZJmC2pcPzX2GO708icmfxk39MnN8rPp5mZ0oaOI5mwLeudqZwSaUgmsoUMKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=jTPrk8Qd; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="jTPrk8Qd"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20250904094206cac3e48606000207c2
        for <xenomai@lists.linux.dev>;
        Thu, 04 Sep 2025 11:42:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=94BHZ979tjhKD3lOPMpEOIVNp7NoyCeeH/S+s3O/HDs=;
 b=jTPrk8QdunUp/I8GtdfkRqVdwlP682O7q43bCR/WayPGryTtyAuy/+31AhGOgmFz/qz45z
 X6OdE42YPo/tMXL2pgWFSZZr6QX1e2+UkdYF7oP68VY2fGS4k4i9Ds5cw0APTx6Sno4ItsGu
 w4yBEPW4XeaEnXTfk7cyoRuWIz0swBLXLRJ088L+NUT800xdPkGbA5m1l/i5095PfjjfDlaq
 rgPYsLclyJ7vusZrLa8Z/+HLZ1NcpcOg1ZTVFuyQYY4c04RD/hEH6V2YswQS55AjTWe/7mVa
 GaRsp9Z4kGQ+5J8QeaoMn+eChs6lhfp1BmRb+0gbeDp+rlydU6fnhfvw==;
Message-ID: <4ce03c2bc742b996718917fbc7872e341f0fb289.camel@siemens.com>
Subject: Re: [PATCH v2] ci: check the device health
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>, jan.kiszka@siemens.com,
 	xenomai@lists.linux.dev
Date: Thu, 04 Sep 2025 11:42:06 +0200
In-Reply-To: <20250904093014.2037482-1-Quirin.Gylstorff@siemens.com>
References: <20250904093014.2037482-1-Quirin.Gylstorff@siemens.com>
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

On Thu, 2025-09-04 at 11:29 +0200, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20
> Check the device health and the device state. If the device is not
> healthy or the state is not idle try for "WAIT_FOR_DEVICE_TIMEOUT"
> minutes until aborting the test.
>=20
> The default of the variable WAIT_FOR_DEVICE_TIMEOUT is 10.

Hm... Not sure if I understood the problem correctly.

Assuming Jan spawns ~5 or ~10 jobs for a specific device type when
pushing to one of the Xenomai 3 stable branches (or something else that
triggers a lot of test jobs):

- One job will get the device and will run
- remaining jobs will wait (and time out roughly at the same time)
- one of the remaining jobs will get the device and run
- all others will still fail

Correct?

Does that really help? Maybe one more successful task (when the timeout
was enough to wait for one test-run), yes, but is that enough?
