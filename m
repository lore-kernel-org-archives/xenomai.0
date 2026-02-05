Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FE132ED51
	for <xenomai@lists.linux.dev>; Thu,  5 Feb 2026 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770331291; cv=pass; b=hqRN/vImzwjFYKH8YAbAiO/9rFK6UTbKZ+waSDyWTXiqMxaGhrnDYpFJwaJ0V0F5qrzL9V1exSmAb3LsWNCr0MhdptLWGuMPTjPjVBzv2iFvDmZRPbuRnfBVnyClLvfwtb789UuQaQhxiWH1KluLgXYUdkOJUbpeG/XlfdjPdew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770331291; c=relaxed/simple;
	bh=T0YrgFWYRIIppFjz0RuoahsanSSRttn7wQc/SAmiHZs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=j20MuOp3JjX2G0VCtvOGcROtNl7JWhhAEWHUZEuKsKR5Fml/DiKqOg4h9JzstkcXVfSlVqfFcsP0eK+1UFdc7ELwdsPyWOg5tfmHyQdC0ZEIyaCkdGEiZNFlVTO2uMtVi3qKn6gZHO1Gn3HPF079WYwDvt2794RfCOo1HUTod0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdjqUUXr; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdjqUUXr"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c61343f82d7so18420a12.1
        for <xenomai@lists.linux.dev>; Thu, 05 Feb 2026 14:41:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770331291; cv=none;
        d=google.com; s=arc-20240605;
        b=YQUQezZQ163VN4o5nsJvCgosztTjR6R4BXPlOSCQFDVf/XJQs20tQyXhESTsJVFFPk
         IRtisH7VunDEBr+K064nbjHSFCasJb5UIFehmZkR/fyoSJ840qSmCOkmciOdbCJVlYxK
         zAn8jPup1I9rAv/WkGy+SOpOL3GEdj3qsyPSm3zbA43LbZYAGH1HTPNjOR+p1yZmVlgi
         0nhQ3AvzCGme9LJ9D88bMyfPYcORWh5ZvEd1SUw81XWClrKpHMIRLneLXd689N7h3BIx
         rEkcvSveGPF4GcvwtOcF2uC9X6TLQQ91M93p98aWC6HhvEJOIdejQNGYFy4mLdLlmabi
         tSxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=DbNs3AVHySXoWvyVXjPJ93l9TrygcGFOn94Yes+Pl9A=;
        fh=tgwebcNkoJ2/NGSJumgP9lV3bKs+JVL5OrNDd1IgsQY=;
        b=BO+mSXe/7IQ48HYV3EtiPJshYSv+eWalLJf00/OQfCHgMVINxwPGTeIH1TUT+o3hni
         Wnl4zXjb+yTEB9ArvUJfEjqDWjIZ57osFRLyyDy90QH3IpFPV+6Usk52ikONYFLof25c
         Yryd/+xHBDLRMu923q8o81uMdmPt9XQqogD/oBeq0eyasPVBZdJLVSvCOA+cNICN3Jut
         lKqAGnce2eiz/dQVt3CUNFLDRPdk45Z7LEDWPweJYmgy46mEpYtvLp9sNXq/YSlRijfD
         ZgKF4B6nuKWXVawml6QJS5o3Iz1VQpsAMYCRVpIBVutHupWCi1tQk8oK+6gEHXZ0pAXD
         yVjQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770331291; x=1770936091; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DbNs3AVHySXoWvyVXjPJ93l9TrygcGFOn94Yes+Pl9A=;
        b=NdjqUUXrY/Uaeo93H5/soxIq/YEYJMvPF3oaWZKTHMhT0Axuaxq2McgSqYtJvsvBal
         x9KXyg5V7c7aE3PywLN29SymSjbSqbbV5Lyf5sbe1Soou3/2hjYCdzzz+eDP6ZJiy+5V
         T7zCKI9uhsGCrSOORQzksBMMcIB22Lthow3JhLtKzm5v3ETxMCFgiwKQ2Q4VjQojc5po
         EXHCFpEioYXgzW0WbBQlKEu0IOwHgpaxqu8f76eFs17vwG4KwEWvj/ZVINW0qVmKYyRv
         ehzfqdge7eNUR4R1iIVSRET+O0ANMuOtLkRgcZH3y52mVMSwm/sKChzPu871s9nrYXn2
         EMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770331291; x=1770936091;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbNs3AVHySXoWvyVXjPJ93l9TrygcGFOn94Yes+Pl9A=;
        b=afMoKbfG4enJ68JJqynQLdoM2YekWKxKBMF88FjiTJvSv/LT3fn/qQJJPSTSJ0vXBA
         9zYtiAncOIyZf5/LXIpi7wjByMZJSRmXM/76fgMrZ6R7CB8yt/kAZsFnUns9/Yc5BlHR
         P89PuWxK6u+AIYVmFFZEBOJ8+hr1dVhtU9haV6OBIU3L+S0XobY6KfV2uZw40DguRwTS
         UW0eVf6NCQSCKkrAzalfVmjMjtcUrgJXCBh8NvkzuKreWUTMB9NiLHn8ZiqU1siVXk1P
         OWGPE5O7bjCCRAnXTYnrc79R/IW2tTrLJ+JkY81QimtvBPbqVoPvwwl7g/TjhSwhm94Y
         88aA==
X-Gm-Message-State: AOJu0YwJCzTmFEfz8q6sTC4JsZjb0osjt4+g2WJpUWU1avK5ulorXnQ+
	N+zsINlii254FDK1IH0k4YT0gyMKkpz4YKhgOEwon3/g+4RUpOwOeFCX537YcLnXcHiHk2lLL8t
	U4gk0JgD6rCMCeNthrc6eE7mr9+Eq+0On82iz
X-Gm-Gg: AZuq6aIAclgOuDGIAP4/egizTJbAjIZuGCBpOONHqFde11Bgv+URrxyc4dadVjCjPSx
	BM8j7ns4O5co1CuI4zgjnsI6xiToxcIYom/YPmAG9u+M2dj4INVlz8zwCHmgYsAFki5C1RqpRoQ
	oTaS1A5pqEHhkBQoOSTt4hdk0TH8IRAzBSjSXIVjp8CyJeqoh+84p9hzUr3nXYXfTKbnDiHCfp2
	m841n3US7xn0zEgdamzcXDFWoywZhdwrW/Z/YF8GWU1BD3LKUr77qojIc7WZr30eC4cjmrOHyul
	qD8k2A==
X-Received: by 2002:a17:90b:48cd:b0:352:c995:808a with SMTP id
 98e67ed59e1d1-354b3c8c4f8mr412049a91.14.1770331290753; Thu, 05 Feb 2026
 14:41:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 5 Feb 2026 23:41:18 +0100
X-Gm-Features: AZwV_QgBrjH5UvOJo-qa1R9ZiFW5a31YNH6Ag5RjaIcYd105WnCerBBqEKsCOIw
Message-ID: <CAFLxGvxUmCjBJBrPFWrGDfPimmcL4=xwGGxcLwn3+1W1tUriSw@mail.gmail.com>
Subject: xnintr_enable() is a no-op on dovetail
To: Xenomai <xenomai@lists.linux.dev>
Cc: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Content-Type: text/plain; charset="UTF-8"

Hi!

I noticed that with dovetail xnintr_enable() is a no-op. Is this on purpose?
How to mask an interrupt line then?
Various drivers in Xenomai use the function via rtdm_irq_disable().

-- 
Thanks,
//richard
