Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DE12F25F0
	for <xenomai@lists.linux.dev>; Mon, 27 Apr 2026 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282125; cv=none; b=M0JUZ3t8IWGiaTUBdJajR4Z1740IAEg9DthgynUrpacuBHHZGMDOCiOQjYusEkCsxZTAphC5RMD+mRGaH2252ggG2DYMv3oivKyjESb02f7YVbOifB+Z8LfilvxqCn9J5h9QrvBTNHY/WQDQ41mmKL66vPjeB6tFi/2Iv8cTahI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282125; c=relaxed/simple;
	bh=wFDzioYkKexaGhKkaFVWLv8pBrHA+hJ1lTxIXeS74UE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uWUEhdyP7cj47uVY1P1tsje3HiaPOTUfAjQIOqWO4JTZ+BwUbmqZw72k5+0PsM0B/6M3fVur8rqWU+mzUC+BdVbzWH34HRGkquPCqQxui505D6kebTbTj6u7LwedK9lkT/pvS62B15bS+Wov8giD+8Kl0jcP1s/rNHUNEjjj3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=iw+FEQPJ; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="iw+FEQPJ"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260427091822ee9b679ba000020761
        for <xenomai@lists.linux.dev>;
        Mon, 27 Apr 2026 11:18:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=wFDzioYkKexaGhKkaFVWLv8pBrHA+hJ1lTxIXeS74UE=;
 b=iw+FEQPJ1JwfWLnwD+vtsCW7P748+2GN8Elxxu3KpYWp7JZuPlYEzcvdT7Dxkhf/vXi5v5
 Et1RxOmv6NartYCT3hZd1bNgJy6q41n6LCvPEkS6Le1f1O3ZS6x9hg+vSFGBdKIHRM6P+rD6
 NLaiJOLn84vk01BnqI9KMFzbTvdyA0syudkFVjFtu0mnZZWjHd9LaX+0Nx8VCd/0Xb6lEPmh
 jAVxN9OUysTyIU16CVkasKWplIYQA8Zi/N0CddbEL4bWKKQxqZ2o10+HLvQvKG+KbRJl0Ezn
 0X1HFzBEcHjo4t1lC7ivpjlt+9F7Y4+WgnjzXmc45eJtg+SvKtZ+hOGQ==;
Message-ID: <ee787e06594ea3a32125c2db0c2112e7f6a9a81d.camel@siemens.com>
Subject: Re: [EVL] Kernel WARNING: notifier callback netevent_handler
 already registered
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Hannes Diethelm <hannes.diethelm@gmail.com>, Philippe Gerum
	 <rpm@xenomai.org>, Tobias Schaffner <tobias.schaffner@siemens.com>
Cc: xenomai@lists.linux.dev
Date: Mon, 27 Apr 2026 11:18:21 +0200
In-Reply-To: <2686ae4a-c63e-418e-8b4a-be49a22db83f@gmail.com>
References: <8e08bda6-1fed-4a5a-9bb3-74f019b05855@gmail.com>
	 <87340ij2lx.fsf@xenomai.org>
	 <201a7d9c-e1dc-4686-8a5e-adc7c921ba14@gmail.com>
	 <87jytt34q7.fsf@2a01cb0804738000b42250ae26cae50b.ipv6.abo.wanadoo.fr>
	 <2686ae4a-c63e-418e-8b4a-be49a22db83f@gmail.com>
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

On Sun, 2026-04-26 at 23:32 +0200, Hannes Diethelm wrote:
> Am 26.04.26 um 21:24 schrieb Philippe Gerum:
> > Hannes Diethelm <hannes.diethelm@gmail.com> writes:
> >=20
> > > Am 25.04.26 um 20:50 schrieb Philippe Gerum:
> > > > Hannes Diethelm <hannes.diethelm@gmail.com> writes:
> > > >=20
> > > > > Hello
> > > > >=20
> > > > > There is a Kernel WARNING: "notifier callback netevent_handler al=
ready registered right after boot". It is repeated 5 times.
> > > > >=20
> > > > > Config:
> > > > > Debian Trixie with xfce4 Desktop
> > > > > libevl: r56
> > > > > linux-evl: v6.12.67-evl2-rebase
> > > > >=20
> > > > > I traced the issue already trough the following code:
> > > > > net/core/net_namespace.c:355
> > > > > kernel/evl/net/net.c:35
> > > > > kernel/evl/net/ipv4/ipv4.c:41
> > > > > kernel/evl/net/ipv4/arp.c:323
> > > > >=20
> > > > > However, I lack the knowledge to do a proper fix. One way would b=
e to just check in evl_net_init_arp() if it is already
> > > > > registered and don't do it more than once but that doesn't feel r=
ight.
> > > > It looks like the system is instantiating multiple network
> > > > namespaces,
> > > > for each of which we set up an ARP front cache by calling
> > > > evl_net_init_arp(). Bad idea to hook a system-wide handler there as
> > > > well. Could you confirm this fix [1] works for you?
> > > > Thanks for reporting this.
> > > > [1]
> > > > https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/569beef06132=
1c2c00d775b13ad0aec1a1d2a416
> > > >=20
> > >=20
> > > Thanks, that was fast. The WARNING is gone now.
> > >=20
> > > But now after just updating to the kernel including your fix, I have =
a different behavior on
> > > incoming packages. It seams that the default when no filter is set ha=
s changed from EVL_RX_SKIP to EVL_RX_ACCEPT.
> > >=20
> > > linux-evl: v6.12.67-evl2-rebase
> > > -After evl net -ei enp7s0, I can ping another host.
> > > -oob-net-icmp does only receive packages when I use an eBPF filter wi=
th EVL_RX_ACCEPT
> > > -After that, ping doesn't work any more
> > >=20
> > > linux-evl: v6.12.y-cip-evl-rebase
> > > -After evl net -ei enp7s0, I can NOT ping another host.
> > > -oob-net-icmp does receive packages
> > > -If I use an eBPF filter returning EVL_RX_SKIP, I can ping again
> > >=20
> > > I am not using VLAN's.
> > >=20
> > > Was that changed on purpose?
> >=20
> > Yes, this is implemented by this commit [1]. The rationale here is that
> > if you turn on the oob port directly on a base device, then the evl net
> > stack may assume that the device is entirely dedicated to oob traffic,
> > as opposed to enabling such port on some upper device based on the
> > former (e.g. a VLAN interface). As a result, all ingress traffic
> > received by such base device is diverted (RX_ACCEPT) to the evl net
> > stack.
> >=20
> > [1] https://gitlab.com/Xenomai/xenomai4/linux-evl/-/commit/3026e69cee2a=
1de047818fa06ad8c44623461a0d
> >=20
>=20
> This makes sense. It took me some time to get evl reading packages by=20
> activating an eBPF filter and it's mostly save to assume that you don't=
=20
> have mixed traffic on an real time network interface. With this change,=
=20
> a filter is not needed any more.
>=20
> A bit off topic:
>=20
> Is there anything like rtping for evl? I have seen oob-net-icmp.c but=20
> this is answering requests.
>=20
> In Xenomai3, there is a debian package configuration. Any interest in=20
> one for libevl? I have one working but it's still very basic. If it's=20
> presentable, I can send a patch.

There is a debianization for x4 in xenomai-images already. See [1].=20
Can't tell why it hasn't been upstreamed yet. Maybe Tobias or Philippe
can comment on that.

[1] https://gitlab.com/Xenomai/xenomai-images/-/tree/master/recipes-xenomai=
/libevl/files/debian
