Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E7328E06
	for <xenomai@lists.linux.dev>; Sat,  7 Oct 2023 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="mRuspXCh"
Received: from relay9-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::229])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 874E5C50A1
	for <xenomai@lists.linux.dev>; Sat,  7 Oct 2023 14:07:25 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB46FFF809;
	Sat,  7 Oct 2023 14:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1696687636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NTZA/S2uVfQi3NP4dQ6CO22+da8mR2mHwJKi67DV+z8=;
	b=mRuspXChLPE4t2N9bi0LaTtNrT8OwGzjpvDZvAjqLXZ3X7phSJNJPSZGvlV3rBaweyIMQH
	VBp/W9g7j8eNbe6693gLzE9eqFxGBo71DuYZccmkO7xJFEPhzA6OemusJ9X84HFiQ/FGnN
	/VHdhNGTxIS3ngnbb74VuHZTNJqrEsOwesAgwJwr8gdDAQ4hKZ+YBxLOaNCsjI2/hBo858
	Gkq78dSo9BMQi6ryzjGolp2rbgzWiHMhREbOHZB7Of+Ln+6hkjcJTg9oIVceUJVGf8c46A
	HZCXNYRr8H8fURiUPMOqbGXcr6IwVhrEsh8gHeIpdsnFp66xRq2WFySvmzKYuA==
References: <20231007112300.1352970-1-liyinjie@sinsegye.com.cn>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: liyinjie <liyinjie@sinsegye.com.cn>
Cc: xenomai@lists.linux.dev
Subject: Re: [PATCH] commands/evl: improve argument of help
Date: Sat, 07 Oct 2023 16:03:50 +0200
In-reply-to: <20231007112300.1352970-1-liyinjie@sinsegye.com.cn>
Message-ID: <87ttr2edbk.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


liyinjie <liyinjie@sinsegye.com.cn> writes:

> Hi all.
>
> Enter the command `evl --help`, output
>
> usage: evl [options] [<command> [<args>]]
> -P --prefix=<path>   set command path prefix
> -v -V --version      print library and required ABI versions
> -h --help            this help
> evl: no 'help' command. Try 'evl --help'.
>
> This patch will fix incorrect output "evl: no 'help' command. Try 'evl --help'.".
>

This output means a problem with the installation, it looks like the
evl-help sub-command file is not there on your system. On a typical
installation with evl rooted at /usr, the following file should be
present:

root@blade-qemu-x86_64:~# ls -l /usr/libexec/evl/evl-help 
-r-xr-x--- 1 root root 394 Mar  9  2018 /usr/libexec/evl/evl-help

With this file present, the output would be:

root@blade-qemu-x86_64:~# evl --help
usage: evl [options] [<command> [<args>]]
-P --prefix=<path>   set command path prefix
-v -V --version      print library and required ABI versions
-h --help            this help

available commands:

check        check kernel configuration
gdb          debug EVL command plugin with GDB
ps           report a snapshot of the current EVL threads
start        start the EVL core
stop         stop the EVL core
test         run the EVL tests
trace        ftrace control front-end for EVL

-- 
Philippe.
