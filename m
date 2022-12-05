Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452926125
	for <xenomai@lists.linux.dev>; Mon,  5 Dec 2022 17:32:46 +0000 (UTC)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202212051732399d0b32b10352788411
        for <xenomai@lists.linux.dev>;
        Mon, 05 Dec 2022 18:32:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nBDAB6HbiLBYR03lTkbhRenLT1cK1EY9ICMoJpJd0ng=;
 b=XX0TkZ9gW+TkxPkAkFdrUb8bNIL/MHze6E9Jg1kfMV0ukMK+9bjWv/9FcUmxOKztciDsq8
 hpV9u6kc88n7jl7bxhYT48+op9HrLdHpFNU9rBoKysQGOfXZ6dNh8Kb47DGYX1FUetlEQYmd
 ZvV3d+0iEGlSyhn1RuXR26RhlStRg=;
Message-ID: <e5ec7bdd80c33bfd98cb9251ca70f392cb9afdd7.camel@siemens.com>
Subject: Re: [PATCH v2 0/3] switchtest: test different migration types
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
Date: Mon, 05 Dec 2022 18:32:37 +0100
In-Reply-To: <20221205152104.3555474-1-tobias.schaffner@siemens.com>
References: <20221205152104.3555474-1-tobias.schaffner@siemens.com>
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

On Mon, 2022-12-05 at 16:21 +0100, T. Schaffner wrote:
> From: Tobias Schaffner <tobias.schaffner@siemens.com>
>=20
> Switchtest only tested intended switches between primary and secondary
> mode in userland.
>=20
> Let the rtuo thread also test fault based migrations and migrations that
> occur while in kernel mode.
>=20
> This patch series will also test the bug that was fixed in
> 829d4d33cb7aa3ee485ad56da6ac0c3b0ce5dbe5
>=20
> Changes since v1:
> - Squash patches 1 and 2 aswell as 3 and 4
> - Call the correct rtswitch_to_xxx function after mode switch in the
>   switchtest driver
> - Only switch to secondary mode by using a linux syscall or by a call to
>   cobalt_thread_relax()

Why has the part with a faulting syscall been removed?

Just in case my previous comment was misread: My idea was not to remove
it but to move it into the switchtest uapi, similar to the switch_mode
flag that you have introduced in patch 3/3.

Something like "trigger_fault" in addition to switch_mode should do it.
That would decouple the switchtest utility from y2038 stuff.

>=20
> Tobias Schaffner (3):
>   switchtest: split the set_mode method
>   switchtest: test multiple secondary switch cases
>   switchtest: test mode switche while in kernel mode
>=20
>  include/rtdm/uapi/testing.h         |  10 ++
>  kernel/drivers/testing/switchtest.c |   8 ++
>  testsuite/switchtest/switchtest.c   | 142 +++++++++++++++++++++-------
>  3 files changed, 126 insertions(+), 34 deletions(-)
>=20

