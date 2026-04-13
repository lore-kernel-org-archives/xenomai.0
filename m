Received: from lithops.sigma-star.at (mailout.nod.at [116.203.167.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DEB313E15
	for <xenomai@lists.linux.dev>; Mon, 13 Apr 2026 20:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.167.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776111082; cv=none; b=AOkhHEzB4mAGxsWyk8R/OWqfJnPa/y3Lf1YMWiRTRUXp7N4z83d7i2WOf9g+UVgRLe/gu68GcAJkJQFeqKVs1WnwaSgjSpVoQudYEDL4PW3DwdbBpN4+vAWoTkFrkWKHGM2/CGAsRj2KT9usPfcK2LiIhqVB1wFHzS9O1XJdVIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776111082; c=relaxed/simple;
	bh=obCIfuvaApG+O6mxJf7MinFi2N33uf8/gbQTvOVzZb4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fXAfAoo6J6w7KAFF0dUgwekLMbvU2+CN93V7cHawDqRxLuE/7wbnVnJ5dXpjoSsG3ZUFysFnFVJDLKat+l0UXi0kiBBOx7AjDfJmnMx5rYAlsWf5k1Jd3mhe+ygooLMsasViVYJ/GhErQ20g07sexzHR0NPETTuhHi4gLUeTVbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=116.203.167.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B9E8C298599;
	Mon, 13 Apr 2026 22:11:10 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id GPb0jOE-9bp5; Mon, 13 Apr 2026 22:11:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 4156629859E;
	Mon, 13 Apr 2026 22:11:10 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hQINzIM6tuNg; Mon, 13 Apr 2026 22:11:10 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1EBE1298599;
	Mon, 13 Apr 2026 22:11:10 +0200 (CEST)
Date: Mon, 13 Apr 2026 22:11:09 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>, 
	upstream+xenomai <upstream+xenomai@sigma-star.at>
Message-ID: <946371069.54252.1776111069832.JavaMail.zimbra@nod.at>
In-Reply-To: <af74e234-327a-4b59-a33d-8d817e34eaec@siemens.com>
References: <20260412073425.956320-1-richard@nod.at> <af74e234-327a-4b59-a33d-8d817e34eaec@siemens.com>
Subject: Re: [PATCH] xnsynch_requeue_sleeper: Return early when
 !XNSYNCH_PRIO
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF149 (Linux)/8.8.12_GA_3809)
Thread-Topic: xnsynch_requeue_sleeper: Return early when !XNSYNCH_PRIO
Thread-Index: dQpLW5Pa4TNMPYmWpHcbkK0lirMDLw==

----- Urspr=C3=BCngliche Mail -----
> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
> But XNSYNCH_PI !=3D XNSYNCH_PRIO. PI implies PRIO, but if we enter under
> prio-ceiling conditions, we won't bail out here, and we won't get the
> BUG_ON anymore.
>=20
> Please check if you use prio-ceiling mutex instead what the behavior is.
> Add that to your test case as well.

With a prio-ceiling mutex I'm unable to trigger that code path.

This is my new (hopefully proper) test case:
https://gitlab.com/Xenomai/legacy/xenomai-hacker-space/-/commit/b35c9b37ab4=
beec5084aa8303d91fec2bf3b4eba

Thanks,
//richard
