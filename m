Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D1D22A817
	for <xenomai@lists.linux.dev>; Thu, 21 May 2026 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358162; cv=none; b=ldOXHBcYm1yOfARXfwFDEd4ATXmMuaEBhv1tal/5H9lIv4vdxKvH7dD9sQ4Ip4SxvEIjsG4epKt9cx0RxfbOrDzAj96xCt8ArzAv4kiAM7Y2ztXpzd9OqNGrJ1u+CwIYJqVOUHUVj21dT1VBXJavmS+M77s9ZUzWoLHwDd4GS+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358162; c=relaxed/simple;
	bh=JIpHZp75Wcv+g5oBjokx0cshD/ZXTA0TtXCMd7h/tZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IYsWouzMxs4rc0kGaB8nUC1WWja/HVs6UAjk+encbNL0wmgfQhSx+LhGs52WQ/BjbjtkPMO8BwaJkvDCzr2nswFguNvv98qyCMP3xGFDpEQbLx64JbVhTvr6MXsclzdT08s4MrXffschpSQ6S6EgfZX0hFe7q90wGMQ7F+9duu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=l8A1SNaK; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="l8A1SNaK"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id B8C7F582F33
	for <xenomai@lists.linux.dev>; Thu, 21 May 2026 09:49:54 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 83B613EBCC;
	Thu, 21 May 2026 09:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1779356986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sVsWM0u5tj2L4K9TGLwQ40OygAmfVL767lEBpvREyG0=;
	b=l8A1SNaKC+qVG5gD6fOBNONa6MOFUYk4lOadNvTZZM/wIJ008Lnx61yrte7hbJofYGguC7
	Y1Y0JFXzS7eYxVYH3V7ZIen1ulAlzhGMNfCC6wh7t4pzPyE00p844QWldIA05DVmmGD15z
	TJJB6sgBO7nyclHaI0GqW8+mOwkm+IpdQGvClAh+ocH5xG7Zgjv4dLPf1k59J1QJS5mIog
	QFO9j0bHy2Qo2tweJUWLab86rOiFAku1qDGrZaOXPjZeRjr5FMX07dj2Vbnx5DfpAwV2WL
	2iRP4xpkkFSrd6doAl7NKklJgKzUFY6022NgJ0hj0cZVPQ6ub1Q+Ib+6LfHiHg==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [EVL] Client UDP not receiving data
In-Reply-To: <6f9e6ff2-95a7-402c-90d6-19f0f89bbc80@gmail.com> (Hannes
	Diethelm's message of "Thu, 21 May 2026 00:03:16 +0200")
References: <6f9e6ff2-95a7-402c-90d6-19f0f89bbc80@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 21 May 2026 11:49:41 +0200
Message-ID: <87v7chf5xm.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTGU2j/sl5gJBeD/7abftp2CtfekTs+OXyR8seRP8zwDtd1ou0Z1vWnzStFiHC6Tg6BxekUC1yhcbz8188a7IE1hU9V8VWCdK+2g36jfT1Zd7EbJiQG6zMoIJUj1rmnRA78eDdpE2+1sm4j+8GWFNjeVks48kTfu/h90k+F/BEixwUfZJ7pW1BnxfMmOsGXZjWVRWlfT6qZ9tvO28Tzk8HvAAIG0R5RLc+M3knDgEPKkHGXsDWzoT5NAjaq4wdkjlIdDAug8JRpugEILsBFkw45xJn9kfRj9u0oE6zS9KhZWz/S9Lc31MX+tyVeOJ9C/iWrchtFWYhxVI7Q7ZoETUWnPaMlYPigRLTXjYSywCB4As/YPY/2MnHs9cyrnrx6/o3p8mxfLqsilfwgL5TcqGzhwUO4DqwBt9Vq/+nJSCu1qQl3nBgt8xIis48+XBOYvWpdxaRkJKy7kn3TD1350+R/QBy9s+lKovSTaj5rptciI+prK43pAL/vYLal5uf2vaihVRLAveLxgsN/LaLeMNNdoTaLKzKwZJvLW7RdL+TKeFt38ESkfhIqADpKLD6eCaWf/eraJs5OiuWMsgE5pMvQMUv/tDrzUfg+Dv1KOn0Vu4dxP9DqBqQlIaA/nBbnaDF3Hi00GQJE/vVjfEis0NYViFhD//wzjBjD9yQofxVk+mQ
X-GND-State: clean
X-GND-Score: -100

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Hello
>
> I have issue porting an application that runs as an UDP client to OOB networking.
>
> The standard client pattern:
> -connect
> -oob_sendmsg
> -oob_recvmsg
> does not work.
>
> In Wireshark, i see the packages going out and returning with the correct ip/port
> but oob_recvmsg() doesn't return.
>
> To debug, I modified the oob-net-udp example, attached. Additionally, I ported it back
> to posix networking where it works as expected.
>
> Send only mode / receive with bind works well.
>
> Config:
> Debian Trixie
> linux-evl v6.12.y-cip-evl-rebase 569beef0
> libevl r57 877d5ca
>

I believe oob-net-udp does work as is, but not the way you seem to
expect it, which led your to change the original logic so that two
instances of this program always run head to tail, each one running a
sender+receiver loop.

The original intent was to implement half-duplex roles instead, starting
each instance either with the -S (send mode) or -R (receive mode,
default) option switch, in order to explicitly select a role.

This allows for more configurations, like mixing the network stacks to
use for testing. For instance, we are currently able to broadcast
packets to listeners on port #42042 over the wire from a vanilla linux
system (no evl) to an evl-enabled one, using VLAN-based selection of
packets:

/*
 * From the vanilla system, through VLAN device eno2.1
 */

$ echo -n "Hello world" | sudo socat - udp-datagram:255.255.255.255:42042,broadcast,so-bindtodevice=eno2.1

/*
 * From the evl system, listening to all oob interfaces using VLAN-based
 * packet selection.
 */

~# oob-net-udp -R -a broadcast
== receiver mode (<= broadcast:42042)
== bound to port 42042
= 11 bytes received: Hello world

With a different setup, we could connect two evl-enabled systems, like:

/*
 * From the first evl-enabled system, sending through eth1
 * to 10.10.10.11:42042
 */

~# oob-net-udp -S -a 10.10.10.11
== sender mode (=> 10.10.10.11:42042)

/*
 * From the second evl-enabled system, receiving from eth0,
 * bound to 10.10.10.11 on port #42042
 */

~# oob-net-udp -R -a 10.10.10.11
== receiver mode (<= 10.10.10.11:42042)
== bound to port 42042

This said, if you believe that a dual role setup like the one you
suggested would be nice to have to users as well, we could add it to
oob-net-udp alongside the existing half-duplex modes. For instance,
omitting the -R and -S keys on the command line currently defaults to
-R. Instead, we could select the new "dual role" mode.

PS: please send (diff context, -u or git-diff) formatted patches instead
of entire modified files, so that we can immediately grasp the essence
of the proposed changes. Also, please make sure to separate unrelated
changes sets in distinct patches (e.g. those changing a particular
aspect of the logic from others which may be coding style
fixups). Generally speaking, we follow the linux kernel coding style and
process when it comes to submitting patches [1].

[1] https://docs.kernel.org/process/submitting-patches.html

-- 
Philippe.
