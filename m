Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F81FB1
	for <xenomai@lists.linux.dev>; Fri, 31 Mar 2023 08:02:54 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id CCA2DE0005;
	Fri, 31 Mar 2023 08:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1680249773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hFubsCw/czv3BubtcUW+DpDB76WjANltQ/BkWQROJJo=;
	b=J6vzDGtidsAe6oSG6Q5Y+lzYMblpaPwMHqx8ZMA5BPOPebyS5vnPMVug5tGpi8tiSlwJ/e
	8deiDTn5LOddyfJuSxITzrMTlr51s6Dqui6reLAkf655sj+S86Zs7cd4mJGyP1n9/pSTO7
	zyb8cuQjTMihKasoF6ZR5Rodf0K6wHa/VEBKnGKzTt6/sexAbB8YUjfzkZv98iZuXMIUo5
	cT0EIbhCMpzkJvTROYPXWoFq1SDwhSf0VGz7XSdIYcERBh9mpeqOmugWMy5NVqfSYS9Lvi
	4pOR+nh5vRoOn7zZAMIupSxabm7NFJyB88UU/btHu99HRZAxj7y9XHDr6jeAug==
References: <PH1P110MB10506A8CC6DE166D6C3889DBE28B9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: evl ps - round robbin
Date: Fri, 31 Mar 2023 09:57:44 +0200
In-reply-to: <PH1P110MB10506A8CC6DE166D6C3889DBE28B9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87cz4pic0j.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> I have configured one of my EVL threads to be round robbin using the
> evl_set_schedattr call, and I have verified it is getting set properly with
> evl_get_schedattr. However, when I run evl ps, the SCHED column still says
> FIFO. Is this expected?
>

Yes, it's a short-coming of the EVL routine exporting the scheduling
information via the /sysfs interface. As a matter of fact, a thread
which undergoes the RR policy is actually managed as a FIFO thread, with
the EVL_T_RRB [1] modifier set, which enables its round-robin timer
internally.

The output of evl-ps is correct but confusing.

[1] https://source.denx.de/Xenomai/xenomai4/linux-evl/-/blob/v6.2-evl-rebase/include/uapi/evl/thread.h#L29

-- 
Philippe.
