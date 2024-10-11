Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8908620C48D
	for <xenomai@lists.linux.dev>; Fri, 11 Oct 2024 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637755; cv=none; b=DHZmOxXy5qHaovUYHrG/wWt3CXGFgWtNseipc+EvxQBJ4Q1h//omogRkH3WMOTpxk1VCt1fF/ijaGDaa8A+4ki7aYjUP8S/tevjyEypk4TD2Na1Kf1JMNow14/24gmkB5g+frHmJaRk0ulVXH0OegUZMpIjTDBCUn5kHCGk7tCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637755; c=relaxed/simple;
	bh=dSibSa9y92XO7M1m3ccoA7GjcOK460zSoONGzgnnXnE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uHnqCTXNhFfaKQXhgzinQW7mOL5se2LBpxOqZvdle22kDUdNnL4qEhpJPjld0NtwtcZ0SNj+LOqpDWjiJxFbXEBvrySUJh8cFnz/v1a9kjxQ0pdO0m50KdQ/NygrPBpAVlBXuVexhEh8Ia5Bxxnf4HA4qQ9QY/q4Tmu5GI/v0Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZsVr6LFX; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZsVr6LFX"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20241011082853c2ec4d0cfbb4907120
        for <xenomai@lists.linux.dev>;
        Fri, 11 Oct 2024 10:28:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=dSibSa9y92XO7M1m3ccoA7GjcOK460zSoONGzgnnXnE=;
 b=ZsVr6LFXCdUDM81/idP8iuSlRJfWCDRDNHkMk99tOGGYLUHYTieom2n+cT+l1sFBRcugoe
 k9JQYiYEx9+EabQs+sBOePZ/0tBqO/5cX0Mhs0n5T0LEEvrf7aPT2HI1KaTahBdO8tH3q4pi
 sKx4oDM0V5CVDxKVV3ZKE4EjQ/P+vYcXrZjSBiaVmUSNDsW7bx4gruglIWD8zGQ6QHuntJPq
 oMjuiZqW0E9vSRuQHbWVCHglYgKreDtLLZx4X45LBdSNC/DmCLHkt81UIhSScLGnfD74uhXN
 JX7UIyUbQ0/X+iiwMxxR2deFWCZMcuGil9ws78l3Gl56/kyVJhZc9wqQ==;
Message-ID: <0a1021c09d65013a3beeddaadceb788b82d0ed3e.camel@siemens.com>
Subject: Re: [PATCH v2 0/4] Preparations for Debian 13 / Trixie
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 11 Oct 2024 10:28:49 +0200
In-Reply-To: <0b6c56a6-40a2-46aa-9701-8688207591c9@siemens.com>
References: <20241011-flo-cleanup-y2038-v2-0-0ef0d52cf9c1@siemens.com>
	 <0b6c56a6-40a2-46aa-9701-8688207591c9@siemens.com>
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

On Fri, 2024-10-11 at 07:52 +0200, Jan Kiszka wrote:
> Thanks for addressing this. Just one question: Are there specific
> reasons to use different conditions for these different fixes? Can't we
> use the same across them all, to make things clearer?

Let me check that. Should be doable but some testing should prove that
I'm not mistaken. Waiting for test results, expect v3 soon.

>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

