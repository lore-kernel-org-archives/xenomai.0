Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8257E
	for <xenomai@lists.linux.dev>; Wed,  7 Sep 2022 07:05:20 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 701B8200015;
	Wed,  7 Sep 2022 07:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1662534313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RYsN5N7Meu38Lne6rpQEHEXyRrKmtgsM52q2xTnavYk=;
	b=kjmOPPAhjO1BA6FqmsKQMIUbA6rpwv0BpJCyo2UsbwhSxUfxXY5tSYSOBRGg9JndJ6Jsan
	4SltlhnwzDdkdXvfQuqfChQEz4mydmiEahGLQ7rmZNC4yKVNL+qjqOc7srf1WWhyNNijBd
	YOeSFQ1O+eIrcOB1SedI94mOXx9ORYyRupV7EP48lMgiFE5oEFe/jgf/Pp6R+Z0pS7pHFQ
	1opG3p5moZk/rvrWbzB0I+i4X6G3GfvS+WO1EiWf3VpDZsWww+rUAMlgKf6VEbWYiXJ9zd
	9aQuorL0mXIDlLRjjxzkybU4GACNsLIeLSOK4Ko6QX7OJ26F96/w8t7SDXt4PQ==
References: <PH1P110MB10503EB7CC57455924221392E27E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: SIGDEBUG signal received on oob_ioctl() call in EVL thread
Date: Wed, 07 Sep 2022 09:00:13 +0200
In-reply-to: <PH1P110MB10503EB7CC57455924221392E27E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87pmg7ll5k.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Hello,
>
>  
>
> I have been debugging one of my EVL threads for any in-band switches that occur. Currently, what I am seeing is that my thread will run for a
> little while and then I get a SIGDEBUG signal from the EVL core. If I throw it in gdb, then it tells me that the signal came on a call to oob_ioctl
> into one of my drivers. I am not understanding how an oob_ioctl() call could cause an in-band switch. Essentially the thread is just sitting there
> waiting for an interrupt to happen. It uses a kernel semaphore in order to block and wait for an interrupt; if it times out, then the thread
> re-tries the oob_ioctl() call. I pasted some basic pseudo code below of the oob_ioctl() call in the userspace as well as the ioctl case that is
> handled in the driver. Is there anything obvious that sticks out as something that could cause an in-band switch? What, in general, could
> cause an in-band switch on an oob_ioctl() call?
>

There are multiple causes for SIGDEBUG, the stage downgrade notification
is only one of them. The list is available at [1]. You may have
EVL_DEBUG_WOLI enabled, and the cause reported by SIGDEBUG relates to
this.

[1] https://evlproject.org/core/user-api/thread/#health-monitoring

-- 
Philippe.
