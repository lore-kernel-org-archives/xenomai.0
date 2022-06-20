Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927C37E0
	for <xenomai@lists.linux.dev>; Mon, 20 Jun 2022 06:45:36 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 8FE2E24000B;
	Mon, 20 Jun 2022 06:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1655707528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qaDgY4W/+6OJUxltiVGmH/99Sb+hgWH2XllQCQhcUUc=;
	b=LMBVjhJA3/2fioolqfuXeShMpWPUKXgo+zLwJIMtEUA3AILzx4sNyiZD2sNirLSm5OxZ6N
	FTPVr/8AquGKiMzE6P7Oe/4HU8J8ZxhPgw3a4LQ1f28cNoMDe1z4Iphvy3Ss00JVBgCs7z
	nlVTQazfQQwxgXpM5cIIukeKHM1T08pp70JEICH2yhLXI+ubExJUOJlKGhJ0/7/ckAOXLL
	xXA7v0uL8k1+0GE4HGQuxRxQkMfnzR1OHkOa94BBg2MJON7XcEdkK5jEm6p5GmSx08Kvqx
	pxWIq8iYdypSkGXSNUiRTOm7QMvCMiZYSkIbBDreS2nQZ74CTB7YyjeiW0vmEQ==
References: <875yky6idl.fsf@xenomai.org>
 <30615b27-e696-2000-b484-e6433379fa2a@siemens.com>
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev
Subject: Re: Mailing list enabled
Date: Mon, 20 Jun 2022 08:33:34 +0200
In-reply-to: <30615b27-e696-2000-b484-e6433379fa2a@siemens.com>
Message-ID: <87a6a7kf3r.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 18.06.22 18:11, Philippe Gerum wrote:
>> 
>> The mailing list rehosting process is complete, welcome back.
>> 
>> Unlike I previously announced, it looks like keeping xenomai@xenomai.org
>> available for posting to this list via mail forwarding is not going to
>> be possible. So please switch to xenomai@lists.linux.dev for this
>> purpose, the information on the website has been updated accordingly.
>
> Fairly inconvenient. What prevents this?
>

I have no way to ensure that the mail forwarding system keeps the
destination list address somewhere in the envelope (in Cc: would be
nice). As a result, the mail handler at lists.linux.dev cannot figure
out which list the forwarded message is for.

> Did you already updated the ipipe release script accordingly? Just
> pushed a 5.4 release, and it seems the announcement is not making it.
>

Yes I did. Probably an issue with my server which is not MX for the
xenomai.org domain anymore.  Another way to deal with patch generation
and archival to the download area will have to be found anyway, since
this server will be decommissioned in a few weeks. I'm working on
finding a replacement.

-- 
Philippe.
