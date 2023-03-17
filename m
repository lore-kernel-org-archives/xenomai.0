Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BCA65A
	for <xenomai@lists.linux.dev>; Fri, 17 Mar 2023 06:52:26 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 5BC4F40002;
	Fri, 17 Mar 2023 06:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1679035938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zR4SR1MExTM8Iu5RF5bSPlRR9+PBPE5NLQeT/YP+DMs=;
	b=DX+5oHWBdVCtgqUoUgrrhuHI0BBUgpBHHug5ijhdCS3dumCdIDCjK8d7h3mROten3Y3Lhx
	cmiKYdseE6acyEHgtq7TEdsu3ek80kwlMpuGgSjbNrSP/IoP0kVod5NpUFRkEpp4f8QUfA
	L/0CA84bPRTZWAjz8PqN5e1GWkDAMgOMJnsUVn8QNIsblTBhRWUTzyL6CRGLXXqPvnZlvv
	ZDUXbFaszD8VhEj6Zlp6T38St5lNX7dGbkh/rQglcWGI+B75MWstgmims7nh6F4h9YiJNw
	I4E7XqDr5AtuQM/kjsO4yHlcEUlhuOFDFiSI6yWN57NuwMHnfY7zb/qG9D0kAw==
References: <11477b0a-0aaf-60cb-3a6b-0a8b47414a7f@siemens.com>
 <0d2fbd52-288c-1af5-b462-ec6a4ec1ba0b@bela.io>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Subject: Re: Dovetail 5.10.y sync
Date: Fri, 17 Mar 2023 07:51:33 +0100
In-reply-to: <0d2fbd52-288c-1af5-b462-ec6a4ec1ba0b@bela.io>
Message-ID: <877cvfoonz.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Giulio Moro <giulio@bela.io> writes:

> I am totally not involved with the change at hand, but it looks like it is related to this:
>
>  #define TIF_SIGPENDING		0	/* signal pending */
>  #define TIF_NEED_RESCHED	1	/* rescheduling necessary */
>  #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
>  #define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
>  #define TIF_UPROBE		4	/* uprobe breakpoint or singlestep */
>  #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
>  #define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
>  #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
>  #define TIF_SYSCALL_TRACE	8	/* syscall trace active */
>  #define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
>  #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
>  #define TIF_SECCOMP		11	/* syscall secure computing */
>  #define TIF_SYSCALL_EMU		12	/* syscall emulation active */
> +#define TIF_RETUSER		13	/* INBAND_TASK_RETUSER is pending */
>
> ...
>
>  #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
>  				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
>  				 _TIF_UPROBE | _TIF_FSCHECK | _TIF_MTE_ASYNC_FAULT | \
> -				 _TIF_NOTIFY_SIGNAL)
> +				 _TIF_NOTIFY_SIGNAL | _TIF_RETUSER)
>
> as _TIF_RETUSER is (1 << 13), then _TIF_WORK_MASK no longer fits into 8 bits and can no longer be used as a flexible second operand to AND. Instead, it needs its dedicated MOV instruction.
>

That was indeed the reason for the change.

-- 
Philippe.
