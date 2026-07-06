Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F503859E3
	for <xenomai@lists.linux.dev>; Mon,  6 Jul 2026 15:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350431; cv=none; b=GH+IelF/a7GYmGJiq4gmUuVE3mT2GzxHDqzxDlReJqCmGGdysjNvA3CQ1v4W4VFNCmKGZrG7zo1bqpW03kOQXnb6LH6tOg7j0RbJ//0THwdelOz7kfkJUzyeNcmcZFr6EfLc4Vd4yAPat63LCXZk9OhsnxjBljn0P+h8KxfR5gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350431; c=relaxed/simple;
	bh=qrmtxy44NCL+qSBLLc4/5oY6htIUfWq5a2DLXDDojrA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YucdqDCrACELUdkNcMm4W3ZbPSTuiGSKPG3wXZR6XnxlMdb+vpExO18lmzz9OoXNMiVrt4YpHMcMsV2cpz3DRfK6EZBW3Hs3HLTkIL7j1N7zvJpO6FmQLCsvjIstGOFmXwrULMTndQAvvS6ytxkDhtRnHwaD5o3fn56pA6hPsYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=n0nut2tq; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="n0nut2tq"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202607061506598dc5cdd41c00020793
        for <xenomai@lists.linux.dev>;
        Mon, 06 Jul 2026 17:06:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=x6Zv69CclTcwNqsBFswO+CH/p1V/2pA+E1ZgJza4C0k=;
 b=n0nut2tqhDRueOzK1OZ5ljWyXXkmIe52/279XSMDCQ0RvYBA6AkRbdS7KAAyzRZtULiNZk
 B53vzCC34eQLFAeK5Wv7SXWPoz54dIMALOF7Jxa5E9PosEufDaGMKTg9IwznQC0zKqkk0h3W
 r58UhJ1xmnhLBFehfIZCyEj8bc++zv60fxzEf/IOQy6JwWCDrakbLpW6li/FCPFsJsR+7zXI
 OvcpNaiCRjouqOIS44Sbxvem3OslBlLAp17bD3mIFJE1yX5K9YBewvl9azAZ8D1JwcJz7KtJ
 eJQuhFWZO67psOSl8wbzgPK/PVaanoMw8bvB3RAQyMN5ufpqZLvQ2mdQ==;
Message-ID: <60e6a386a564780148293e3b47692d636e91ba2f.camel@siemens.com>
Subject: Re: [PATCH dovetail v9 11/11] riscv: dovetail: add core support
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
Date: Mon, 06 Jul 2026 17:06:58 +0200
In-Reply-To: <20260703152738.129122-12-tobias.schaffner@siemens.com>
References: <20260703152738.129122-1-tobias.schaffner@siemens.com>
	 <20260703152738.129122-12-tobias.schaffner@siemens.com>
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

On Fri, 2026-07-03 at 17:27 +0200, Tobias Schaffner wrote:
> @@ -359,6 +391,15 @@ void do_trap_ecall_u(struct pt_regs *regs)
> =20
>  		syscall =3D syscall_enter_from_user_mode(regs, syscall);
> =20
> +		if(dovetailing()) {

checkpatch:

ERROR: space required before the open parenthesis '('
#1426: FILE: arch/riscv/kernel/traps.c:394:
+		if(dovetailing()) {


Please double check checkpatch output for the complete series, there
seems room for improvement.

> +			if (syscall =3D=3D EXIT_SYSCALL_OOB) {
> +				hard_local_irq_disable();
> +				return;
> +			}
> +			if (syscall =3D=3D EXIT_SYSCALL_TAIL)
> +				goto done_inband;
> +		}
> +
