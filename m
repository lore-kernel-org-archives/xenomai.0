Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F61B33DC
	for <xenomai@lists.linux.dev>; Fri, 25 Nov 2022 14:11:23 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20221125141120ca90dd71506696a921
        for <xenomai@lists.linux.dev>;
        Fri, 25 Nov 2022 15:11:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=mKFKP23dymGt/e6/2XMH9xjwxTjpj9CNu/GrRbQt7WQ=;
 b=gJFs3GlcTA8F/WPkXbnjCt0NTLAfXSnvAx8Rs6kOYrSi17sbJtmGQY6YhGzM9TnvC6k6v9
 kbt4WW5ADxICUCna5+dJu75olY8WyvFcwcbbqZtWE5P56MDt2qTctHon54Cwer1D0ZyXUKcv
 hk7XwntubljckGb1A94h4Vrh6sVlg=;
Message-ID: <c7b9c30c4f0685adbd3f3829b9bba4b42835177a.camel@siemens.com>
Subject: Synchronization request of supported ipipe kernel versions
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Greg Gallagher
 <greg@embeddedgreg.com>
Cc: xenomai@lists.linux.dev
Date: Fri, 25 Nov 2022 15:11:19 +0100
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

Hi Jan, Hi Greg,

while tracking down some ipipe issues that appeared while trying to
modernize the CI toolchain (Debian 11 =3D> 12 update) I had massive
problems with all the different kernel versions that we have for
different architectures.

Currently we have:

            4.19             5.4  =20
armhf   4.19.229-cip67+    5.4.180+
arm64   4.19.144+          5.4.180+
amd64   4.19.264-cip84+    5.4.223+


Might I request to synchronize them?=C2=A0

It would simplify things a lot if=20
  - all 4.19 versions would be based on the same patch level
  - all 5.4  versions would be based on the same patch level
  - The 4.19 and 5.4 versions would be based on the same stable=C2=A0
    patch set. Currently 4.19.266 and 5.4.224 are recent versions
    with the "same" set of patches applied.

Concrete example:

I had to update my 4.19 baseline to recent 4.19.264 to make sure that
I'm not hunting for something that is already fixed. With that I pulled
in the following upstream commit:

211565b10099 ("serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottle"=
)

This commit breaks (or will break) the pl011 driver in case ipipe is
enabled. It is part of 4.19.253 and 5.4.207. The only tree that already
has this commit is for amd64, but it's not a real problem as x86
normally doesn't require this driver.

a) I'm currently not able to fix that for arm/arm64=C2=A0
   (too old but not yet affected)
b) If 4.19 and 5.4 for arm/arm64 are not based on the same stable=20
   patch level I have to backport for each arch/ipipe.

Let me know what you think!

Regards,
Florian



