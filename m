Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616AC6FA2
	for <xenomai@lists.linux.dev>; Thu,  3 Aug 2023 15:36:01 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202308031535544d76be6fe571506563
        for <xenomai@lists.linux.dev>;
        Thu, 03 Aug 2023 17:35:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Ii9HJ0Dd4mfJV6lpKKVkOiuMHbmYL706fojTFgC3SZ4=;
 b=SHj8hTqRD7mWVeAbwcGvrs0Wrs9LhN744Q0TW9+lb4np1pp6WRkE/0bZgUBv3Qkwsp7g8v
 y99nKJwoNKfoUGbHB/TimxkX0dFFIDc9B1gs9Q16uLuSWA0U4kRZ0vVuItxC9GtNfudXnN0f
 AVPK/PB34O5tAODB1JacNQfiG3vgs=;
Message-ID: <81b336f6b3d3f1607e72c59321267d0bb5ec96fc.camel@siemens.com>
Subject: Re: [PATCH v6 00/10] Revive alchemy, pSOS and VxWorks tests
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Aaron Marcher <aaron@sigma-star.at>, xenomai@lists.linux.dev
Cc: richard@nod.at, jan.kiszka@siemens.com
Date: Thu, 03 Aug 2023 17:35:53 +0200
In-Reply-To: <20230725082959.5144-1-aaron@sigma-star.at>
References: <1753829974.221010.1690209596711.JavaMail.zimbra@nod.at>
	 <20230725082959.5144-1-aaron@sigma-star.at>
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

On Tue, 2023-07-25 at 10:29 +0200, Aaron Marcher wrote:
> This patch series fully integrates the currently abandoned alchemy, pSOS
> and VxWorks tests into Xenomai's testsuite.
> For each test, a Smokey testcase is hooked up.
>=20
> Changes since v5:
> - Improved task-2 fix commit message
>=20
> Aaron Marcher (7):
>   testsuite: Fully integrate alchemytests into smokey
>   testsuite: Fully integrate psostests into smokey
>   testsuite: Fully integrate vwworkstests into smokey
>   alchemytests: Check pipe-1 asprintf ret value
>   alchemytests: Fix task-2
>   alchemytests: Fix task-5 logic
>   testsuite: disable broken tests
>=20
> Richard Weinberger (3):
>   testsuite: Remove old alchemytests Makefile
>   alchemytests: Fix gcc warning in buffer-1
>   alchemytests: Fix gcc warning in task-9
>=20

Feel free to add "Updates" or "Closes" tags for the following gitlab
issue that is tracking your activities here.

Something like

Updates https://gitlab.com/Xenomai/xenomai-hacker-space/-/issues/32

in the commit message should be enough.

