Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C920158D8C
	for <xenomai@lists.linux.dev>; Fri, 31 May 2024 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717162845; cv=none; b=Fa/oJHFo21j6yfM9KtG1JobSc5fMjxmz2FHK8CGbovA7He3SlfgV4AqDVHk4G/pKn+aQ1GYaR6yRcbEr32qXvCwA+Cicf6wfuNeJcaU6rDgwJguU7X9qDzvIsaybvgwmH5KfINlJN+yHQ37xagRlXpfmlmG3AqYMO7KzYQ8j2BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717162845; c=relaxed/simple;
	bh=qz+nrIi54ZDhR7911dTtttyaJdkEupNjlBjL0PGggoE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=emUPZ3a0QNsOESWKqWwc/iVnke6+w/lXHIXgFSKNr7V2wJYYC0UQ32PClAbxRLuccuAzYtwVP4yWKaC0iBrCPYpBT4zU7CJ2ydPEMSLwj7gdhBhNTwjOabm7rxirXNDEIXfbZW6t58k0qSpsnLTCQdpiEcqnZrGOXjYJ7sSlHzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=q6OoixFX; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="q6OoixFX"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20240531134033191b0b4bd3e680b22a
        for <xenomai@lists.linux.dev>;
        Fri, 31 May 2024 15:40:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=qz+nrIi54ZDhR7911dTtttyaJdkEupNjlBjL0PGggoE=;
 b=q6OoixFXS8SKAapK+6s1qntanvu7pTWlbpMBSwO3eXcA54kgNhs07DJJDKjG4C41lf9kQt
 DxnDjFdklBE24z8fnWsCzSJqC7sJpsvqlQsTo6XG0DYs55xXOLHvEq6tqP5KVPQg5IWzjqxv
 gM7OEMLSB4e4Rwy1bPia4IY6mqV7g=;
Message-ID: <bb2184c15e7a9d41530c301cc0362c8727253f15.camel@siemens.com>
Subject: Dovetail: Schedule for next -rebase branch updates
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@lists.linux.dev, Jan Kiszka <jan.kiszka@siemens.com>
Date: Fri, 31 May 2024 15:40:32 +0200
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

Hi Philippe,

is there already a plan to update all the older rebase branches with
the changes that went into the 6.9-rebase branch?

At least the following two commits are missing in the 6.1 merge branch
(and all branches in between), so they have to show up in the 6.1
rebase branch first:

- 1e530a1a ("x86: dovetail: fix interrupt state in int80 syscall emulation"=
)
- e5ca0681 ("x86: dovetail: fix unbalanced inst markers (int80_emulation)")

In addition

- 17865a05 ("x86: irq_pipeline: fix interrupt state in poll_idle()")

might be needed. I haven't checked yet which branches are affected and
would require a backport.

Best regards,
Florian
