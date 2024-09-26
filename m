Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0068176FA5
	for <xenomai@lists.linux.dev>; Thu, 26 Sep 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727353450; cv=none; b=HqmbL8QvcAB1boMNTJfUF2v5kRciS+R5rzO9sg5j1j7H4cknNDpvEtncRQ+tIYZXdHT6CHewDv+ldg8zglMYHBcE7sm7FN0YDErY/JDdWt5QzCusAh6wzyDvh8fOPxOgXDJ6nXD0yJpky1GSi5dZ+CNHjkiLzjJ/v+Lme0eSOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727353450; c=relaxed/simple;
	bh=AsXnfw0GLm0W1OOJb9SH8tNKNj9MITk2fJUd1qQk8fs=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=riMLcit3j9IVO1SKclc4tFQ5jAgwfhlKBdOftdcqYQtmsSIQ96WZYwww6D+OyjygrNfowXJY4e7Zzv23Rq7NGWSKQGutadkJN9TJ8KfF9ycnzVbRQ2BGwTVpExBnfXo2a8K+YMGgOLx54rbPL2m4fLPKwdwCoeAju6ptet50rlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=thom.fr.eu.org; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=GnPBzONR; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="GnPBzONR"
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id D606760129;
	Thu, 26 Sep 2024 14:24:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 48QCO5oZ250845;
	Thu, 26 Sep 2024 14:24:05 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1727353446;
	bh=AsXnfw0GLm0W1OOJb9SH8tNKNj9MITk2fJUd1qQk8fs=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=GnPBzONRoxAsYgUx3csokMtMbi4I8nHXFOnWjXIplOevEFemk0i67VChh9L0dP43m
	 H3kN+Y/2PK1lFUqWUdu0dgW7F1Un4oBsZWlyqE7oZtuwLZeK1+dctSGT6okjm7M4kz
	 jw8tX92j//Jys9U8OmsiFQx1/+Uo0p2v5Z/Xy2PLt+ghwqCt8PzU4odK5N4VJ/MQVe
	 +Aw2HHhrFM0zy04iTsQLGC19P7RV5ner4U/No3N+npMZf1Vsc/Dgea1dpZVicRSjmk
	 VyL02M7mGNZLoLJwMbDNRTMrvWjgkaidz5VMtkT7odqsOrg/ootVeTsW1SicLiXo5p
	 rpD1eRWc19xtg==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <9277fd2d-24b5-4d50-b768-5c8554e35d6c@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 147.161.180.114
Date: Thu, 26 Sep 2024 14:24:05 +0200
Cc: xenomai@lists.linux.dev
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <10db-66f55280-9-49b09a80@50985091>
Subject: =?utf-8?q?Re=3A?= Get wallclock time from rtdm driver
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean

Le Jeudi, Septembre 26, 2024 12:51 CEST, Jan Kiszka <jan.kiszka@siemens=
.com> a =C3=A9crit: 
 
> On 26.09.24 12:03, Fran=C3=A7ois Legal wrote:
> > Hello,
> > 
> > in my driver, I need to get the current wallclock value. I tried rt=
dm=5Fclock=5Fread, but this seems to be the boot clock and not the wall=
clock (the one that is updated by ntp/...)
> > 
> > What shall I use to get the actual wallclock value from my rt drive=
rs (the equivalent from clock=5Fgettime (CLOCK=5FHOST=5FREALTIME)) ?
> > 
> 
> rtdm=5Fclock=5Fread should give you CLOCK=5FREALIME, rtdm=5Fclock=5Fr=
ead=5Fmonotonic
> CLOCK=5FMONOTONIC. Which version are we talking about here? And which=
 kernel?
> 

I'm talking about rtdm=5Fclock=5Fread. What I get from that is about th=
e number of elasped seconds since system startup. Not the time correcte=
d from RTC or NTP.

I'm on linux 5.4 Ipipe.

Fran=C3=A7ois

> Jan
> 
> -- 
> Siemens AG, Technology
> Linux Expert Center
>

