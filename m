Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404E43EF0A6
	for <xenomai@lists.linux.dev>; Fri,  8 May 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778250240; cv=none; b=UoyApyGoGUQ++TJn8a5dyU0e9b8hktOCZFOFTB2IIdR1xAtWpV3ehY0fcB4h2M31zUtIUz5xoBHQVxeO28Y6/R3VDITSYmKhel3qN6VGf06Jd9SqsXpeXtH6VxbW7LYuKPzVf0A+wZZPuja+V9m/9ioce7+9zfk8NkChHvy5yOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778250240; c=relaxed/simple;
	bh=4GmFbVnHqivRjkvM77uZL2weovYCT0UQAFu4WwqlA94=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bNGtzx0XsQlDj19IDnMznDM0q6igL4wE6HmR7iHBSjyQ4QZ3+Z/8FkZ3bSscGuFScHLKUmg4wd3RJIAk2G1/FvMQEOKOvgAcVavWgXG/GyLqaCkUNnajDcQpJk78PqdaATyyRTQ4mWE6k24FHD7wunS4F5HiqHnu1rYubxnFrE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=gH4BCkH3; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="gH4BCkH3"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260508142353925f68594d000207bd
        for <xenomai@lists.linux.dev>;
        Fri, 08 May 2026 16:23:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=4GmFbVnHqivRjkvM77uZL2weovYCT0UQAFu4WwqlA94=;
 b=gH4BCkH3ARVxjw0Qh/Z22SNbo1sIR0vgLfOo05tziwljInS9vXVYVnPAQaqGSPahw3pUUX
 pEpKVhoziOgR9f2EPrtnIloa4fp+YzmkeXmtQ7Z41luJ7bM3T1CYdvd0TnowpQ/YMRW4UBbl
 D8XXQL2XqHWEmttKGYn/PDZSmmUuUSUDBA+ng94xdu2nLWsV+Fbb7pduJQHf+dEM8Qq2eas4
 ct5Vid44yDlY1+QJj6Yff2yLYrLHmHJjeF25YOctQ9DEnb3ycwk3AJ3Ja9fftTuGMtpuAYD9
 ZGms/BuFgeKiFbO4HUrypySqsCcTr+7Q6T9C951o2DwWD9Gt13QcwOVw==;
Message-ID: <bc8ac763cd82eb8f2d2ab53efc0a7b0275ec2551.camel@siemens.com>
Subject: Re: [PATCH 00/32] lib: Finish rearrangement of includes and license
 headers
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 08 May 2026 16:23:51 +0200
In-Reply-To: <aca24e6a-977d-428d-b892-403852958a3f@siemens.com>
References: 
	<20260508-wip-flo-refactor-includes-v1-0-e449f2bd4fc2@siemens.com>
	 <aca24e6a-977d-428d-b892-403852958a3f@siemens.com>
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

On Fri, 2026-05-08 at 16:15 +0200, Jan Kiszka wrote:
> On 08.05.26 08:22, Florian Bezdeka wrote:
> > Hi all,
> >=20
> > This is the missing cleanup of demo/, lib/, testuite/ and utils/ that
> > was partially handled already in the past as preparation commits for
> > bugfixes or build optimizations. I finally found some time to finish
> > that work for the missing folders.
> >=20
> > There might be even more potential for cleanups inside the include/
> > directory - and as a result once again inside the already cleaned
> > directories. I skipped that for now, as I consider include/ as an API.
> > Changes might force users to adapt/recompile.
> >=20
> > Tested against Dovetail 7.0 already.
> >=20
>=20
> How did you retrieve the header needs and coverage again, manually,
> script-based or AI? And what do you suggest to maintain consistency in
> the future?
>=20

Sorry, forgot to mention that.

Formatting and sorting of includes: clang-format (with the option
enabled in the last patch)

Indexer: The indexer part of JetBrains Clion. Used to find and eliminate
unused includes. Followed by a manual compile to verify the result after
each compile unit.

No AI.

I haven't checked yet if there is any command line tool for identifying
unused includes yet. If so, we might be able to integrate something into
CI - on the long run.

For the formatting part clang-format is able to report differences - or
formatting violations. At the moment the code base is not ready for that
yet. Too much differences. Step by step.

> Jan
>=20
> --=20
> Siemens AG, Foundational Technologies
> Linux Expert Center
