Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A77210F44
	for <xenomai@lists.linux.dev>; Wed, 11 Jun 2025 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660489; cv=none; b=Jne6MbzL2fwuFNdeQdBwDchfX7e0YIQqBI8jJo1TmLeMy8tlgG2hZSN86GPsyhrJ9vuZW/Sei3bscGur/RqksJJVMART73SdykE3fohwi+UrZaI+YTYnLR7aaPkf3Uh9UViStS4LxNSYCEkkIOgH4d1XVeEDsQ6YqjWpuZAYF+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660489; c=relaxed/simple;
	bh=4DkU6Mjq15BToEfghiP8EPrTrSOPGi95ywsofbf5gdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mFczHikDxDCdeXc8MVgSvrnHMYer8TALdq+icfXuB9o+26BQ9RNSAzYRN2fcxARy2r6L9i7ruVQ1OOJPGr3gsH+JaaG4fyM1cQvctyj18+wmRoHMr1F7ADk/3ICoobR5pJEZJSTfbyJ88kX2olORrm2MKGgI6s8m8TGmAfAWpEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=fhG6pu7H; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="fhG6pu7H"
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 6435C580D9C
	for <xenomai@lists.linux.dev>; Wed, 11 Jun 2025 16:36:55 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BC5844273;
	Wed, 11 Jun 2025 16:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1749659808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U9F5aSF0Qah40rqADLXWpS0HwBbFjoTIqukd1G4ShFY=;
	b=fhG6pu7HV3zwu0TvUNeHZmGC309iIsji5Z+wzyGNxg4f2O4FgDEW/LNZEwUdhqHq4N8Dou
	vZaDWyZSbLWyGxpB13Nb4aJG6y4lLxq7RaDvqbv6Bob3edhE+1enM3n1diGPmyyCzpVEwk
	ySmACfkm8UCbw7gNKvIJ5V/0VQlPWs4SovFZT3ANTlauTXKzJXDu2KTs/3d122sSUuv+Nm
	Cs6F8NHth7b0osnpFyKA7fB9fsRY5JoygUmYNfCwxP02ff6+UF0Ut+k00xEOCKtYiCOOF+
	RDjChUVMXLM4C7HdLfl1Amwfav9bgHY0nT6clcVGSv1lj99HZCcuh3s4paWdKQ==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: [PATCH dovetail 6.1-cip] igb: add missing header for oob
 extensions
In-Reply-To: <c564966e-2ca6-48f3-ae28-dd7707856f7c@siemens.com> (Jan Kiszka's
	message of "Wed, 11 Jun 2025 18:20:08 +0200")
References: <c564966e-2ca6-48f3-ae28-dd7707856f7c@siemens.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Wed, 11 Jun 2025 18:36:47 +0200
Message-ID: <87wm9i2q1s.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheprfhhihhlihhpphgvucfivghruhhmuceorhhpmhesgigvnhhomhgrihdrohhrgheqnecuggftrfgrthhtvghrnhepgfevgfefhefhhfefhefghfeikeffkeeliefgjeefheetieduveegfffgtdelveeunecuffhomhgrihhnpeguvghngidruggvnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehjrghnrdhkihhsiihkrgesshhivghmvghnshdrtghomh

Jan Kiszka <jan.kiszka@siemens.com> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Not yet tested, but this should make our pipeline green again:
> https://source.denx.de/Xenomai/xenomai-images/-/jobs/1166309
>
>  drivers/net/ethernet/intel/igb/igb_main.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index c0932a3cb220f..26be743f2a6cf 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -12,6 +12,7 @@
>  #include <linux/pagemap.h>
>  #include <linux/netdevice.h>
>  #include <linux/ipv6.h>
> +#include <linux/skbuff.h>
>  #include <linux/slab.h>
>  #include <net/checksum.h>
>  #include <net/ip6_checksum.h>

Interestingly, the original code never directly included that
header. The x4 includes it indirectly, x3 does not since it does not
use the oob netstack. Applying this patch, and forwarding it to v6.12.y
which is going to have the same issue.

Thanks,

-- 
Philippe.
