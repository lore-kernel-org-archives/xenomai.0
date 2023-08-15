Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D38AD2E
	for <xenomai@lists.linux.dev>; Tue, 15 Aug 2023 09:20:05 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2023081509195716476e273659ca366f
        for <xenomai@lists.linux.dev>;
        Tue, 15 Aug 2023 11:19:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=5PDCFbBiYMmNHcOljFec2DyRkF31jHPhnN8GKDp6epc=;
 b=ch8qZ0ybGwfG0+ZtIuNzcTC95dR6LX1NrU/8POBhKkli4RT4/sNitdDo2SVkUtWkOXXYye
 9aNhm38KFspfkWWUCWgvPEZEQ7Ks0PX5EPjllGNEMN48/8jvt02eYb4u2BN9gv4Whl4d68R0
 NO4Et1UJtwi9bNaKUh7/HkpqdpvLM=;
Message-ID: <ec7eb1c4449210f5e69baf74c3194e4e70b9030c.camel@siemens.com>
Subject: Re: [PATCH 6/7] y2038: Route explicitly requested stdlib calls to
 time64 equivalents
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Tue, 15 Aug 2023 11:19:55 +0200
In-Reply-To: <b7230826-40be-4b00-9a10-ed5c8aab487c@siemens.com>
References: <20230809-florian-y2038-2-v1-0-d1cfe2f394a3@siemens.com>
	 <20230809-florian-y2038-2-v1-6-d1cfe2f394a3@siemens.com>
	 <b7230826-40be-4b00-9a10-ed5c8aab487c@siemens.com>
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

On Fri, 2023-08-11 at 16:57 +0200, Jan Kiszka wrote:
> > +static int test_function_wrapping(void)
> > +{
> > +#ifndef __USE_TIME_BITS64
> > +	/*
> > +	 * We're testing some functions here that are wrapped only for 32 bit
> > +	 * applications with y2038 support enabled. If that's not the case we
> > +	 * can simply bail out and simulate success.
> > +	 */
> > +	return 0;
> > +#endif
>=20
> Won't that cause warnings about unreachable code after the return? Let's
> rather do an #else ... #endif here.

Will be part of v2. (It did not trigger the warning for some reason...)

Florian
