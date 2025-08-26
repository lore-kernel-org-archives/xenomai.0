Received: from cczrelay01.in2p3.fr (cczrelay01.in2p3.fr [134.158.66.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4206B2857E9
	for <xenomai@lists.linux.dev>; Tue, 26 Aug 2025 08:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.158.66.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197283; cv=none; b=htKbtZo6rJHBA5XZJKjXHlTRAKWEd08FI4KyzNsXgXvZNMGy0Dwm6R96nFcTxuuz5ZLSCMesO3M51ss2Hucoq7viz3AC/sU8An7Uda1aQEyAaRbaj1/1VS8yxRrWmggYEd26z4smzgHBpmWpK/1SX+aD0bgf4UYGju/giQ3xmvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197283; c=relaxed/simple;
	bh=Jsxyx+rfdCNYNmw97NmF990s6UsYXbh0Wim6r8ymNII=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SBSN7SUiU+TttAzdrwQjRkN0lCumsqnSl86rUwKxR7uzWB3a4uODxxlf6azYuivnLdf7w3kObSVtP7a3EyED/KW+lgMJsRlJBJN8LfGrN1CXP7yWNd1da2qCQ8HSBhndnKoGlSkvah229ogE3EGWQWts/DnePak+XuNRLyG6OHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lapp.in2p3.fr; spf=pass smtp.mailfrom=lapp.in2p3.fr; arc=none smtp.client-ip=134.158.66.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lapp.in2p3.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lapp.in2p3.fr
Received: from [134.158.99.46] (lappc-p898.in2p3.fr [134.158.99.46])
	(authenticated bits=0)
	by cczrelay01.in2p3.fr (8.14.4/8.14.4) with ESMTP id 57Q8YUiV030393
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Tue, 26 Aug 2025 10:34:30 +0200
Message-ID: <23c94fc57c83fea60a929065ee47f70755c65d16.camel@lapp.in2p3.fr>
Subject: Re: Documentation port to relearn
From: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
To: Philippe Gerum <philippe.gerum@gmail.com>
Cc: xenomai <xenomai@lists.linux.dev>
Date: Tue, 26 Aug 2025 10:34:28 +0200
In-Reply-To: <87h5xumv36.fsf@xenomai.org>
References: <6103a8831efc075fea7ddc7d7cea574f411a7795.camel@lapp.in2p3.fr>
	 <87h5xumv36.fsf@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Le mardi 26 ao=C3=BBt 2025 =C3=A0 08:54 +0200, Philippe Gerum a =C3=A9crit=
=C2=A0:

> > Browsing the Xenomai4 documentation I was annoyed by the sidebar loosin=
g its
> > scrolling position at each page change. It looks like it is an issue wi=
th
the
> > hugo learn theme. In a commit I saw learn is reaching its end of life, =
and
there
> > is a plan to use relearn instead. I'm willing to do the port if it is s=
till
the
> > plan.
> >=20
> > I have started the work here:
> >
<[https://gitlab.com/emmanuelpacaud/xenomai4-website/-/merge_requests/1](ht=
tps://gitlab.com/emmanuelpacaud/xenomai4-website/-/merge_requests/1)
>
> >=20
> > I think at least the first commit is already useful, as it fixes a bunc=
h of
> > broken links.
> >=20
> > Please let me know if the port to relearn is still wanted.
>=20
>=20
> Oops, it's on its way on my end actually, v3.xenomai.org is next, almost =
=20
> done. Basically, only the landing page is missing.

Arhh... I have just finished the port. Let's say it was for learning things
about hugo.

Emmanuel.
