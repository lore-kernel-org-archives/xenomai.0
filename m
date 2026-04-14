Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2118935E921
	for <xenomai@lists.linux.dev>; Tue, 14 Apr 2026 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150582; cv=none; b=eHQv+fIBdSubZwxUl8+xXRyp2Fglnprsx7pDlhOdCO/f1/n6l1h1cy05EdbZEq2K6JdVUjNa6ZDJvCxNbJjEVnG43lU4OI7GVjXM+C1m5DDuPcMdhrNw07ov4A5oMQklJvOuuoccVm6NPuN09MW7mvWOufRVw4hzxAiO96ZXofA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150582; c=relaxed/simple;
	bh=GqaQ+AJMY6aUwbJVm0TkQ+G0i6LOxq2OJ2E0hTPpqio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IwrU+YQw7mU5P6bR5XFMvcOmjf52fO/7BHwaMawAbITanezK5c3VHsc2MMSyeU5KxXCoTCmu7kPXpBEITNo0qDcwKtSffomYQjJpC6SNQATLzMX/MsrrYHWYt+UX3bTTcL4rWg4BnMUV+xJdcccE/t3ddiMZrvb3lWlP2A5iRAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=YEFLaeae; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="YEFLaeae"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 2CCF0581A1D
	for <xenomai@lists.linux.dev>; Tue, 14 Apr 2026 07:05:51 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4CA293EC36;
	Tue, 14 Apr 2026 07:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1776150343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/3iEQF53DYmp78DVmXyaX2ah5BCsPe7act1zxUt0j4c=;
	b=YEFLaeaekdQ+VBwyYtcoIhB8ob/6rkT00tSGXTcP40o1jQb5SRvzVNtLQClXTsG+sc5u83
	kYOL4980a9TQ/WkbeGdIv9gJhuVUF0XrL5mrhIhSq7UOM222mTUYCAeAM84PkFg+0sFXDE
	nl238Pb8GGp31YRkl1AdbTdTgCdFFLx+jUb6U3kXfYUGrywlHF2sRJJEPWp3OAyFBSkTDn
	+fzKdd3rA17Nrkkd4dqhZxkz8ZJdsym4BzLqz1yHPp6wUh7Ek7wmMcykQneEQeM8o38FF5
	A27bu0butmLScKCzGVSZeHWyhsO3TaAZICQ9oIlONqr0bxcqGEtaDpo6/SlMGg==
From: Philippe Gerum <rpm@xenomai.org>
To: Jay Sridharan <jsridharan@relativityspace.com>
Cc: Brandon Ho <brandonho667@gmail.com>,  Brandon Ho
 <brho@relativityspace.com>,  "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>
Subject: Re: Minor page faults from memory compaction causing in-band
 transitions
In-Reply-To: <CY1P110MB0760484C0708C37BA89D5A02D624A@CY1P110MB0760.NAMP110.PROD.OUTLOOK.COM>
	(Jay Sridharan's message of "Mon, 13 Apr 2026 19:37:44 +0000")
References: <87v7e8yzhj.fsf@xenomai.org>
	<20260413181929.1801013-1-brho@relativityspace.com>
	<87h5pe7lvg.fsf@xenomai.org>
	<CY1P110MB0760484C0708C37BA89D5A02D624A@CY1P110MB0760.NAMP110.PROD.OUTLOOK.COM>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 14 Apr 2026 09:05:33 +0200
Message-ID: <874ile10oy.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTE/+UbRrV6KgnJ/Ud6L0Z5qNDU0BKUvqzXGKXsYLBr0bdJoJT4HJzMA0vvjH5kjVuTZ8GHdlkiMDLxQzCd5K/KzRF3vzW3OnJDUzJoY9c/AdXjv8Af2YIM6t5LorlgFkqIORTwjBBsBPNlh/sWTp1Ckg9KbEj1Q89RT+jRzQrolZEzzeCBliWfHRuLGbr3G4aupBJqQ7ccmh+7wvFIHcvnIyVF3rmoGnpUVgaUy6lQR7Zdgb0NM8SN1bzhcFuQ19p3vgP/YVcnDJ0580sZqQUnhQhbOleRVnrjT75ABuNcDVFjpzolcJ7vXQwszGyEjPViL06jsofVb0j0npvVIfnUYgHL+V7qfIc1Xc5HkWeSwpND5Rb0zFJ5t+VPaV7H1etLg2ZBgf1/2ZnQ8RnWDkw30V737YM2D49I5ze94typrsPFDfTv+R7KAmLO5fDjHwpeXFVExdFH9y9oX9RffXdiZugxz0pBns/0DtuzhWcN/bsPUqtTnF/8xQK3n+Z2zVpaDhTKGgSJnFg8vAkxuffa7TVfcO8bs/v06aTf0H4KMKt07CEtYiZ8l+i+WvpwZKSaUS6m6vIbgYxSKbFeNpjujRWejhCMLvqqEQxqrYcF43R8nlMSMzVKBsq+AMKNcNCHK4NYpkd1QIbL2h//jt2dpVBlcEmp0pUumK56V/9rVPQ

Jay Sridharan <jsridharan@relativityspace.com> writes:

> I think it would also be very useful to add these considerations to the "Caveat" page in the EVL documentation. 
>

Agreed.

> Perhaps some discussion on the impacts of CONFIG_COMPACTION, CONFIG_MIGRATION and CONFIG_TRANSPARENT_HUGEPAGE, as
> well as the impact of COMPACT_UNEVICTABLE_DEFAULT.
>
> I know the Caveat page already has an in-depth discussion of CPU isolation and SMIs, so it feels like a good place to mention it. 
>
> Is there a place where we can submit a patch to the docs?
>

Yes, please send a patch to this list, the markdown files for the
website can be cloned from [1].

[1] https://gitlab.com/Xenomai/xenomai4/website

-- 
Philippe.
