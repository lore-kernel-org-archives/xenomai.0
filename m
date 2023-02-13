Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147E01FA8
	for <xenomai@lists.linux.dev>; Mon, 13 Feb 2023 08:15:24 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2023021308152266bacc0cd34052d80e
        for <xenomai@lists.linux.dev>;
        Mon, 13 Feb 2023 09:15:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=5w7OJFPMJycCpjQMWUmt3y/aO6CnEF6/Ik509+gmEDo=;
 b=ZeUwAsWtAkYhytZnXu8uXrqOkS2TOcSZLRPVTqLbsrnQuGdnp4RwlNAfhRwryS2m9o/Ksh
 ceE5GxgRP4fJG0mHBxah0GNi3vRoKz7+Y7P9P6PRL2uJQxL8WdFCFptZksM/znpDjtcj5bGq
 me1LaptEeXGOJ4w7wVp1wUiotELtI=;
Message-ID: <a7be0590fd6d9d44ea52b0129fdf49870b696e84.camel@siemens.com>
Subject: Re: [xenomai-images][PATCH 4/7] ci: Hook up kernel 6.1
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Date: Mon, 13 Feb 2023 09:15:21 +0100
In-Reply-To: <5573a966fecb301447eb73ea3350ff5f7b986bf0.1676271676.git.jan.kiszka@siemens.com>
References: <cover.1676271676.git.jan.kiszka@siemens.com>
	 <5573a966fecb301447eb73ea3350ff5f7b986bf0.1676271676.git.jan.kiszka@siemens.com>
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

Hi Jan,

On Mon, 2023-02-13 at 08:01 +0100, Jan Kiszka wrote:
> +lava-test-6.1:qemu-armhf:
> +=C2=A0 needs: [ "build-6.1:qemu-armhf" ]
> +=C2=A0 extends: .lava-test:qemu-armhf
> +=C2=A0 variables:
> +=C2=A0=C2=A0=C2=A0 KERNEL_VERSION: "6.1"
> +
> +build-6.1:qemu-arm64:
> +=C2=A0 extends: .build:qemu-arm64
> +=C2=A0 variables:
> +=C2=A0=C2=A0=C2=A0 LINUX_BUILD_OPTION: ":opt-linux-latest-6.1.yml"
> +=C2=A0=C2=A0=C2=A0 KERNEL_VERSION: "6.16"
                           ^
I'm quite sure we have a typo here as this version does not exist
yet...

