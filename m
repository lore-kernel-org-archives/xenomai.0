Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09345AD38
	for <xenomai@lists.linux.dev>; Wed,  4 Jan 2023 15:57:57 +0000 (UTC)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230104155755f362ee708f5cf8f949
        for <xenomai@lists.linux.dev>;
        Wed, 04 Jan 2023 16:57:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=z0EUcCZCIDAvOaUu3SIVgGw4rcl6U8yjN2PU5SduBR4=;
 b=br1EgiuH4EGIySZBA1bVG9xhpIDYd+gTidx6Yagisfh2LFvwv22+0HSqNH9Gam99tVcsKs
 M7zGoZ7lCCndpS7VQfPWyq/2cq41uIvLNd1DHd9lbtQzVK3IlHM8Log0Xs9f0gHOrQZm7ePT
 G2I0s6Oh56TOKZ64UkqJnEBsTYTzE=;
Message-ID: <87d836c68358798cf64dfd1264974bd67cb6498b.camel@siemens.com>
Subject: Re: [xenomai-images][PATCH 3/3] start-qemu: Start with
 read-writable rootfs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 04 Jan 2023 16:57:54 +0100
In-Reply-To: <18e4ca3b65ab3881493b4e6a8d019cd62fe5efc8.1672845695.git.jan.kiszka@siemens.com>
References: <cover.1672845695.git.jan.kiszka@siemens.com>
	 <18e4ca3b65ab3881493b4e6a8d019cd62fe5efc8.1672845695.git.jan.kiszka@siemens.com>
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

On Wed, 2023-01-04 at 16:21 +0100, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> This is needed by systemd to initialize the machine ID on first boot.

I'm not facing any problem regarding the machine-ID here, but the LAVA
tests are failing like this:

2023-01-04T15:10:03 [?2004lmkdir: cannot create directory =E2=80=98/lava-69=
52=E2=80=99: Read-only file system

So, in addition to the qemu-script we might have to update the job
templates for the qemu tests as well.

I already added "rw" to the qemu kernel cmdline in my local branch, but
I updated to Debian 12 here and up to now was sure that this is
something Debian 12 specific. I have no glue what changed in the test
setup / LAVA installation that "rw" is necessary now. Any ideas?

Regards,
Florian



