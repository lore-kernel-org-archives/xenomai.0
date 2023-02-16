Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7583833E6
	for <xenomai@lists.linux.dev>; Thu, 16 Feb 2023 22:16:20 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202302162216102dbe5e4cf9ccd0b29b
        for <xenomai@lists.linux.dev>;
        Thu, 16 Feb 2023 23:16:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=LSSy9Nsm655fpkxjda9FqR2377cX5mlSA8AOJHO1U7Q=;
 b=XIaae2WaGhKrAMc3BghxdlmdW38xpnUO+HOV8NoQ+1tEqxoqmulrDHml6PihqAKcCEU9BV
 BjlJh80jKIfgA3JoWpRiKF0pqsCqlNe3Sm1wpOymyMJNu67an9k8bjIpGxPVWTIOMN8luxGq
 TPGJssXzBEu/C51LiEu8bWIXnGrNw=;
Message-ID: <df1a4ee9ec73edab59086b1054a9b8a5f4e3062b.camel@siemens.com>
Subject: Re: about rcu_preempt detected stalls on CPUs/tasks
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "Yao,Yongxian" <yxianyao@126.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Date: Thu, 16 Feb 2023 23:16:07 +0100
In-Reply-To: <91565036-8b64-6a00-58f0-877fe83ba153@siemens.com>
References: <502ffef0.6ee4.186548762d8.Coremail.yxianyao@126.com>
	 <f2b91213-82a0-f78f-9948-3c7f9a13888b@siemens.com>
	 <6cb72fb7.7353.18654c1e3da.Coremail.yxianyao@126.com>
	 <31d280a1-f7bd-fab6-2e37-fc9dbdaad400@siemens.com>
	 <40a7d44a.e85.18657d3155b.Coremail.yxianyao@126.com>
	 <91565036-8b64-6a00-58f0-877fe83ba153@siemens.com>
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

On Thu, 2023-02-16 at 10:31 +0100, Jan Kiszka wrote:
> On 16.02.23 02:24, Yao,Yongxian wrote:
> >=20
> > Hi Jan,
> >=20
> > At 2023-02-15 21:04:34, "Jan Kiszka" <jan.kiszka@siemens.com> wrote:
> > > On 15.02.23 12:07, Yao,Yongxian wrote:
> > > >=20
> > > > on 2023-02-15 18:49:11=EF=BC=8C"Jan Kiszka" <jan.kiszka@siemens.com=
> wrote=EF=BC=9A
> > > > > On 15.02.23 11:03, Yao,Yongxian wrote:
> > > > > > =20
> > > > > > Following exceptions occur on the Debian10.3 using Linux+xenoma=
i kernel.=C2=A0
> > > > > > Please give me some hints.=C2=A0
> > > > >=20
> > > > > Is your Xenomai application dominating a CPU for more than a few =
dozens
> > > > > of milliseconds? Do you have the Xenomai watchdog enabled (it wou=
ld
> > > > > catch such cases, after some seconds)? If you do have such a work=
load,
> > > > > Linux complaining about not having the time to "breath" on such a=
 CPU is
> > > > > no surprise.
> > > >=20
> > > > Real-time applications will not occupy CPU continuously for a long =
time.
> > > > And the xenomai watchdog has been turned on.
> > > >=20
> > > > CONFIG_XENO_OPT_WATCHDOG=3Dy
> > > > CONFIG_XENO_OPT_WATCHDOG_TIMEOUT=3D1
> > > >=20
> > >=20
> > > Ok, then:
> > >=20
> > > - Any other error messages before the one you shared?
> >=20
> > That's all the error messages.
> >=20
> > > - Already tried if the issue persists with a (more) up-to-date kernel=
?
> > >   ipipe-core-4.19.266-cip86-x86-25 is latest on 4.19, last I-pipe is
> > >   5.4, and we have plenty of dovetail kernels
> >=20
> > The customer sites now use the ipipe-core-4.19.89-x86-9, which is diffi=
cult to keep pace with the release of the xenomai community.=20
> > We are planning to update the new kernel.
> >=20
> > > - Any details on how this can be reproduced?
> > >=20
> >=20
> > Many sites have deployed this version of the kernel. This problem has o=
nly occurred once, and there is no way to reproduce it.
> >=20
>=20
> That sounds indeed unpleasant.
>=20
> > In your opinion, what are the reasons for this problem?
> >=20
>=20
> No idea yet.
>=20
> Florian, from our own deployments of older 4.19 in our MRT scenarios, do
> you recall any similar reports?

Tried to find something similar in our internal issue tracker. We had
something similar in the past, but with dovetail underneath - not
ipipe.

The first report is about a network inactivity (CIFS timing out). It's
likely not the root cause but 6sec is a quite long time. Something
similar was detected in the early dovetail days. Root cause was a LAPIC
stall. I'm not aware of any related/similar ipipe issue.

Any special kernel cmdline arguments deployed?

It might help to put significant load and network traffic on the system
(stress-ng, iperf). Still needs some luck, but maybe you're able to
reproduce it.

Best regards,
Florianq

>=20
> Jan
>=20

