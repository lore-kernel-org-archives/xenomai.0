Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8C8336EDA
	for <xenomai@lists.linux.dev>; Thu, 10 Sep 2026 05:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789019613; cv=pass; b=PO/aC28H30OOhWhlnAR0ktPy6rNW4Wxh70z+t+70kegUHscxvStJzlNZW4wLkETdVWp57poAKtlMdh8utvdVJjHmVQJTS4+oq0U74i6yec1GOzodVTbKX89SWPr8Eo78wPhuoWzrq693guGL5ZimfoavKJlOFOBRDJXo4nfKdNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789019613; c=relaxed/simple;
	bh=041ZWbHnXNig20CdTTYnRwPyLEd3yVpzxVDcTBvgPWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXpr2Yw/y4/tuWf2Eajt+kkPR9VSuodVRh9+ppwJB2gCt95CrEorxn50yyHg20HV4pHckqQ6By0Hs1xAOw0PNqG2/ILrlLD7I4Yz3BxOBPUgWD5/ZXIyAaJBrIwTouGGzQrt/UMkX3VeaYQ4XEQnG10pvg6vfm/5NeLTYNVBmVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com; spf=pass smtp.mailfrom=lmitechnologies.com; dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b=FQOjDBnK; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lmitechnologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b="FQOjDBnK"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a9983162dcso1992116a12.1
        for <xenomai@lists.linux.dev>; Wed, 09 Sep 2026 22:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789019609; cv=none;
        d=google.com; s=arc-20260327;
        b=A3QrWIv2J5/1jcsZzdUe2mQzeqDqlUBUjNRYMYXz3QyGWb++2HHGkfYFVvb95DTz3B
         TtoQ+QEcEl9ANAVwXZGDIVL3cCRW81753zDDXd+VlmAfLUEhwc31Y4JqVryFrgn1Jiqb
         y04se8t7bTyR98A3rCWvftSAr9vZZrAdHlynfmI/xesl8nu4cszFRJuTlJG7PRUY+3sp
         vkWZLpG5oNuq3i6VN9yIuD3PqrvuNy5nxybIoVDfcjTpyYQ//FJQc0LZwaX/ksaN4rYi
         J5+FSDY+MEB2dk0FbLYqN8J9BCRL2MDxVZl/OuBBoIdqrCAY34XA8LReIsGaWSt9OA4g
         Y3kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YxX8M3Nqts7Dr4zxYqnN8NJUVH9u6MrDevOgWXZGllQ=;
        fh=OYGbdDOOPOd5R8onVcDt0u4Fd0R4j7YxJAFw1KOHXFQ=;
        b=TacDz2eMDLHcg3LSq3DMKFHOZnGbwkC2Mm4ZjjScYyK0dn0FGZh5VHrTk5QOT49+Rl
         VzqME6IVp8OOXW4QvlgtyfhC/O2UmICH3rmBRqy+JpEgSbgl7Eegn6HPGe/Ck6dhlGS5
         /0Hkq9YPK4q2Jk8YASc3q2mhIaIYkWUh40A2Z9dcMiW5U5+jiy5wXXRiHjCZsXbkr1LD
         +sli6PRGJxk7pgqyac35lyR6kNmlzYr9pn6ZCZ0dOsy9jA6v8+P8m9KpA9tn+7sGx2xq
         LXk5hM5lGLwjDcOWH12IvKXSderQzjDNxJQxy7NmCCCyqSHFJlCftVrks/vpKCO9fqfQ
         ZGJQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lmi3d.com; s=google; t=1789019609; x=1789624409; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YxX8M3Nqts7Dr4zxYqnN8NJUVH9u6MrDevOgWXZGllQ=;
        b=FQOjDBnKxWvlJoQXYVEhdEj9A1VWQeSOrp1nC2Iz2W0mlJmbUik0zo2wf4PSnjTsyK
         kbAHjSFVTaWr2bR2zl+E3Z0CXfEa65z1/bIkpmiDE7y5lvJYEt4IFWnANcIQH3U4W2cl
         bsmrS1wQJ5bE9n9uJ+Rz7mYulLaYz4ZkZAEOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789019609; x=1789624409;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YxX8M3Nqts7Dr4zxYqnN8NJUVH9u6MrDevOgWXZGllQ=;
        b=XX9FFkoAO63VWVOcDokIBvZ2qHrzCPMsafA7G1uv6GYqu/I/mKByKfr0sDGawTEgxS
         PipSo0lHAIdlPmQAwZHzsg0RJT9HT0gougdqwUNlTcd2Lj6zMQRFfFs8ugqNsgZrEB8G
         1W6mSys96uK+0DvnHuWskL7s6L3NwYDwICVdfXf+KfJGWePudDTOSDEwx917t+hmQAM8
         jHqvLsMRboZjYTbh/r9gK7Ibrhn6Gn1fDxBnq+l7me+EvfHCemE0ae2RgW0qJXG8i/EB
         S2+32Y1U3kLzgh8xjCikr3q1YGdkPLugYVl/bbJmCPSko24rlrtItqk+GKyHsRBrIlJd
         HVrg==
