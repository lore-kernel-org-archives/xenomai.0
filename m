Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1D9197A88
	for <xenomai@lists.linux.dev>; Mon, 18 Nov 2024 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731925140; cv=none; b=LBSc250uV6Gmkhpt4oq+kx+Hbt1WZ6sgsyTpJfXLghjMHf06wUZBGSMWVQT4tG4sP4piyURMaTdV8a7ML88omIZCtmEEEDuUDiSuOf7RCF5nCr/+pZx8Z+uBWgXKkawlwHW0jAUrkykTiq986BrLg/D1juosYHmLszBsetIKzqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731925140; c=relaxed/simple;
	bh=eZ/wxABG2q2GPYBei2BjrK4jg4RkpcwW63Zv/ZDfntY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aElbYEuyVKOJ1UQNRa592B/SfHupIKU95pxUosgug/IfUib2F365v0oumKUiArRka21VabuiDCuJLIKBRVyabQbHayUHvSxa9W9/xRDP505Jvyz65iEFjkaJu86DCe2NwfZI+NzN08I6OYnZsEHsKFLE41eDBiXaYcKw1o0k3Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=a7tJrNSx; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="a7tJrNSx"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2024111810184636dfa06882fead199b
        for <xenomai@lists.linux.dev>;
        Mon, 18 Nov 2024 11:18:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=KpWoo0vG3hSX3Zb1XSPBkoWkz//eHOVsp1W1BLNqDhY=;
 b=a7tJrNSx13eX3Egx1pbxdUFN4YeIaM2kbsS1qT5QyS+ESr4PCBO4yfwq7JkMoFGbkTQpN6
 00AgIErwVgzWdwvjT8tI+gI6OOAKZOm+kdzpM0KxujVdA+1my04pujTYWe0PlAymNaEVtlPZ
 9IemIq1Z+FKPdt6k3lPlGvx5ioCCYP82yoJRWCiVFZRDQb1vdCF/+vqK1AKiFYA0LnRo4Tr2
 y9bYIaEibrVvbvDSWWikQni+PMu+RuSzWD3h62Lh+7tbOdCxbgH+TqRkneIiJ7aiiUGDKYZS
 WA/hK6zh8RDju1ZO6A8DhYJ7Ri5E566bSMAIGR1Yfc7vHDWdS1vxAQsA==;
Message-ID: <91f3bdfa29efa0929ede19ec9e2464151f7e5f7e.camel@siemens.com>
Subject: Re: [xenomai-images][PATCH] libevl: Add build dependencies for r50
 and above
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Cc: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Mon, 18 Nov 2024 11:18:45 +0100
In-Reply-To: <a0d95b09-b050-48a3-a9fb-68af212ab1ba@siemens.com>
References: <a0d95b09-b050-48a3-a9fb-68af212ab1ba@siemens.com>
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

On Mon, 2024-11-18 at 09:02 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> libbpf is needed now to support the networking stack, and that is found
> via pkg-config my meson.
                 ^^=20
Typo?

>=20
> Reported-by: Pierre FICHEUX <pierre.ficheux@smile.fr>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  recipes-xenomai/libevl/libevl.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/recipes-xenomai/libevl/libevl.inc b/recipes-xenomai/libevl/l=
ibevl.inc
> index 405be8b..fb82d09 100644
> --- a/recipes-xenomai/libevl/libevl.inc
> +++ b/recipes-xenomai/libevl/libevl.inc
> @@ -17,7 +17,7 @@ DESCRIPTION ?=3D "libevl libraries and tools"
>  SRC_URI +=3D "file://debian"
> =20
>  DEPENDS =3D "linux-xenomai-4"
> -DEBIAN_BUILD_DEPENDS ?=3D "debhelper (>=3D 10), meson"
> +DEBIAN_BUILD_DEPENDS ?=3D "debhelper (>=3D 10), meson, pkg-config, libbp=
f-dev"
> =20
>  TEMPLATE_FILES =3D "debian/control.tmpl"
>  TEMPLATE_VARS +=3D "DEBIAN_BUILD_DEPENDS"
> --=20
> 2.43.0

