Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A34FAD38
	for <xenomai@lists.linux.dev>; Tue, 15 Aug 2023 09:09:19 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230815090911dbadc9d005e00ae4aa
        for <xenomai@lists.linux.dev>;
        Tue, 15 Aug 2023 11:09:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=kKhu8STht1H462PXerFqDAGLxbWjD0A0ScQ1UY46Ln4=;
 b=eXlQP69QQKhg6qvCHIg8/QUZHydXJIG4Zz4clSu6VTdlkscy9GtbpQGvyA4OXzMRqKuBjz
 68SkvOU/r+nxiss1bfi3Wox0ILMwuBtPhJwYC3srBwOBfh7rnXg7EWBj6wCB2UqFWDF1+A8D
 eAHL32mH3OA9VDZLtxu8bOdMLffdQ=;
Message-ID: <e4bcdaf42e80319f0506194ec31a32c537aa86a6.camel@siemens.com>
Subject: Re: [PATCH 4/7] y2038: build: Introduce new build parameter
 --disable-y2038
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Tue, 15 Aug 2023 11:09:10 +0200
In-Reply-To: <b59ea020-7426-4213-ac57-2f97c32bf5db@siemens.com>
References: <20230809-florian-y2038-2-v1-0-d1cfe2f394a3@siemens.com>
	 <20230809-florian-y2038-2-v1-4-d1cfe2f394a3@siemens.com>
	 <b59ea020-7426-4213-ac57-2f97c32bf5db@siemens.com>
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

On Fri, 2023-08-11 at 17:06 +0200, Jan Kiszka wrote:
> On 11.08.23 09:37, Florian Bezdeka wrote:
> > The new --disable-y2038 build parameter will be used to disable
> > additional function wrapping when the architecture we build for is
> > affected by the y2038 problem.
> >=20
> > The default value is "no" so y2038 support is enabled by default.
> >=20
> > If --disable-y2038 is given for an architecture that is not affected it
> > will be ignored.
> >=20
> > CONFIG_XENO_LIBS_Y2038 will be set to 1 if the following conditions
> > are met:
> >   - y2038 support was requested (default, no --disable-y2038 given)
> >   - the target platform is affected by the y2038 problem
> >   - glibc is used as libc
> >   - glibc has y2038 support (glibc >=3D 2.34)
> >=20
> > CONFIG_XENO_LIBS_Y2038 will be used later to add necessary glibc
> > wrappers.
> >=20
> > If y2038 support was requested and is available in glibc the CFLAGS
> > -D_TIME_BITS=3D64 and -D_FILE_OFFSET_BITS=3D64 will be added to
> > affect all compile units.
>=20
> So, in contrast to glibc which will support both legacy and time64 ABIs
> at runtime, Xenomai is selecting this at built-time for ALL Xenomai
> applications on a target system. Right?

Right. Is there a need/requirement for supporting both worlds in
Xenomai at runtime? The kernel infrastructure could stay as is but the
plumbing in libcobalt would have to evolve. The time64_t wrappers will
have to introduce separate code paths down to the syscall layer.

Florian

>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

