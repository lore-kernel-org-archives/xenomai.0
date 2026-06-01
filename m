Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443D360EF0
	for <xenomai@lists.linux.dev>; Mon,  1 Jun 2026 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304028; cv=none; b=JILQUH5xNlXC6sspo7e7sryyv47am74NIQFoMNNx6fGZUEXTYNaL3DhKenK7eu3VaeyCZVGpmxX7BL9THneZsqvfdvGa1Zv6+LZL6iDV3RBXkXvCaPtuQrHOFx/DGSPpAjqncnO7FmS3pxnGNpJDDe17TS0jeOpQn4o/xV4a1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304028; c=relaxed/simple;
	bh=Us3JMCyEo28MAqPypc5dMW7R9gXrlVBS52jrJ/ABEJs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dMr5QK4nWp/XGLIAIQtmey5GsXvGN5sJ8adzkhvH33XGzESFZCH7DFq0EcUMN+zzCb/TI0j9ujRUzm+Zhcy3mNvuayvfOCMHJkE8NpaGPtWMOL59t8YNTUm4PLjigP45qEFQnS6PACwhER7Mx49YDghbUWmdWQOW61TyuEBlXlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=JBD08KwN; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="JBD08KwN"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260601085335d7150031ab000207d2
        for <xenomai@lists.linux.dev>;
        Mon, 01 Jun 2026 10:53:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ftPrdnI1agRzCz51rs+WKuREX0xou8M8/BuRbSpKqjA=;
 b=JBD08KwNLqzOCX/dJvBmZOmXZtl5oiYSJVl+Po4/zfT+6JsJ2BVWJcoFu7ruQsnlC/F9U0
 uo24uYB8fRwdEVFpkEr9n8+5qnhlr8hXrDaghv5sXW2XcJVL/VceXfTqjLkRFjIYXczsNHeH
 rHxc+zdTGvDAE/u8Yt9Z6gt77HnCWbMrCi7dgg8R5gL0JuUfGq3j2AIqj9rwbrRIA4LuVfik
 PRlGEA7aOKQM+UGYEYIs6sxLSi6z07kvdycdC4iTICJjlon9L+Sh06r46gdhljuV2j1qA47p
 PMgu6bNELkWz6aGfo3hvjyhl0/51R9G2609cpCSXf8PcFZxN3xcuXRmQ==;
Message-ID: <da5d431e2b95e3f3077f151d2259f0164b5b2722.camel@siemens.com>
Subject: Re: [PATCH dovetail v8 11/11] riscv: dovetail: add core support
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, xenomai@lists.linux.dev
Cc: rpm@xenomai.org, jan.kiszka@siemens.com
Date: Mon, 01 Jun 2026 10:53:35 +0200
In-Reply-To: <20260531055304.2890455-12-tobias.schaffner@siemens.com>
References: <20260531055304.2890455-1-tobias.schaffner@siemens.com>
	 <20260531055304.2890455-12-tobias.schaffner@siemens.com>
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

On Sun, 2026-05-31 at 07:53 +0200, Tobias Schaffner wrote:

[snip]

> -void do_trap(struct pt_regs *regs, int signo, int code, unsigned long ad=
dr)
> +static void do_trap_raw(struct pt_regs *regs, int signo, int code, unsig=
ned long addr)

I wonder why this can't just stay do_trap() ...

>  {
>  	struct task_struct *tsk =3D current;
> =20
> -	if (!mark_trap_entry(regs))
> -		return;
> -

We could call mark_trap_entry() here ...

>  	if (show_unhandled_signals && unhandled_signal(tsk, signo)
>  	    && printk_ratelimit()) {
>  		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
> @@ -150,6 +152,14 @@ void do_trap(struct pt_regs *regs, int signo, int co=
de, unsigned long addr)
>  	}
> =20
>  	force_sig_fault(signo, code, (void __user *)addr);

and we add the mark_trap_exit() call here .

> +}
> +
> +void do_trap(struct pt_regs *regs, int signo, int code, unsigned long ad=
dr)
> +{
> +	if(!mark_trap_entry(regs))
> +		return;
> +
> +	do_trap_raw(regs, signo, code, addr);
> =20
>  	mark_trap_exit(regs);
>  }

That part would get unnecessary.

> @@ -160,7 +170,7 @@ static void do_trap_error(struct pt_regs *regs, int s=
igno, int code,
>  	current->thread.bad_cause =3D regs->cause;
> =20
>  	if (user_mode(regs)) {
> -		do_trap(regs, signo, code, addr);
> +		do_trap_raw(regs, signo, code, addr);

This is the single caller of do_trap_raw() and I'm quite sure that this
is not correct as we would not enable hard_irqs when handling a error
trap over userland...


>  	} else {
>  		/*
>  		 * Dovetail: If we trapped from kernel space, either
> @@ -177,6 +187,8 @@ static void do_trap_error(struct pt_regs *regs, int s=
igno, int code,
>  #define DO_ERROR_INFO(name, signo, code, str)=09

That was my final finding. I think I'm done with reviewing.

Btw: I'm seeing some strange behavior on 7.1-rc5 on x86. The system is
slower than expected and triggering some test timeouts. Rebase to -rc6
is already done. Trying to update all the necessary branches now.

Best regards,
Florian