X-Gm-Message-State: AFuF++mSIFpmZDEDCE5eMzKVq+G//P/kmw+MRkFh60VKvTSBu2n/8ZkR
	yx0G432iuI0D4MqIG13VQQCB1h5ytSkXIQB4M/a+mNtrDYxMwsKJLL45lFXqRspf5s95MpTMdS1
	rI+0V1jGkdYu4I/hMf332vQnN3Vz8uE0p3LJrEFO1DI4+DCOVjsg9429GR6nxR2ACzvGJFm4ubd
	vfKxzbN4+XsIVZ6Tr51IfJCUzqy7/gPN9vUktsDRClSBC1lfeQsRkQ6OhcJ5mKg7lYUPadv4OKt
	kq1GBT1+Snlw3ZY9mLvnp1ImS8nEyrRXgv2kR011kWJQsdKZw==
X-Gm-Gg: AYBFou3ZMUJ6RHIReIdB6DNeTGTZ3NlAtD8mAsEeDKbXtcu9soO/RN506DgApqac27R
	P7jQdJymG1egNY7dVX+c2X+lnx205jYrlvSZt21kOc2n7x1KxhKMQyTqSs6nVSQehIbUts6TGKH
	KDPANe4VHuFD77MA6OpAiVkyv+jSL7TnEduxQWuNjZEQXL5RpNyK3ExEVHW/qUgKwYX3K+8AV1f
	JMQ6mtL166DaIGDtDkxupsTD1lcQcqBH41r3V7J3skzOFBZ/k8fVLu97/kvz8OtL3u6iIW/CjEH
	+3L+deEgoKd0P5Zk//aryjHY16DOP0CCuDBGI3EbFnYhKjyqUcCEmWvC/hlJQYPhyfOWUB/9H69
	7VC1cLs/jnhSFPGDf9zZNoZYO7dIN/TvKaSz6yAcAFdNEjtfsAPJT1qPM+GBoWNrTIH41UHLbQy
	k=
X-Received: by 2002:a05:6402:20da:b0:6a9:ab34:cf67 with SMTP id
 4fb4d7f45d1cf-6a9ab34d133mr100245a12.36.1789019609661; Wed, 09 Sep 2026
 22:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260909-wip-flo-v7-2-irq-cleanup-v1-0-825a908785ae@siemens.com> <CAKndYJF986dZQDMQEm8A=w-6LOSZkZ3+nkKyVukwZww+OUwWjA@mail.gmail.com>
In-Reply-To: <CAKndYJF986dZQDMQEm8A=w-6LOSZkZ3+nkKyVukwZww+OUwWjA@mail.gmail.com>
From: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Date: Thu, 10 Sep 2026 07:53:17 +0200
X-Gm-Features: AcwNN1WoMe2dCX3G12Jr4VQW4IR3ACIXEgOL3aY1Ga66canI-lhIqmm9ILC87FI
Message-ID: <CAKndYJHFLPFMG5t2TKHZSE7DvnHaLZbf=rnLbinrPgEtgw4ttw@mail.gmail.com>
Subject: Re: [PATCH Dovetail 0/2] Obsolete marking tick IRQs with IRQF_TIMER
To: Florian Bezdeka <florian.bezdeka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>, Philippe Gerum <rpm@xenomai.org>, 
	Andrew MacPherson <andrew@elk.audio>
Content-Type: text/plain; charset="UTF-8"

Hi Florian,

I ported our board support (US+ custom board) to Linux 7.2 (base
commit 58e8e0f74) and started testing your patch.  The base commit
reproduced the issue. The patch solved the issue.

Awesome.
Thanks,

-- 


This
email and any attachment(s) it may contain is confidential and is 
intended
solely for the use of the individual(s) to whom it is addressed. 
If you are not
the intended recipient of this email, you must not take 
action based on the
contents, nor distribute, nor expose any part of the 
content(s) to entities or
person(s) beyond the original distribution list. 
Please contact the sender and
delete the email if you have received it in 
error. Thank you.
