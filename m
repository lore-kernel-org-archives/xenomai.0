Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177E883CC1
	for <xenomai@lists.linux.dev>; Thu, 28 Nov 2024 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732780591; cv=none; b=P6yZ6BSwEzmEwKL2uihBLNNtSxdoyE2lJAtXf9rAuxSi9pAUGTBDGaff6bHt9nf7UeTLY4hhSw8YjLy/QuZt6mJ9MuZlwsFWJ5k7TxV/l2fKBF8mKsHnrrNEO/3awOYL3Gq+m7osKLb4LAWIkRK/ektNYrySVmLWzLUIlhL6pWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732780591; c=relaxed/simple;
	bh=ZQln5JvFWBHnAZhA74ytO1sjW5YAEuPbfG/GSOCo0jw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P3klX00MfIfhA0DBtDG0g6lTaAtIJMMq9MdOSHEtDA2VN/pMo678HWNvee0WyAW/ZzmHSp/QJ28o1GgLjgRtpHunf6betCff8ZTbmrWRlfCrXaMgZNa/WRX4OrkUEOBw7l3vHxqDbyCgukbQJMhP46cPWULg55o+sELQbHKcqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=PIpz3D97; arc=none smtp.client-ip=185.136.65.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="PIpz3D97"
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20241128074608c583557df6a812cd5b
        for <xenomai@lists.linux.dev>;
        Thu, 28 Nov 2024 08:46:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=0mMZ8h4CIK83O3Ptk4D3vwfU6vAbkZL/QQ9N+0Hw5ng=;
 b=PIpz3D97PL3TkWrpI5Tyyft8evFToxfvxMt9dVTO+3V7EBdms/0OG4yE50hoK/g3DvTZnd
 q2T15oOTm4y+NRC24lgud4jsjZ40dHHHiAaJin5Ri72xF8sS+5x8djkKGgD0Baib5VXQgUdy
 V0R1w47LzfT62x5n2AB+sqTwYSIJtgzJGAVAKQqP8Xz5nrQn/rrQWLsxI61Hy/wUcsTPYs2l
 Dl9tr72DzC7SPMxkZT4GIuRbsXCUWhSTNAk+1WZD29jLAwO8y9iJdJ/U5yOvrGsOWQgDlZKX
 I8hhK3U+JVGwrKn4TteVT/vJ6s5jmEZMIUusETcjhv/Yr1WDCsrZGsAw==;
Message-ID: <6c47159cce36e5fae123b83a6d79fa5698ca9480.camel@siemens.com>
Subject: Re: [PATCH v2] fix user get ifindex error issue
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: liuyang <liuyang@sinsegye.com.cn>, xenomai@lists.linux.dev
Cc: songjianwei@sinsegye.com.cn
Date: Thu, 28 Nov 2024 08:46:07 +0100
In-Reply-To: <20241128034351.1871231-1-liuyang@sinsegye.com.cn>
References: <20241128034351.1871231-1-liuyang@sinsegye.com.cn>
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

On Thu, 2024-11-28 at 11:43 +0800, liuyang wrote:

Hi,

could you please provide a bit more information (within commit message
/ patch description) about the symptoms / kernel splat that you saw?

Florian


> Signed-off-by: liuyang <liuyang@sinsegye.com.cn>
> ---
>  kernel/drivers/can/m_can/rtcan_m_can.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/drivers/can/m_can/rtcan_m_can.c b/kernel/drivers/can/=
m_can/rtcan_m_can.c
> index c2bd16660..f647c6f7f 100644
> --- a/kernel/drivers/can/m_can/rtcan_m_can.c
> +++ b/kernel/drivers/can/m_can/rtcan_m_can.c
> @@ -474,6 +474,8 @@ static int m_can_read_fifo(struct rtcan_device *dev, =
u32 rxfs)
>  	u32 timestamp =3D 0;
>  	int err;
> =20
> +	cf->can_ifindex =3D dev->ifindex;
> +
>  	/* calculate the fifo get index for where to read data */
>  	fgi =3D FIELD_GET(RXFS_FGI_MASK, rxfs);
>  	err =3D m_can_fifo_read(cdev, fgi, M_CAN_FIFO_ID, &fifo_header, 2);
> @@ -550,7 +552,8 @@ static int m_can_handle_lost_msg(struct rtcan_device =
*dev)
> =20
>  	rtcandev_err(dev, "msg lost in rxf0\n");
>  	skb.rb_frame_size =3D EMPTY_RB_FRAME_SIZE + CAN_ERR_DLC;
> -
> +=09
> +	frame->can_ifindex =3D dev->ifindex;
>  	frame->can_id |=3D CAN_ERR_CRTL;
>  	frame->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
>  	frame->can_dlc =3D CAN_ERR_DLC;
> --=20
> 2.34.1
>=20

