Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685752;
	b=u7zHcRgGF1OynbGU24fAp9Hm1Vbg3rup3tRAySuZLMtQNl6Kk5tql4xjzCwf+4q2dh/G
	 q9/+7CcbDBRmyzBMqpAB8+K5yB0nmNoYUX/VnTI00zFiMjKGBdhgvVv5Ur8sPFf5nVpCR
	 z89zeCGuj8EL749/duZFTmBtJOekxmsBCVjOUz0+sNtR55QeMCDLj+dEDLHDYz0ckB4I1
	 JttKnQzRXp436+dWwfCvERn+pnE7sZJaukFgUdg9dX1e4pqwms9iWNxW1MI/w25tpKhtr
	 dGHGijxmt36IlMLRMBw/7sNAOXftIaF1K4gA+W8jeVaIRnKGWbXMf/i3sEJkdMlCHzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685752;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-Flowmailer-Platform:Feedback-ID;
	bh=l+Wosb12ctBQhhqWHLXlhwcMXSyU3Dvovec26vQ+PCQ=;
	b=RPcfMDxDmzZgYFwYS075P4VO+94U02G0V5++bhNYTUcPvasbxCKadR943ew5sWb73K4g
	 bC3o1eVuLfxqaMQx1ASdrlui6zyLnESXoJfnqcoRP4crLT8l5qekjrLj6CmDfWG/onbu0
	 LnPaaToCl5FO6rgo9HjLjr3fhA2NYsL1TZNe4GaaLTHlV4D2U5xtEQOVud1NoFRakN1Ql
	 AHk8LBev+6YLc+KmivMTOOMA4lK/fABsFJ58iDrv7qrGezCOcO3k016diRO5RIgVV/gpx
	 4AWsJ+1DbWEO16QD7HnLOqaZtpCpCWQU39OQIaM/u18BAWyc7IUoIGY+BTWufYZ000w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=hcWKfHv9;
	arc=none smtp.remote-ip=185.136.64.227
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44056606A31C
	for <xenomai@lists.linux.dev>; Thu, 26 Nov 2026 09:35:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44056606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=hcWKfHv9
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202611260935461c6f39150a000207a3
        for <xenomai@lists.linux.dev>;
        Thu, 26 Nov 2026 10:35:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=l+Wosb12ctBQhhqWHLXlhwcMXSyU3Dvovec26vQ+PCQ=;
 b=hcWKfHv9VKtgc5GtsxaKwzKoOAsI5sv6wIRo/I390wWqz2vQJ04mNNvXi46/4/xRnvzFjQ
 lMjucoMATeXV11JutKju+jhsZJ6w5fmW92VCdKzk+hpYRpRZyqQhjCzQ9wHDwJL0KeaAY1zl
 x391zvl07UhoJ9sR+RKYhYqKgEzzfWt9vrkwZ462FnzY1e89C2AmXA7y6h7ibcbi15EyKjpY
 t+Ib1pS3HrDUh8XHxIf7j45g4R0vF+JoKY7aX00egqqTr7kqF9I2kjxJaGImUAJxP4S26/rH
 Xb9uC7Zoa5e85Rj4jbXO4TyuJBMnoX1pjeLnXZ1UW2eHZutgfvSjOhkQ==;
Message-ID: <3c3fdb0d967083b6da9b6387115e89d21bd6c7d3.camel@siemens.com>
Subject: Re: [PATCH] lib/cobalt: Let __STD() and __RT() of mmap follow the
 off_t redirection
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Cc: =?ISO-8859-1?Q?Fran=E7ois?= Legal <francois.legal@eventlab.fr>
Date: Thu, 26 Nov 2026 10:35:46 +0100
In-Reply-To: <d0919a84-e71f-4e08-86e3-8900b30f9e5f@siemens.com>
References: <d0919a84-e71f-4e08-86e3-8900b30f9e5f@siemens.com>
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

On Tue, 2026-11-24 at 13:59 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> With _FILE_OFFSET_BITS=3D64, glibc redirects mmap() to mmap64() on 32-bit
> archs. Applications get this setting by default since y2038 support was
> added, as xeno-config passes it along with _TIME_BITS=3D64, and some
> toolchains even predefine both (e.g. Debian armhf). uClibc-ng enforces
> 64-bit file offsets unconditionally since release 1.0.58.
>=20
> __STD(mmap()) and __RT(mmap()) do not follow this redirection: they
> expand to __real_mmap() and __cobalt_mmap(), declared with the 64-bit
> off_t of the caller. But with the Cobalt wrappers, __real_mmap() binds
> to the libc's mmap(), and __cobalt_mmap() is built with native off_t,
> so both take a 32-bit offset. They read it from the padding word in
> front of the 64-bit argument and fail with EINVAL or map the wrong
> page.
>=20
> Internal users built with 64-bit off_t are affected as well:
> cobalt_unmap_umm(), the pshared heap of copperplate and the TLSF pool
> of boilerplate all bind to the native-off_t __real_mmap() of libcobalt.
>=20
> Add COBALT_DECL_OFF64(), which redirects the __STD(), __RT() and
> __WRAP() symbols of a service to its 64-bit variant whenever the libc
> does so, and use it for mmap(). This relies on libcobalt providing
> __real_mmap64(). lib/cobalt/mmap.c implements both variants and opts
> out via __COBALT_NO_OFF64_REDIRECT__: building it with native off_t is
> not sufficient if the libc enforces 64-bit file offsets.
>=20
> Reported-by: Fran=C3=A7ois Legal <francois.legal@eventlab.fr>
> Fixes: fb2bd6e647a9 ("y2038: build: Introduce new build parameter --disab=
le-y2038")

This is where we turned _FILE_OFFSET_BITS=3D64 on by default, but in case
a user requested that from outside, this never really worked, right?


