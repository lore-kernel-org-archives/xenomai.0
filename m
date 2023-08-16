Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AF7C8D0
	for <xenomai@lists.linux.dev>; Wed, 16 Aug 2023 10:50:18 +0000 (UTC)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230816104001bc40453cea96bd15ff
        for <xenomai@lists.linux.dev>;
        Wed, 16 Aug 2023 12:40:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=NGtdIDg/4wqJsPvdFXfU2PpWBzBRKpj+zJVJwc5OO5I=;
 b=T2wmTP3jXx8m47fODEoT3qygs0nSWWK0GL66PIwOGVFqXWB6UVImarMJbjD3VU0vlJCPa4
 2l6rif+9DmipuZe7a3NfUnTt6bWhxirFo714jcHw01W/FadrOLrNj1nv35TNrzBNr81Zae1C
 9EJjnorf9Uk3grRcTBxMfgqpNvNO8=;
Message-ID: <e04ac9487b616adb751e6c7a19850a317cda153c.camel@siemens.com>
Subject: Re: [PATCH] add dovtail signal setup function
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Johannes Kirchmair <johannes.kirchmair@sigmatek.at>, 
	xenomai@lists.linux.dev
Date: Wed, 16 Aug 2023 12:39:58 +0200
In-Reply-To: <20230816101853.3377721-1-johannes.kirchmair@sigmatek.at>
References: <20230816101853.3377721-1-johannes.kirchmair@sigmatek.at>
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

On Wed, 2023-08-16 at 12:18 +0200, Johannes Kirchmair wrote:
> +int dovetail_restore_64_rt_signal_frame(struct pt_regs *regs)
> +{
> +	struct rt_sigframe __user *frame;
> +	unsigned long uc_flags;
> +
> +	frame =3D (struct rt_sigframe __user *)(regs->sp - sizeof(long));
> +	if (!access_ok(frame, sizeof(*frame)))
> +		return -1;
> +	if (__get_user(uc_flags, &frame->uc.uc_flags))
> +		return -1;
> +
> +	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
> +		return -1;
> +
> +	return 0;
> +}
> +

Just a drive-by comment, didn't check all the details yet:

Instead of returning -1 the underlying error (=3D return the return value
of the function calls) should be reported and/or use proper error
"codes" such as -EINVAL or -EFAULT.

Florian

