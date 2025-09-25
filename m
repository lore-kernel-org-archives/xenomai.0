Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A2827B32B
	for <xenomai@lists.linux.dev>; Thu, 25 Sep 2025 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791706; cv=none; b=RRg35oTe5xQn3xdWyF1RU0dXvhox/d5+xpt+m578AfPzTqajiFH81UKbTW4uKDe/D+fRlF34QK+hMlFnqG7Zzndf0bL7M/yzMp8+R8RgE5CWmS1LeUw2zT0O0rcftN6FmUvVgP0KW414lfIsn/5jrXtQwP421oMxrTgqZEksHh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791706; c=relaxed/simple;
	bh=51puI8wvMZ8840xhv9Oq8ygGKVQGoogLxaKQ2pq7KHw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vd3QFuyrYJdqfVoN8eitnNzkIBalbC+vALVOUz7eQgI83QVOeZljOQQ9w52avazCy9XI8lZV/IEjpOjmRl9434w4W2YqRbm1cvxB79cv3OaKwfIvZD91ogiP4RSjVR2wrl5i2qi831N1y8wTLYps9WX3g5NKDWvoUmQ4jwAQkio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Xg0J5vVY; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Xg0J5vVY"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202509250914574ee2ec19d000020769
        for <xenomai@lists.linux.dev>;
        Thu, 25 Sep 2025 11:14:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=pzBXT/vfJChzikuI+GZwcvJxOqhN3rCrqO6Ontd4Wt8=;
 b=Xg0J5vVYzYZt8Hd3cIBQHY2OSJ5WlEz7vjnNR47J/2DWUK7wyDKKnsjO3GwtarhGhN3ubQ
 wXvDXMhNF7rk14taqpW0iZJH0e1L2EmH14+E9OQP76WsgdjNuTEkQ+wMtfsew+4W5iFrwZXf
 RaylzF9vUGLsqSRhCvQ6oR0QyQSvqWD/odZKTQYYlWEjOlkzz1XJW5p0aPFQXYRhG8h6Bbyr
 fGbhc+JukhgBsPKGOY6HWjwunUW3nGBFdwuX4VEurwSXagF0XojjHCtGhgisPwPyjWeJBsfO
 epeXWrx4RADbbdOLTqJ3xoMiKfDNHuROOpYRIPj96bN1r0xqr6HRmIaA==;
Message-ID: <587ea11186ed7eeb39adc4959b7f0ec7b299d08f.camel@siemens.com>
Subject: Re: [PATCH] configure: Propagate debug build settings also to plain
 applications
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Date: Thu, 25 Sep 2025 11:14:57 +0200
In-Reply-To: <0d628811-9955-4fd9-90a2-27be551dda14@siemens.com>
References: <0d628811-9955-4fd9-90a2-27be551dda14@siemens.com>
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

On Tue, 2025-09-23 at 07:43 +0200, Jan Kiszka wrote:
> =20
>  if test x$use_assert =3D x; then
> -   XENO_USER_CFLAGS=3D"-DNDEBUG $XENO_USER_CFLAGS"
> +   XENO_USER_CFLAGS_DEBUG=3D"-DNDEBUG $XENO_USER_CFLAGS_DEBUG"

We add NDEBUG to the debug flags? That looks odd.

>  fi
> +XENU_USER_CFLAGS=3D"$XENO_USER_CFLAGS_DEBUG $XENO_USER_CFLAGS"
