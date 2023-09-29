Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0F917D5
	for <xenomai@lists.linux.dev>; Fri, 29 Sep 2023 07:45:12 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230929074509f42196227ad95a03ba
        for <xenomai@lists.linux.dev>;
        Fri, 29 Sep 2023 09:45:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=DbJ8j1iQ3VWAqQtSILbcfhbh1uMzcsvijYvmQHwTIHA=;
 b=fsZQRIZIq3ksK5i1ZqHpCTOHoe5qDhhUy1Lquwl0izkcNUgcgmBo1iyi9n53Ryu4W2pXDv
 R9r3Vsj5/Gs6kT+xrkuuB9H3V5bZgmoR7WdYdEMy6FLPmJOgx6IUIk/LQtdRpGd/OrIntBRB
 ON8mBxWwp7n/BaQ/aEmltKp3HiCww=;
Message-ID: <6dccc04e926ae6a658c297cd7f45566e55fbeb7d.camel@siemens.com>
Subject: Re: [PATCH v2 0/9] y2038: Finalize and enable y2038 support
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Fri, 29 Sep 2023 09:45:08 +0200
In-Reply-To: <e21e5064-061b-422c-be02-74aa08d26719@siemens.com>
References: <20230809-florian-y2038-2-v2-0-05f710464d83@siemens.com>
	 <e21e5064-061b-422c-be02-74aa08d26719@siemens.com>
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

On Thu, 2023-09-28 at 18:25 +0200, Jan Kiszka wrote:
> Thanks, this is sure a major step forward!
>=20
> How confident are your that all these now possible combinations are
> still tested? Our CI will run with y2038 enabled, right? How is the
> disabled case tested, at least build-wise? Or the case "unsupported by OS=
"?

Per default, y2038 support is enabled if
  - the architecture we build for is affected
  - glibc provides y2038 support as well

All 32 bit targets that we have (bbb, x86-compat) are now built with
y2038 support enabled.

All 64 bit targets are not affected, so y2038 support is disabled (not
required).

The only thing that we do not test right now is the building against
older glibc versions. I'm not sure if it's worth to add more CI jobs to
cover that case.

Florian

>=20
> Jan
>=20
> --=20
> Siemens AG, Technology
> Linux Expert Center

