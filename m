Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51196201113
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680380; cv=none; b=VIxmt24Daspnmnaxne/tAcAHk0etUrZFDUxQQMTSIM8iq7os7B8yPWZrr/Ga4SjDlFaiOx9tP/IanI8+Q05cNVL6cxfshKcrWgKiGW5VgN/3ljdH7V9djyR2Fi2lC9x8/8JDvNzD7VAULncnX4tjhjlGiwjlgKVM0LAGEMOJxq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680380; c=relaxed/simple;
	bh=+12yAlf+5OfXlqEsJHnwY/cZKWSZsQkJtYgL2OVdXTU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G8bvFelB6hXjPnKQ5hKrKoqEOGuRg2iHwnU6OJvZvn3nn9gI280PY5pgHjsvqbBzvURgcsSo/yN23vtIboVCE50RBmkaHZk9pw9LBACKEi1rSmGNJIppGU76ccrVsCRNS+xNWbKguD4IjzW14ec+p5RFo9EmglI/BxqWl90vOw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ciRceBUk; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ciRceBUk"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026051313523052263584a700020712
        for <xenomai@lists.linux.dev>;
        Wed, 13 May 2026 15:52:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=+12yAlf+5OfXlqEsJHnwY/cZKWSZsQkJtYgL2OVdXTU=;
 b=ciRceBUkf+K85NBVgpuJjNsVyMRwXmSSbvOGwwoxvrvOoYz/12d++gBvFm81RCiLZmWZky
 V09JntVbB8xEqBAIXPhCGC2mp5gsMCXbHcp6DcQCUOc3CtJ/sELSUMoP87pNa7CG8Tup5JwP
 ZBareA+/1dyZ+3xFEn31eZ9vti0w4DCawPs0p4we0/tL9RmIwb/9bmUTZIpGhwyCtjAECEHz
 wgTZgdA9p64jIE4jvCxBAK0VDY7Kcm4yDDEBMNxSmmsD2IEHZE6pY7TfN0J7o5yNC2NVqkG7
 M0ZPhUAgV0ZH7lnlQSjjtjqOJbEtru3gF1dMonY9bBSxXE0R+xzK06sg==;
Message-ID: <699a6f2a7dfa0b0f33f4d330fdebd7b2bd0f7e72.camel@siemens.com>
Subject: Re: [PATCH 0/5] Add support for gcc 16
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 13 May 2026 15:52:30 +0200
In-Reply-To: <103292be-0400-410c-abea-f2c6408a7bb7@siemens.com>
References: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
	 <103292be-0400-410c-abea-f2c6408a7bb7@siemens.com>
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

On Wed, 2026-05-13 at 15:46 +0200, Jan Kiszka wrote:
> On 13.05.26 14:50, Florian Bezdeka wrote:
> > Hi all,
> >=20
> > Trying to compile the codebase with gcc 16 revealed some minor issues /
> > compile failures. Fixing them up was quite easy, so here we go.
>=20
> Is this gcc 16 generically, or are distro decisions involved here?
> Primarily out of curiosity, but also to consider reproduction - did you
> use Fedora or Debian forky?

The build system triggering this issues was based on Fedora 44, which
ships gcc 16.1.1 as default compiler. I'm not aware of any distro
specific things here.

Florian


--=20
Siemens AG, Foundational Technologies
Linux Expert Center


