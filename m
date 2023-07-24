Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0A1863
	for <xenomai@lists.linux.dev>; Mon, 24 Jul 2023 08:05:49 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2023072407553265b8197a3eb38b4552
        for <xenomai@lists.linux.dev>;
        Mon, 24 Jul 2023 09:55:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=yZOiTkSNACOEN2o+QtMKmtpbxbAqIdEx6Ie+6NDHQKw=;
 b=aUBW6rht6VWjMm3KY/kyp+ymkCkgOsEY5gaxt2T7oIUF2mBjQP+nN67aAMdZ6S8wdQXd3Z
 inlJP6Tdj+A4aW8CFRV5EEZliIes9Zl/fWu93gA0lqXIpwUm88wfRWsppma68Qxokaj2ddUO
 bWdytAQYttH90JGRAmJH0cTHxhiew=;
Message-ID: <2ed898658b47cd9b1e8ae4d33b28392db8fdd312.camel@siemens.com>
Subject: Re: dovetail: IO-APIC IRQ storm
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 24 Jul 2023 09:55:31 +0200
In-Reply-To: <87fs5f0y2p.fsf@xenomai.org>
References: <ecada31f7d6376ed073cb485bd21457e1358d357.camel@siemens.com>
	 <87ttub8sx1.fsf@xenomai.org>
	 <621694c10b6c86f1b914779305934a2a714a7ef1.camel@siemens.com>
	 <87fs5f0y2p.fsf@xenomai.org>
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

On Sun, 2023-07-23 at 11:25 +0200, Philippe Gerum wrote:
> > It seems that for some reason the "software state" runs out of sync, we
> > skip the IRQ masking, call the io-apic EOI function, ACK the IRQ at the
> > IO-APIC and with some luck we immediately have to handle the next IRQ.
> >=20
> > Philippe, do you agree?
>=20
> The issue seems different than a virtual state breakage: for some reason
> IRQ21 is delivered by the hw although it was supposedly masked which is
> not depending on the inband stall bit. From that point, the whole logic
> runs amok.
>=20
> I have not been able to reproduce the issue so far with the xenomai4/evl
> core on top of dovetail 6.1.37 running on my fresh virtualbox install
> here. Can you share the kernel config and maybe the OVA export file of
> your VM? Also, does the issue happen without enabling Cobalt?

Thanks for your help! Let me try to hand over an export of my VM here.=20

I have to repeat some of my tests. I can't say yet if "dovetail only"
is OK or not. My tests didn't have the fix for the page fault handling
inside, so the situation is different now.

What I can say: The problem did not occur on "Linux only" builds, so
Linux itself was fine.

"Dovetail only" and "Dovetail + cobalt" was crashing. "Dovetail +
Cobalt" is still crashing (even with the exception handling fix),
"Dovetail only" has to be re-tested on my end.

Florian

>=20
> --
> Philippe.

