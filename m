Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981AB84D3E
	for <xenomai@lists.linux.dev>; Mon,  1 Jul 2024 07:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719819599; cv=none; b=A6Smza32BE+VjlJxMeF/3t0wvoIH3DKdeDxMRes9kNdEKCid9yfuB0694eP4aYcCvx4LdVBcJlMH8OD+4UUBa6q5cC6ig2AymsMh95xuKhkyPqDz3W5PhIxGvXSrRPpAsDjKQhbbi2I0UX4paE0O0+jH2KZTMLn0j6GrH4bUsGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719819599; c=relaxed/simple;
	bh=VyYKfk2ykc8JquJc1fJR3AVQWDR+GJ5gmheumrJ5xEU=;
	h=From:In-Reply-To:Content-Type:Date:Cc:To:MIME-Version:Message-ID:
	 Subject; b=mceGr+qkR6WK1rR/8r8CRoohPy2Hpbn2xnBZJeQCynOb+VxKpS8LAxAKFa5hWiOWbynwnd60j8/R5xnt1abT47i06Od9cK86Q6fgixlRVHU8JSBXzQEMN9X3ISmCmXPwSz7K7MoKAeB0WpT8koWCjrqRm2xW8dyAOFwj7YE4uck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org; spf=pass smtp.mailfrom=thom.fr.eu.org; dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b=fHKSLnDZ; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thom.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=thom.fr.eu.org header.i=@thom.fr.eu.org header.b="fHKSLnDZ"
Received: from mail.thom.fr.eu.org (unknown [82.64.149.25])
	by smtp5-g21.free.fr (Postfix) with ESMTPS id D101160128;
	Mon,  1 Jul 2024 09:39:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.thom.fr.eu.org (8.15.2/8.15.2/Debian-22) with ESMTP id 4617dqLI126568;
	Mon, 1 Jul 2024 09:39:52 +0200
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=thom.fr.eu.org;
	s=default; t=1719819593;
	bh=VyYKfk2ykc8JquJc1fJR3AVQWDR+GJ5gmheumrJ5xEU=;
	h=From:In-Reply-To:Date:Cc:To:Subject;
	b=fHKSLnDZUQkEVLvhW7y7yxiaHG1h3xDJnKAkHz3u5JMaXXjBI8OH+gB1spUKSQH5U
	 m0M7bj5TxJ0eb82mF91C9rZuy/otWEGcZw2BOCfSRlLz4y18QYZh2Z1/Mw3ww+F05Z
	 nU5dpFgksJbFkPcBSLSIKwqqIFJwQYCmy02NsdqewDVR04wiYzTbvU7qqlxWPRrkH4
	 KbLkcYMEQ9eHLapX4XmMf186ssGWi8RDCqkaLPRqMJEZcT1iz1gW/hz5pLCeKn31Ga
	 s/LomE5V/DbF87SkWUYwLuzPrSDm1VOuh3dWUYRvZIAIeGrq3JXGQfnTJykXXWtCxS
	 2DO64Xwq7+cBg==
From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <31c548fa-5b73-48d6-952b-2233fb3f0ea1@siemens.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 217.109.173.233, 165.225.204.113
Date: Mon, 01 Jul 2024 09:39:52 +0200
Cc: xenomai@lists.linux.dev
To: "Jan Kiszka" <jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-ID: <10fc-66825d80-9-27de53c0@198494853>
Subject: =?utf-8?q?Re=3A?= Thread safety of cobalt syslog/syslogv call
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.10 at tls-srv-03
X-Virus-Status: Clean

Le Lundi, Juillet 01, 2024 09:24 CEST, Jan Kiszka <jan.kiszka@siemens.c=
om> a =C3=A9crit: 
 
> On 01.07.24 08:47, Fran=C3=A7ois Legal wrote:
> > Hello,
> > 
> > I was wondering whether or not the syslog/vsyslog calls in cobalt r=
untime libs are thread safe. I observer strange behaviour in my logs un=
der heavy log load.
> > 
> 
> Can you be more precise in what you do? And which parts of
> lib/cobalt/printf.c you consider problematic /wrt thread safety, the
> printout to syslog or the wrapper functions themselves?
> 
> Jan
> 

I have a set of threads that would each send to syslof under certain co=
nditions. In my syslog, I can see a bunch of truncated log entries. I'd=
 first though that maybe RT=5FPRINT=5FDEFAULT=5FBUFFER & RT=5FPRINT=5FD=
EFAULT=5FBUFFERS=5FCOUNT would be too small in my application, but incr=
easing those values did not make any differences.
I ended up looking at the code and got to vprint=5Fto=5Fbuffer that sho=
uld be called when I want to send an entry to syslog in my RT threads, =
and was wondering (I believe it is not) whether or not this function wa=
s thread safe.
Am I getting something wrong ?

Fran=C3=A7ois

> -- 
> Siemens AG, Technology
> Linux Expert Center
>

