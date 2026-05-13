Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621AE43C074
	for <xenomai@lists.linux.dev>; Wed, 13 May 2026 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682884; cv=none; b=QJE9mRnx1zYn96+Vu/ub1nDuAdRBaFS4Clma9mFNr9+9dD4lrkVAcDCWxdm65qAVBxDdrX91k+Dq/4aDxy0Fi86j6wMlXSLypuRkQjev4uNBJKYkVOBn51ThcZ2OdPy4N7aTmaVtWsIYQEDcXLF6QJzKFpNMfvdvJi7J/PDp/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682884; c=relaxed/simple;
	bh=1EFVMNmQp++XqMbZc9PGld334lKc6ZxFLgRQtuVc7W4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hOppCtpJ57SyyaeFXm4C84DufT79mWOR8EEbhhFzevoviSq8IcPTu7RZ9QUyXhSxHOfhua8+Ry9oO9W5dPDKu0SDoe7Zr2eJhrKSym8GL6IymlZw+XrhtrtdONgVoG6Rv9TPChEgwlXDDkI/eL2LLeNmIQ1g0DWlaZXUIdp1xbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ibs4Upd1; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ibs4Upd1"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202605131434283669e4f0af000207db
        for <xenomai@lists.linux.dev>;
        Wed, 13 May 2026 16:34:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=1EFVMNmQp++XqMbZc9PGld334lKc6ZxFLgRQtuVc7W4=;
 b=ibs4Upd1og95YoK7OUr4zohNs8d4l2L31f59DWFuNgHsA58SMv3xhRuI/8uHNmouqGDkT+
 VdJjdWSSVMrnf0Tvzqoz59WteAhHdEXBQ4gnMFUu63KcXkIhvhAW1bX4w6d1WNmJ9Maf9h9e
 6AkNzMsAQO2xE+UZhAqJr2wk+x3ioc81KpY+Yc416N+Fl/kZ9AOyI3hUWq+qLHwt4uAM4EUX
 A5FCEoxJVrV/QmIRuyU7ut2sOOhtiRE1gvGf3uOVv51d+txHkW0rylugs7nPnwP8ZgE0edoK
 dIYNBDxZIWmc3HAsByR0pSpI+Rq9jT/1G1GeB9J+osnpHIyIrAYgXnxw==;
Message-ID: <d1413d87824e5febfaf54400e941ecbbcd1c61ee.camel@siemens.com>
Subject: Re: [PATCH 0/5] Add support for gcc 16
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 13 May 2026 16:34:28 +0200
In-Reply-To: <ad18a6c3-2040-40e1-b72f-23138e58f261@siemens.com>
References: <20260513-wip-flo-gcc-16-v1-0-120ae1287401@siemens.com>
	 <103292be-0400-410c-abea-f2c6408a7bb7@siemens.com>
	 <699a6f2a7dfa0b0f33f4d330fdebd7b2bd0f7e72.camel@siemens.com>
	 <ad18a6c3-2040-40e1-b72f-23138e58f261@siemens.com>
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

On Wed, 2026-05-13 at 16:04 +0200, Jan Kiszka wrote:
> On 13.05.26 15:52, Florian Bezdeka wrote:
> > On Wed, 2026-05-13 at 15:46 +0200, Jan Kiszka wrote:
> > > On 13.05.26 14:50, Florian Bezdeka wrote:
> > > > Hi all,
> > > >=20
> > > > Trying to compile the codebase with gcc 16 revealed some minor issu=
es /
> > > > compile failures. Fixing them up was quite easy, so here we go.
> > >=20
> > > Is this gcc 16 generically, or are distro decisions involved here?
> > > Primarily out of curiosity, but also to consider reproduction - did y=
ou
> > > use Fedora or Debian forky?
> >=20
> > The build system triggering this issues was based on Fedora 44, which
> > ships gcc 16.1.1 as default compiler. I'm not aware of any distro
> > specific things here.
>=20
> Maybe try out gcc-16 from forky as well, just to permit more precise
> motivation description.

forky doesn't ship gcc 16 (yet).
