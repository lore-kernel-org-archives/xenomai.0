Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141005C8EB
	for <xenomai@lists.linux.dev>; Wed,  6 Mar 2024 09:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715640; cv=none; b=SMqRE3+o07nEO+HEazsml0XuNsVt+QFBxktvhNbUMrrvCKu1Tebn7QD/ox/NcK4Jzv6Lh9IqRGbhXmSldwshmKXxpZTz2QvRQA0pe87hii+TsY7Lq+ASQ6/2Mzm0c8Sjr7On3AGHnd8TA8XoiMwkk0MV7ehQWBEz80nSgOjRosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715640; c=relaxed/simple;
	bh=GwP+b3H9ZXM9IRvzfnyCPGzpKFnjeZ7pF1cSFBd0vWM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=XEtV2xvOyce5dl2T64iq3TwWzuF5HBsl62uIyJ1IFcm81Hdee9TrjcrFmA1Am+ON53h/Yhbz9KK6deUEwjeu10Bwi8r/RmUtnxTHl5Ggin8SdnbJ+sCsFkwXAhj9L+QeaWywUb6X0WEpq/wc/wQnJCr3qZQYrRJzQ9sx4ZNdXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412f988b601so727945e9.0
        for <xenomai@lists.linux.dev>; Wed, 06 Mar 2024 01:00:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709715636; x=1710320436;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcCwTcfs4FKJPy7H2W7B353beqPw4QIGSJmsFRcrJA8=;
        b=sjfbjPsR4TzxGuYih9v1Qh98nNLoigBhitV9ePVzZgTmyfGDlD7YxXJrd7XQQTRw4L
         bOUUllRmhrbKReeLage84Eh5fb4o8Q5iuuzBaRreSvpT1mkqlPF4gMrHxdpfC5SWgzhx
         4KoZNN67fqlclCF0bhcN/C2xyeMwoi9JZZot6Y0OnFaP/24hazrclCw09AoDYpH0+tjg
         ZftvVBgv8xyFHXOVKGtQY6ke/Y5lzOMxpRUtGR/yXYArHAT1uQY2V+U1Hfi3SszB56RK
         jv1Gsa5GkvdRdIQhTrhbjFnaqpSlXJnSbybS9hMhY1AVoFklSDdA0/pqT6M/4QhyyfgK
         TedA==
X-Gm-Message-State: AOJu0Yz7nLFzjlqr1lSYDCOoKuT/yv0Du0g7XjHyWg4u59OG5Bo+d0AS
	7tt4lvPjAwT9a6Zn0freRU87xtM8hjBuxyeJDbKyffC7BJxh/D7H0G1GwuA5
X-Google-Smtp-Source: AGHT+IEJZ1w+cBTMkBTiD6PVJQkKxW3k6X1HDkl6Fam84GvHKK/1LZUhVuh7EX+tBs3JeABkh0K8YA==
X-Received: by 2002:adf:ffd2:0:b0:33e:dd4:ca5c with SMTP id x18-20020adfffd2000000b0033e0dd4ca5cmr10002374wrs.45.1709715636018;
        Wed, 06 Mar 2024 01:00:36 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id cl5-20020a5d5f05000000b0033ce727e728sm4478103wrb.94.2024.03.06.01.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 01:00:35 -0800 (PST)
References: <74e8a18c-32c6-4bf4-aa92-215be1a91857@siemens.com>
 <7023067c-956e-45ac-b8db-7710ff53a001@siemens.com>
User-agent: mu4e 1.10.5; emacs 29.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@lists.linux.dev>
Subject: Re: dovetail kernel maintenance
Date: Wed, 06 Mar 2024 09:41:09 +0100
In-reply-to: <7023067c-956e-45ac-b8db-7710ff53a001@siemens.com>
Message-ID: <877cifwx8x.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 21.02.24 19:30, Jan Kiszka wrote:
>> Hi Philippe,
>> 
>> people started to ask about updates for our kernel trees, and you
>> mentioned to me before that you would focus on the last two LTS kernels.
>> Right now, there are to-be-tagged updated sleeping in 6.1 and 6.6 but
>> then also in 5.10 (all referring to the -rebase branches). Before taking
>> over 5.10 and 5.15, I would like to clarify their state. But I would
>> also like to know what is delaying the tagging of 6.1 and 6.6.
>> 
>
> Gentle ping for this question.
>

Well, my posts to the mailing list from my usual address have been
rejected a couple of weeks ago due to smtp authentication issues it
seems, which are now (mostly) sorted out, I thought you did receive this
reply as a direct recipient though. Looks like you did not. So here it
is.

PS: Since this reply was written, the x86 status with respect to the
Dovetail port to v6.8-rc7 has improved. Still in the process of
rewriting the arm64/fpsimd stuff.

> From: Philippe Gerum <rpm@xenomai.org>
> Subject: Re: dovetail kernel maintenance
> To: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Xenomai <xenomai@lists.linux.dev>
> Date: Wed, 21 Feb 2024 21:00:17 +0100
> 
> 
> Jan Kiszka <jan.kiszka@siemens.com> writes:
> 
> > Hi Philippe,
> >
> > people started to ask about updates for our kernel trees, and you
> > mentioned to me before that you would focus on the last two LTS kernels.
> > Right now, there are to-be-tagged updated sleeping in 6.1 and 6.6 but
> > then also in 5.10 (all referring to the -rebase branches). Before taking
> > over 5.10 and 5.15, I would like to clarify their state.
> 
> Dovetail ports to 5.10 and 5.15 are not maintained anymore, although I'm
> still upgrading 5.10 from time to time for work-related reasons, but
> nobody should expect this to last for long.
> 
> > But I would
> > also like to know what is delaying the tagging of 6.1 and 6.6.
> >
> 
> Those two have been tagged this afternoon. Dovetail maintenance takes
> time I must divert from my day-to-day workload where the real-time
> network stack for xenomai4 has precedence. The delay was mostly due to
> lack of basic testing until recently. Btw, the situation is going to get
> worse with 6.8 which requires a significant rewrite of the arm64/fpu
> support for Dovetail, not to speak of breaking changes in the generic
> entry path x86 uses.
> 
> 
> 
> -- 
> Philippe.
> 
