Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3D31EB3D
	for <xenomai@lists.linux.dev>; Mon,  9 Dec 2024 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733735620; cv=none; b=qE+qQ7OUGudLrz18HQ5/R2Z/aOQmEIxSEB8wBgrLknvc/kcMUWvInpL6iQilOpvQmE5CejcjiksyFvPzTG0ITuwUbuar0FVZkg+iBKKUNFSOBJFLpZE1BhGcyAaSs4BPOavLJS457q0RGovDS1XtokKkcAP7f84H/Wlqn0gLGB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733735620; c=relaxed/simple;
	bh=jwviNG8povjIE3la3n+dXK03nHMjlCmiJBaoDS2p4wI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VKPqNFdCoD3xBW2YgSVdw4jIAi7E7+D+ISVJFl6EpGMRjgnSoSku5lKi9MPbh2tv7xokmH36GGyv2FHZDtJULqklSwBY0z8euYZho+qrtWmuVU9gasho2jk6+oQogtg58sPNjSz6GFUW/1Cbt+iQaqHMkuU4fVN4Ir7AJDBv1mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=hNuYwxcp; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="hNuYwxcp"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202412090913255f7637b6c6bab135d9
        for <xenomai@lists.linux.dev>;
        Mon, 09 Dec 2024 10:13:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=T72iFmQgdMDkQIWT0l7f3MvcQf3nzkPOx2j1x1/jzYI=;
 b=hNuYwxcpkqmGFsLvS55fs+e8cxJH7p2Nyz6Wjfgz2Alk3xl0u8k6bQ72YEFaVHNJZkuETc
 hpXQ6+r4sImQLMlpjDjxDJDdzFqQt3175HgXERi+3urt/pKYBzHPao5V8rsWrougnbGA5Z0G
 QUgmzgkHh+/wRtZkVsEZ1+mLTwwsB9CjW9z9GjVcV9b/SAPaYDy0y67Iaq6W5hHYsSkFdo6t
 StHVqsdlcj0jYfhk18BiKzccgW/cc81XdcXZ1On77o/wYk1eGuTMd/FXMGE9P8Yzz4iUlCVf
 DJM/VzhUkGgnjyRohq8wEk8uDTS8X3JbntSEje6MkgqFV6ZW7CXWOs/A==;
Message-ID: <faeb387ee51b7d32574a582a771d4fe5108b6b76.camel@siemens.com>
Subject: Re: [PATCH] lib/cobalt: remove unused `pthread_attr_getdetachstate`
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Qichen Qiu <ruiqurm@gmail.com>, xenomai@lists.linux.dev
Date: Mon, 09 Dec 2024 10:13:25 +0100
In-Reply-To: <20241209085852.676777-1-ruiqurm@gmail.com>
References: <20241209085852.676777-1-ruiqurm@gmail.com>
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

On Mon, 2024-12-09 at 08:58 +0000, Qichen Qiu wrote:
> The detachstate is used to determine if it is PTHREAD_CREATE_JOINABLE.=
=20
> Since this check has been removed, the retrieval of detachstate seems=20
> to be unused.
>=20
> Signed-off-by: Qichen Qiu <ruiqurm@gmail.com>
> ---
>  lib/cobalt/thread.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/lib/cobalt/thread.c b/lib/cobalt/thread.c
> index dee39a8d4..e237e7ba1 100644
> --- a/lib/cobalt/thread.c
> +++ b/lib/cobalt/thread.c
> @@ -129,7 +129,7 @@ int pthread_create_ex(pthread_t *ptid_r,
>  		      const pthread_attr_ex_t *attr_ex,
>  		      void *(*start) (void *), void *arg)
>  {
> -	int inherit, detachstate, ret;
> +	int inherit, ret;

Checkpatch reports a DOS line ending here. Please fix.

>  	struct pthread_iargs iargs;
>  	struct sched_param param;
>  	struct timespec timeout;
> @@ -167,7 +167,6 @@ int pthread_create_ex(pthread_t *ptid_r,
>  		 */
>  		pthread_attr_setinheritsched(&attr, PTHREAD_INHERIT_SCHED);
> =20
> -	pthread_attr_getdetachstate(&attr, &detachstate);
>  	pthread_attr_getpersonality_ex(attr_ex, &iargs.personality);
> =20
>  	/*
> --=20
> 2.34.1
>=20

