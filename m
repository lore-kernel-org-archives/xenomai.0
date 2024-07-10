Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B847D6F30D
	for <xenomai@lists.linux.dev>; Wed, 10 Jul 2024 06:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720593639; cv=none; b=A1m/gwfT5vQ1sKORhGFypz0Rrgc5kEy/u9KiAFtAsElHeZaDGOl/9U7V7Z07oCSAGfN+hRVqvweYhJtEKKkr5djS7zxl3VM6bTGVmmLp3hO+dCTFA7k+Jcjc5RUyKDZbglJUaOEFDlLz5SctCgfs1Yf8+m8LA3fLG1Ynjr8FyW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720593639; c=relaxed/simple;
	bh=+ZVfHKFAgDa1tdcmywLj7zwCtjVXgj0Zyy6n/mLmbPc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oCO2WUOuJUNSzRjGZXKRArpWnCv19wBtkwhoaWvxK8r/yAbmM8O1tjbLjAgX4H6xvtPwnTjKdaWsEzEtLWuJ1y8AfmQVqspEngluURIHdBVpjKCzODloJxCAk0QLsiK7CFJ1HwBFEZz0b072G5F0xG2iiZ9m80e6LYP127uH3TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Xgrb+EBZ; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Xgrb+EBZ"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024071006402380d3758632aa402edb
        for <xenomai@lists.linux.dev>;
        Wed, 10 Jul 2024 08:40:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=XkHrk/Or2nrii01Lpr98iZX91gqE3XUhkAfU9H52RFI=;
 b=Xgrb+EBZ8SOb+16pzyjR9XpoYoTh2VadMhL4ilG1ls81/oaEzwsYOtI76LI1SLpH3j5K2R
 wJZnqpX0NKIMqSg2g8Bsqln132tdNyAXfO5p8ZZGsh4KPv6W9o9RxNO7HcrOzRmSsfnmUFdL
 Um39Ledr3cMSrvZQ88PqwhLLTLrBY=;
Message-ID: <80eff86812374901683c946d1086e478ed3e0da1.camel@siemens.com>
Subject: Re: [PATCH 2/5] ci: Split kernel 6.6 config into physical and
 virtual targets
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Date: Wed, 10 Jul 2024 08:40:22 +0200
In-Reply-To: <20240709083524.739194-3-tobias.schaffner@siemens.com>
References: <20240709083524.739194-1-tobias.schaffner@siemens.com>
	 <20240709083524.739194-3-tobias.schaffner@siemens.com>
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

On Tue, 2024-07-09 at 10:35 +0200, Tobias Schaffner wrote:
>  build-6.6:x86-64-efi:
>    extends: .build:x86-64-efi
>    variables:
> diff --git a/ci/kernel_6_6_physical.yml b/ci/kernel_6_6_physical.yml
> new file mode 100644
> index 0000000..95fc4f2
> --- /dev/null
> +++ b/ci/kernel_6_6_physical.yml
> @@ -0,0 +1,36 @@
> +#
> +# Xenomai Real-Time System
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Jan Kiszka <jan.kiszka@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +build-6.6:rpi4:
> +  extends: .build:rpi4
> +  variables:
> +    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
> +    KERNEL_VERSION: "6.6"
> +    CACHE_KERNEL: dovetail
> +
> +lava-test-6.6:rpi4:
> +  needs: [ "build-6.6:rpi4" ]
> +  extends: .lava-test:rpi4
> +  variables:
> +    KERNEL_VERSION: "6.6"
> +
> +build-6.6:beagle-bone-black:
> +  extends: .build:beagle-bone-black
> +  variables:
> +    LINUX_BUILD_OPTION: ":opt-linux-latest-6.6.yml"
> +    KERNEL_VERSION: "6.6"
> +    CACHE_KERNEL: dovetail
> +
> +lava-test-6.6:beagle-bone-black:
> +  needs: [ "build-6.6:beagle-bone-black" ]
> +  extends: .lava-test:beagle-bone-black
> +  variables:
> +    KERNEL_VERSION: "6.6"

This file has to be renamed each time we get a new "latest" kernel
version and the file content has to be updated as well.

Maybe it's possible to couple that with LATEST_KERNEL_VERSION? This is
the way we limit qemu build/runs already.

End result could be that we only lift the variable value instead of re-
arranging code for each new kernel that we support.

Florian

