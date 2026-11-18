Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003524;
	b=ROyDvG2NI/IFSgkYcMZSF1s9avd7xken9FKBuUwc2KY1jCjA7nINGWr9fyDQ4O6FIqwo
	 2GayWe+E8HG6ZmgLjsL9+Uq3YF9kG/nrT9XVJ10tUR4YFDY0DSw3Cyx/V1cQKLQpPCkat
	 E6xI0Gn44p4cmjb66531tgnNsRJ9Eqppr0dM4jpwMnTXJLEsehyPimi5Ba5eml2SMc1aU
	 dqLpi5HkHbl//Pc1gFqN9t7HTaiYJ2J0nXS0ctT37fDcjzrNYBDHwKJgmtuKEWhxEkivS
	 1ws6U+j8M43NXH91SJBmuqAQC1niUPTDCUnc44RddyT/yfxOjzOvvP1GAn5pkovvMAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003524;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=dMtsIRsBQERGcTADstR7B9li+Alae8BrJ9pKXayWUFs=;
	b=hdwekxyKgTpIrUbYsmz1rX70KCEPeQTZfzKA2qxBvW/TNhOdtCwSHESesEnjBMHZKcaP
	 t43m00HRIoGWn5GkW/cCUuspzn/brlveEAcei4g0glo9je8rNni2f3xr7j1cNPNJdJ5R2
	 9Tqo4Wi+tlTyrKCrmITcYZGmhgMOg23SF2iLrkX2h3+KDrWN8YJZFCSE3SZ5lVKdi3StS
	 MHYrL7zOLEaNpw4kgmFEL23DOj1Qa3Gy0mp2Q34h3I7jgu/M2jefGmXAdW9Ce/bszSpVO
	 7tzd4fbi9BLbBNXgqgrYaljQnnidW4GO+OWeXhOO/bUpJY67B6wVVWbKj0hlCqH4irQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=Nmve1KLC;
	arc=none smtp.remote-ip=185.136.64.228
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6123606A31C
	for <xenomai@lists.linux.dev>; Wed, 18 Nov 2026 12:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6123606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=Nmve1KLC
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20261118120515903ccbddbd000207cf
        for <xenomai@lists.linux.dev>;
        Wed, 18 Nov 2026 13:05:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=dMtsIRsBQERGcTADstR7B9li+Alae8BrJ9pKXayWUFs=;
 b=Nmve1KLClMxmLj59g2j3/A/VO/eRdglzNtC4c41LqC/chxwsx/Wc94DvQh0IxrfmnPvHPh
 N/Kz/7QzWULCJGy5mn3JIK4vn78akVE85yMczz2Eu9NruYVFPhxF1rywh30F420MkgCDikNl
 oJZLXV3xdFDPRtiJ1TUxwmWmy5/rzNthhCUXK9KZYc4Oy70mCCqdzbEliJZv6qpoIT0N5nHk
 HZk/FNpQoq+Loc06HQMhiFc1fBOwA86HwWEMOZXdJIiecOn6TlatcHjfCHoJJhPIvhAwK4kP
 zb6Uz/redRzasBV+wMNoCdxx6KpyCk04VBhTotOcCOxbfnWSqIq6qGfg==;
Message-ID: <a63ac0285f72b17aaa1dad38853c8840a962f829.camel@siemens.com>
Subject: Re: [PATCH 5/5] testsuite/smokey: Fix unused variable warnings with
 GCC 16
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Yegor Yefremov <yegorslists@googlemail.com>, xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Date: Wed, 18 Nov 2026 13:05:15 +0100
In-Reply-To: <20261118114909.3030884-6-yegorslists@googlemail.com>
References: <20261118114909.3030884-1-yegorslists@googlemail.com>
	 <20261118114909.3030884-6-yegorslists@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2026-11-18 at 12:49 +0100, Yegor Yefremov wrote:
> GCC 16 now warns about variables that are only incremented, which
> breaks the build of the pSOS and VxWorks tests due to -Werror:
>=20
>   task-2.c:19:42: error: variable 'count' set but not used [-Werror=3Dunu=
sed-but-set-variable=3D]
>   rn-1.c:15:22: error: variable 'alloc_size' set but not used [-Werror=3D=
unused-but-set-variable=3D]
>   rn-1.c:16:18: error: variable 'n' set but not used [-Werror=3Dunused-bu=
t-set-variable=3D]
>=20
> In task-2, count only makes the background task busy-wait. Making it
> volatile is not enough, as GCC 16 still warns about it, so drop it and
> use compiler_barrier() in the loop instead, as the Alchemy task-2 test
> does. In rn-1, alloc_size and n are not needed, so drop them.
>=20
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
> ---
>  testsuite/smokey/psostests/rn-1.c      | 7 +++----
>  testsuite/smokey/psostests/task-2.c    | 5 +++--
>  testsuite/smokey/vxworkstests/task-2.c | 5 +++--
>  3 files changed, 9 insertions(+), 8 deletions(-)
>=20

Already done. See commit 8e4c4e836f45ddf46a090abbeb76e0152a5dec93
