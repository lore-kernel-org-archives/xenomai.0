Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8996C37E2F7
	for <xenomai@lists.linux.dev>; Thu, 29 Jan 2026 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680468; cv=none; b=MM41imfKAA5Y42hLwyITCfcbcLCYCvO54hF9PSsTph//oV1QAOxb2V5jcohohkGmzP8n7r2Pat4dELJdZQQMm3pUEv7T/j6cBImkvkBj6gklZDVohV2LjuA6gx1K14TOqv1XfLIFp+fYC7c0JpggR5KKE3bqlrD5XH4I5LBb/BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680468; c=relaxed/simple;
	bh=GqyHvUUPVzS/rYy4iT4o/vklLK95qQ+vPKPqnN6OxUM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qA4DZHqOJWd48Ud/nFJ2NiKQasLKIt1lalRgkfY6kTx+bmqUaV1U+uDXEFtCUtfLS2lUm4t848u1EKWqW4f04T1PAvc79J9XmQpk5+hSSFbROMbkDJSfPI23yse8fzlEutYT8wujJXI8swi+lqE9kSRmZCJbuquereRwYhOPjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=GQUfI7SZ; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="GQUfI7SZ"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2026012909541533778201a5000207bb
        for <xenomai@lists.linux.dev>;
        Thu, 29 Jan 2026 10:54:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=GqyHvUUPVzS/rYy4iT4o/vklLK95qQ+vPKPqnN6OxUM=;
 b=GQUfI7SZdSubcItHfI1Ff2ZwZGu5ALo3i5UEVHa5nfmNIqeDgFfnzGxrgNP+FBqpcCqfb8
 IUftybLziG8ZtaBA97wD731InTIbmg66yOg1DRQz9QQom+KF4NCqHJL30Fu7Q66/Fnog+NM2
 JU0FBLBEgz0EXljSpkjMwA8+m36RvXgACNy3Cm+5mEU3GLReMPeKqzzitbAQbtjGVnNI1DQ5
 zYyieRF+9himteivKyltNBaU3d1rinaU4wckpfBegPj8ukRiFDIEKigJ8jKgrLfrOLqQ1UAK
 pvQbXLviSbQ0I3fUEBqXc6FzF2VrH1UZLbqNPgLWxKixgRqkwUc5n5KQ==;
Message-ID: <a879280f2cc0ca051e31f51394f0e8d296e4b5c0.camel@siemens.com>
Subject: Re: [PATCH 4/5] Warn on unexpected RTDM task termination
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Richard Weinberger
 <richard@nod.at>, 	xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
Date: Thu, 29 Jan 2026 10:54:15 +0100
In-Reply-To: <eaef51c3-ca97-444c-b883-4ca8ef6e3f00@siemens.com>
References: <20260128112821.1232-1-richard@nod.at>
	 <20260128112821.1232-4-richard@nod.at>
	 <eaef51c3-ca97-444c-b883-4ca8ef6e3f00@siemens.com>
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

On Thu, 2026-01-29 at 10:50 +0100, Jan Kiszka wrote:
> On 28.01.26 12:28, Richard Weinberger wrote:
> > Now that all in-tree RTDM tasks have been updated to handle termination
> > correctly, introduce a check to detect unexpected task terminations.
>=20
> They did this correctly already. Key is that semantics are changing, and
> that needs adjustments.
>=20
> >=20
> > This warning will assist authors of out-of-tree modules in identifying
> > tasks that do not yet properly handle interrupted function calls.
>=20
> Can you be more precise here? What are driver writers supposed to do,
> what should they refrain from?
>=20
> We have kernel/cobalt/rtdm/API.CHANGES, but that hasn't seen updates in
> a long while. Better is likely to put the new task setup/teardown
> pattern into the documentation of rtdm_task_init, also explaining when
> the warning above would trigger.

In addition to improving the documentation, can we somehow test that in
CI? I'm missing the testing part to avoid breaking it again.


