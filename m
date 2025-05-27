Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ABE154457
	for <xenomai@lists.linux.dev>; Tue, 27 May 2025 08:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748333443; cv=none; b=UjKTAiKd/6nFQLTTCXldmHC4afXBHawD56D3XcQpaIqykTurXyKbCCvQuXsYiQlwClhDu+VFs610NJtLzO1HSdXHQqj4wpEXBBtMIa9sLATbrcnxACojKBBU/EeXUOKO9M1OnLO7gVHBjud9pJxYdggofME6ueYnmV0Zsikfeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748333443; c=relaxed/simple;
	bh=1D0nvp3klwnqkeZdPs45DI8cfAB8KbiCI6/lG2sQ3u0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R4tuE6jObhlJPS8IDiTa/ALffctblNkE1mLLkUpPCIjAnzkMnIK6WkO0ehEuJBYnDyyc6pEx3yMAr9RWugbqmhFK/708ZtCVmtXzuLY2EpuYD7phABzjoTpAvPe16o3du60+p+eoiMrMlg9a7IBSga7C8Qk47UWgaVLpsnBd2go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=mw20Hxfd; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="mw20Hxfd"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2025052708002883540225433b640ff6
        for <xenomai@lists.linux.dev>;
        Tue, 27 May 2025 10:00:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=T2swnCwnMliKIOMEEbUaQl/xsX0wyUz1qlM9OSzhPbE=;
 b=mw20HxfdXCM5rrZ8Vd0tbd/vAubQYT7CRZ/Qa3R1MGtFGyVi3zWIJaNXVA8vtUemZeXej9
 YGOXBqPT+6pXaGnAI0uKeAKFckqycYnJDm0lxbFPNOUjLBgdyF3oiQmkICeJrLx6Jqy50ghc
 myxoj/KYan+HLBrmQA7A/ZO0Akt0XQE7k1S7ZRrKteJ1p2SOHVSGgIwMtatUcMvbMnDouOnm
 e+fY3yedcVRrKtN1wbrF1t4usMyTaPuMONuz4eduDEEriIDGo+1cm+B8hFAEKxPez9tKXZfb
 5MN8CXzwd5ziirqiiMldx9zI4DtHqjf4HTcGYDapw50KGI6SP2CwonWQ==;
Message-ID: <fde96c6e451b36e0889704d75fd420da52f3f682.camel@siemens.com>
Subject: Re: [PATCH] cobalt/posix/clock: Allow NULL resolution on
 clock_getres64
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Xenomai <xenomai@lists.linux.dev>
Cc: chensong <chensong@tj.kylinos.cn>
Date: Tue, 27 May 2025 10:00:28 +0200
In-Reply-To: <8f519aa0-871a-4698-9905-4434604a7f3c@siemens.com>
References: <8f519aa0-871a-4698-9905-4434604a7f3c@siemens.com>
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

On Tue, 2025-05-27 at 09:13 +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>=20
> Permitted according to POSIX spec.
>=20
> Fixes: 633022801750 ("y2038: cobalt/posix/clock: Adding clock_getres64")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  kernel/cobalt/posix/clock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/cobalt/posix/clock.c b/kernel/cobalt/posix/clock.c
> index 845918a4a1..e6c187ca40 100644
> --- a/kernel/cobalt/posix/clock.c
> +++ b/kernel/cobalt/posix/clock.c
> @@ -103,7 +103,7 @@ COBALT_SYSCALL(clock_getres64, current,
>  	if (ret)
>  		return ret;
> =20
> -	if (cobalt_put_timespec64(&ts, u_ts))
> +	if (u_ts && cobalt_put_timespec64(&ts, u_ts))
>  		return -EFAULT;

Correct, especially as clock_getres has that check already properly in
place.

In addition a test case should be added to cover that POSIX corner
case.

> =20
>  	trace_cobalt_clock_getres(clock_id, &ts);
> --=20
> 2.43.0

