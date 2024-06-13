Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BF6137C27
	for <xenomai@lists.linux.dev>; Thu, 13 Jun 2024 06:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259537; cv=none; b=uGZZlwKLcSkAdo+sqSlal1gF1gtErqhBNPhGd5kxq2ggN/7ZSq08UQOdvmKhcbmLCFEiuZr5D+E2xC1XQGJFWmSPditm/389nVkKc3rn7a8+nsFs6TVueREpkFa5Mm4XebvpTtbzTrvk8KOA9GUEgl2Wk4SehzoXlsRLeHEcJy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259537; c=relaxed/simple;
	bh=if8zy47XVu0s5c9QivWuWlVbKbK+7kBrQL1IN9lQTXo=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=NMEq/RYd5ev/ClC57X98lNQymmchS3VeOtr6XMjJrF4L/sP4U1HOT7UKdiaDqC7adcuDlXXavSZiIlvg/Mdr+vCpgU0U5fsjD/Y9p6+uEYVsoTnJA0MhY6jZ0qrWvjqJm5RIFXwzd4ukcza3EgVCqOvFZTFWkOTyqwKvUNepWPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=thom.fr.eu.org; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=X83u2d2y; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="X83u2d2y"
Received: from mail.thom.fr.eu.org (unknown [IPv6:2a01:e0a:2aa:1dd0::2])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id 46F9B5FF3F;
	Thu, 13 Jun 2024 08:18:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 45D6IiPo445367;
	Thu, 13 Jun 2024 08:18:44 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1718259525;
	bh=if8zy47XVu0s5c9QivWuWlVbKbK+7kBrQL1IN9lQTXo=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=X83u2d2yJxMzSAxBPmkgUQ8Y+LUubRxSrbn6dUT+5XlXaDnCi3nVjDGyW1TzJAJK6
	 J7RdrkUOxWUIduyUQ0M2w1HV1OsYrZTdy0c1jSVSoS5l3fIJZ0Viv6YfLsI5NaLRmJ
	 dJ7bydUlJZRyJj15bvl0eJgXWEup7/9sMZd2udr32BUgCY07fzf6KGnHPhx+LyzLp4
	 1rbPLd3WsaUdpYXvBmS8sETOCBhhqxVhtO+6+O7R+2klD5Jf4LuRjdOhqJGdVgeYUQ
	 9JA+nP1XiAtwoj1yvRqL2SvoijAPVlNhiFGjbLJx58/ka9s91IC3AWfpriCMjKyB9Y
	 HerEf3IIyOVjQ==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <871q52ry16.fsf@xenomai.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 147.161.180.87
Date: Thu, 13 Jun 2024 08:18:44 +0200
Cc: "Richard Weinberger" <richard.weinberger@gmail.com>,
        =?utf-8?q?Chen=2C_Hongzhan?= <hongzhan.chen@intel.com>,
        "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
To: "Philippe Gerum" <rpm@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <1157-666a8f80-f-41294d00@43403104>
Subject: =?utf-8?q?Re=3A?= Porting RT net driver to dovetail
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean

Thanks for the clarification.

I'm not sure I understand the sentence "ATM, we only have a real-time c=
apable raw socket interface".
In my application, we only use RTNET for level 2 communication. Is this=
 already available.

And so, back to the original question, how do I transition from an RTNE=
T/RTDM NIC to an EVL/??? one ?

Thanks in advance

Fran=C3=A7ois

Le Mercredi, Juin 12, 2024 17:09 CEST, Philippe Gerum <rpm@xenomai.org>=
 a =C3=A9crit: 
 
> 
> Fran=C3=A7ois Legal <devel@thom.fr.eu.org> writes:
> 
> > Well, I'm not sure but last time I checked, RTNET would not be part=
 of xenomai 4 IIRC. So I guess EVL is the way to go.
> >
> 
> Correct, this is the one providing a real-time net stack based on the=

> dovetail net services (which RTnet does not use). This work is ongoin=
g
> (see the wip/net branch of the linux-evl tree). ETA: mid-july for a
> complete UDP stack. ATM, we only have a real-time capable raw socket
> interface.
> 
> -- 
> Philippe.

