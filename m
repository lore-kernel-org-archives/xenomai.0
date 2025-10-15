Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7120A1917FB
	for <xenomai@lists.linux.dev>; Wed, 15 Oct 2025 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512087; cv=none; b=qrT6TL4U2R/ayp1Nw7Wx/e6106A/ex9UwKmJ0alDvGbCeNslQe/XqpLOTQm2JTz15x+E0SYFB79D0OMbDoiVsdReQ8/+qklowzujaEjbiN1Ord41KwRNCd3uzUZm5gS+UYox+HOI/nz20r1Udh2Z1urgKlytFYTLPR4JIQiSMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512087; c=relaxed/simple;
	bh=aHqf+ePHR6wApLTtrGepgeX1ByJYVLOxjZLXzupyE4U=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=piud1ooog/O8ftAE5wSSxVDzudUYEi3P9UnxxY7vAMT5wZpQnwc7INTBzqEoUWn25zxFpIwXXKg10qPJO9VUNc0Uu296BZGzXmkUv9oeIlhhqpJaxBuPUFxIcOqoQlATC3qweIsqHjm8vX99Df8X9bvhwTT2IHncixUe/5uN2Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=QhfN/I8y; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="QhfN/I8y"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20251015070753ad2040276e0002074f
        for <xenomai@lists.linux.dev>;
        Wed, 15 Oct 2025 09:07:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=aHqf+ePHR6wApLTtrGepgeX1ByJYVLOxjZLXzupyE4U=;
 b=QhfN/I8y8YnkwjQvoUn6ES2I1vaoCz71DtVz17zN/1G5oliHIpBtQIBgs2PSDNQiMOUcqD
 IeN3gG7+tvhfjLSnn4rExOOJ9hEVF7jKf/w3cmPh9flQ/ZyJlnR3bumm4yQvQ8eEpYxH+08d
 Cm5uDpM5MGC6wzIDjBx1drZcCgWhY1+Lvdx2YqkmoeW3sxswfndjez12c/iuJMY9Dj3lftQj
 OAbXzZ4ukjhatCJ9SDGPqHdvKiiMbQn9Ok8UvQWSFI0yCYLKSRESqXg5GZ1WKmxy4QA421NO
 DHbozjM3K01GNHVvQc8OypgtKaOdpqL7mx/CsY8cWQzEXZSi89LMBGqw==;
Message-ID: <8ae5a640b977e3eb6b8cf684482e6b273171b356.camel@siemens.com>
Subject: Re: [PATCH 0/6] Fixes related to toolchain / libc update
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 15 Oct 2025 09:07:52 +0200
In-Reply-To: <cover.1760374860.git.jan.kiszka@siemens.com>
References: <cover.1760374860.git.jan.kiszka@siemens.com>
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

On Mon, 2025-10-13 at 19:00 +0200, Jan Kiszka wrote:
> Fixes that where found via the trixie update in xenomai-images and some
> cleanups. Most affect ARM 32-bit, the last one also 32-bit x86.
>=20
> While the patches do not change the ABI and would therefore be backport
> candiates, I will likely only pick patches 3 and 5 for stable.
>=20
> Which means that current stable versions of Xenomai should remain
> careful before updating their toolchains or libc versions for ARM and
> 32-bit x86.

Looking at patches 3 and 6, fixing problems in the low level syscall
entry path, I'm wondering if we should revive [1] instead. Basically
moving to libc syscall(), avoding the arch specific register dances in
Xenomai.

That would also help moving forward to prctl(), which has one blocking
point right now: The select() syscall has one argument to much.

evl does it the same way already...

There were some concerns about the additional function call, that would
require some more measurement first.

[1] https://lore.kernel.org/xenomai/68d9f583-59de-4bbf-8ea2-af8ece427495@si=
emens.com/T/#t

Florian
