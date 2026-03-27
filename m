Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4D237E2F9
	for <xenomai@lists.linux.dev>; Fri, 27 Mar 2026 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601814; cv=none; b=Ywi7znNJqgbJVgMjxUwDg6XokSKuUTrF2KjGBm3CIM0MEMXAUv+XMsxrvN48IJhwL9pNIg/wsJxI92SH5LoZjx3UYxs6SKMfcqCGmNSqGb6fhhhzs69fXPg7WWLX6WbpTsSGd92G16Bjawyj6oEZ0t/4wXQ6AEPKDpj5loMH4pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601814; c=relaxed/simple;
	bh=3rqLVrRptulJLElOEyRKUOocOimlauwfDguFOEcNWaA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=amlyhZY9FTRAikAmUNkf+Z1+YgHv9yxQnCR5+PpBg1X+pRGMeqfmm8rJVaqhp9AHBQKJDCy4kWzctfL1wpbEtb32ZdNXsYZO1rJpfxQTp/gXpzukJGbWGFUi3J/ec581QV+bbtNXyP1okKM0/veFMb5eCG77FqyP/rgjtvnDI9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=cXWgrit6; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="cXWgrit6"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260327085645f5593d845d000207c5
        for <xenomai@lists.linux.dev>;
        Fri, 27 Mar 2026 09:56:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3rqLVrRptulJLElOEyRKUOocOimlauwfDguFOEcNWaA=;
 b=cXWgrit6Uh4VPP7nKO6VhheI9dnPt+PZXig39kFlRIB+SOvH5YZ0IMd4OmKbBP1IGHQusu
 /G+ArPSgvUM+xfEXXzGVW5Q7wr4l/E8LVkmVzKTT+dDNHbbmJP6LfyVoe9aGosyKuWAd/DzA
 ZLu9PhdOH5/7PJ01SNYZebdo9Dt22aNAWYKvR6KvoQpaN7AYZAnDcnbI1Uvy9PczlQUcqQWg
 9Vu4kBBjsL64kKSTF6/1NnWTpNG6qyGB2ahrDwd6utiZ9a6dXnebplRiw9ZxyMISdKEiDo/6
 U7MiF2aAhNNwS6mVizKKWxa4/ASYqGTrnxFRA6XQxD02fnirOUXD25rQ==;
Message-ID: <f554369e86fbe5c84f8a663456629ed28256677e.camel@siemens.com>
Subject: Re: [PATCH linux-evl v2 0/2] Add RISC-V support to EVL
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
Date: Fri, 27 Mar 2026 09:56:45 +0100
In-Reply-To: <926a16df-6114-4fdc-b2d7-70eb66eb9db1@siemens.com>
References: <20260320214149.2211433-1-tobias.schaffner@siemens.com>
	 <926a16df-6114-4fdc-b2d7-70eb66eb9db1@siemens.com>
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

On Fri, 2026-03-20 at 23:31 +0100, Tobias Schaffner wrote:
> Hi all!
>=20
> Some additional notes on this patch set:
>=20
> This has been tested together with the underlying v5 version of the=20
> RISC-V Dovetail patches in QEMU, as well as on the StarFive VisionFive 2=
=20
> board.

All the relevant debug options (PROVE_LOCKING and friends) were enabled?
No fallouts during the load tests?

>=20
> These tests were done in my home lab, but I plan to integrate one of my=
=20
> boards into the Xenomai-images lab next week.

Looking forward to that. If we can't run tests on that platform it's
close to impossible to guarantee that this arch keeps working as
expected.


Best regards,
Florian
