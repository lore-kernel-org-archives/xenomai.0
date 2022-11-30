Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C19763B3
	for <xenomai@lists.linux.dev>; Wed, 30 Nov 2022 14:37:30 +0000 (UTC)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202211301437214c12f51433aea4edec
        for <xenomai@lists.linux.dev>;
        Wed, 30 Nov 2022 15:37:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RJ+qDvBLdmaxQSWWgo6Y3bqrRUJE4dokxtK7ilt+5ug=;
 b=clsIzlI3wUI86N1sLyRXo75sCSvvwkZJ9QztVeFQrtsfGIzMhsTf1zpj4p53O7p4ehHG52
 U6nGfXllHajCdMtuY3PYUh+CzF05cso6cK6ZH32GbYcuefa0xaQH1VuJL71BInTYUapkOlMw
 jZFCVDnV9RPfW5SkFZ9GFFbmCYI1M=;
Message-ID: <dc5803331d4b4197017d91a9cadfed61ab122eec.camel@siemens.com>
Subject: Re: [PATCH 3/5] switchtest: test multiple secondary switch cases
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: "T. Schaffner" <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com
Date: Wed, 30 Nov 2022 15:37:20 +0100
In-Reply-To: <20221130141134.2503172-4-tobias.schaffner@siemens.com>
References: <20221130141134.2503172-1-tobias.schaffner@siemens.com>
	 <20221130141134.2503172-4-tobias.schaffner@siemens.com>
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

On Wed, 2022-11-30 at 15:11 +0100, T. Schaffner wrote:
> +static void switch_to_secondary_mode_by_fault_in_xenomai_syscall(void)
> +{
> +	XENOMAI_SYSCALL2(sc_cobalt_sem_timedwait64, NULL, NULL);
> +	assert_secondary_mode();
> +}

Let me revisit this one here. I guess we should not fault at all. Seems
you re-detected a bug. I had some problems with that while working on
the first round y2038 stuff and decided to keep it as it always was.

Will have to check where the fault actually happens. Maybe it's
acceptable to trigger the fault with NULL. (At least it seems to be
handled correctly)

Open question: If we would not trigger a fault, how to handle that one
of your test requirements goes away...
