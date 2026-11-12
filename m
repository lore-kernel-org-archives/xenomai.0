Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493223;
	b=NPtnS9/Nb6m+6fwQpj5UhTXQzLAf5rHOObGdC2KogNZ+5lL3jRzxCQC9K3AcUQH69bOl
	 JxOk3PoR30xlbKJmQ0WOP/oKEKXf1wB6fgrkpJFzVkWagRvAAIqdwMmWyWis9gpsYmyXO
	 feYyWZg1sjmXE3FHyLZsw31rBLtefFnzeRbxscJQ3Jyfx187DNPWFpNX5wgiG8mUxxbIW
	 cZH9fpG5iWLdg6rlZud1h9IQ6nc5H2gkhQa5AxsGUtxoSxhJaJAtb+gC+pM5YhZHNhCpu
	 subWIc6IJWW6CoPZn6EFYdZ9hVYQsOqJ4tL4RZivDBk1uoUg++7n9/AsTmc+59W8tKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493223;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:
	 References:User-Agent:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-GND-Sasl:X-GND-State:X-GND-Score:
	 X-GND-Cause;
	bh=2iZKfcdxNpsvKzvQhOm/kilUApYpt2PB2ZnOHWUOmAI=;
	b=Zb5CJAwd6tOTOKZDO6IqrFF6IYf44yiaGP7Gtdx+HMP5Yhh9fAD+UmN9VI7C8gvXJJ0E
	 l6vy+SayseCUxCzRzxMn9QNh0NrPq2ZiGbwNxx10cvn+JbsShB3iNpqA15nlqL6GOevzx
	 cM/EH8B0Oc+VHklQNlVMpdPxbQZMVN1nAg0oDwrMYiPFaBG1yp7GEuctyUpBg+Zp2/GBY
	 aNIQIZmbf3U8qW7o2UBzxVAGth/Y01eldKI+lH9/PNBhHtDlkm02ELAnPe3WbCPILcgJ6
	 +KfTsH3I3VfqrIw37kd/mmR/USWWsHeivy6SW5NPozkqYRb8tKd5JKuiZxFFV+7DP2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=IjIVTxUE;
	arc=none smtp.remote-ip=217.70.183.194
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30C8606B2FE
	for <xenomai@lists.linux.dev>; Thu, 12 Nov 2026 14:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F30C8606B2FE
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=IjIVTxUE
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2315E3EC26;
	Thu, 12 Nov 2026 14:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1794493214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iZKfcdxNpsvKzvQhOm/kilUApYpt2PB2ZnOHWUOmAI=;
	b=IjIVTxUEIj5n7Cc7RihamLrQ264OOE/tWbitZxqOVmZrY9NpB93RlhoSc8Ei5RNlb/udpR
	XwwyqKsN2nAx8bl87vDTHLQ+vtmqTISsQ3zeTg7d56ol5iWBBf35FiWWymjpf+h5aWe1yV
	2ldmqNKbcIapITe8yEYCQywCyMBh0LDpIYjTPrNUKsejBaGF9LezrPVzch5nge4NH5Cnam
	KFcY4WWZXDyl5coZ3DVwgFtKNz23/2Ir8uv1w8nFfYrjnUPHyXpT35tCu2Ol0oYRVi/NDl
	9iK3ipYdKW0sXjzSXcULGiQ+UiX7Bko8HAk9y9HN9mduRbS+7jas2YzSCj3uOg==
From: Philippe Gerum <rpm@xenomai.org>
To: =?utf-8?Q?Mart=C3=ADnek?= Petr <petr.martinek@elvac.eu>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: linux-evl 7.2 OOB GPIO NULL dereference in lineevent_create
In-Reply-To: <c67e81ec3fa44745b6c5c13c87fab81b@elvac.eu> (=?utf-8?Q?=22Mar?=
 =?utf-8?Q?t=C3=ADnek?= Petr"'s
	message of "Wed, 11 Nov 2026 11:53:20 +0000")
References: <27ae5abdf65c4fd2aff3949c6d424354@elvac.eu>
	<c67e81ec3fa44745b6c5c13c87fab81b@elvac.eu>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 12 Nov 2026 15:20:13 +0100
Message-ID: <87wlqiyvvm.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: rpm@xenomai.org
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTFYyL6w/uG+WTYIzXfz8uf5dgscicYhHHccmoWgoynnxwbegSNSIrBHWWIeXk+8k2dTkeD5bPtdX1BXff91WhKkEEsZDat3AbQU3SXKNozbcA6Q6OoX/pWqItBeKs4C/dzkRDWcMxEPd6LPnFO5ttFaA3f1BuKi91XdhVy4b7x+v3SNrdl7mmnoz2MkbM0el7eCHsA61ycXMy8mKm8gb3k9Ow5SBW1T7aM5DzVbbMZ7kzLp0V5ppXsipdZCNydYUeffm7P89T+qqrMieUQ2khkXRnkRc609zhpLayZQq+QXhe3Sq7Ye2KEX3s8w3o77L3SjnapoHY9ntyt4Fgkn8ScSYaci7m68ytPOAXfdWdOLDggeMNrQLDh9IY8mgVG5o1hrkxezF4kn+4CusMPQKdSRgRQf+OHXpN4fHpCQy/a8HGJgOkijF5jDswHZr4lvM+UNljCfAFdwODm/neZMcXH1LYI/D6JuVj+Mx6nvhGCsy2F/iesyd9LGTva48Btk6Ne3UPdF0Nc65WAFl+kbGxmELFLRZ27V6ezNvUjyAgLsvaTf3hz2gFWjwl8yJKqvnUVcg92XaurLaf9sxSti37SlqkNtU8MbvFARDifXjhNqvKA7TUxmKYHNVIRS2uaGoQ4wpjqT+C5MTNowd/SsZeXpdFmV6tMvRDahpVcmdU9hKA

Mart=C3=ADnek Petr <petr.martinek@elvac.eu> writes:

> In lineevent_create le->oob_state is used after retain_and_null_ptr(le)
> which set le to NULL. Included patch adds oob_state variable
> to fix this.=20
>
> Signed-off-by: Petr Mart=C3=ADnek <petr.martinek@elvac.eu>
> ---
> diff -Naur a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> --- a/drivers/gpio/gpiolib-cdev.c	2026-09-23 08:39:20.000000000 +0200
> +++ b/drivers/gpio/gpiolib-cdev.c	2026-11-11 10:25:07.714465106 +0100
> @@ -2222,6 +2222,7 @@
>  {
>  	struct gpioevent_request eventreq;
>  	struct lineevent_state *le __free(lineevent_free) =3D NULL;
> +	struct lineevent_oob_state* oob_state;
>  	struct gpio_desc *desc;
>  	u32 offset;
>  	u32 lflags;
> @@ -2340,10 +2341,12 @@
>  				      O_RDONLY | O_CLOEXEC));
>  	if (fdf.err)
>  		return fdf.err;
> +=09=09
> +	oob_state =3D &le->oob_state;
>  	retain_and_null_ptr(le);
>=20=20
>  	if (oob_handling_requested(lflags)) {
> -		ret =3D evl_open_file(&le->oob_state.efile, fd_prepare_file(fdf));
> +		ret =3D evl_open_file(&oob_state->efile, fd_prepare_file(fdf));
>  		if (ret)
>  			return ret;
>  	}
> @@ -2351,7 +2354,7 @@
>  	eventreq.fd =3D fd_prepare_fd(fdf);
>  	if (copy_to_user(ip, &eventreq, sizeof(eventreq))) {
>  		if (oob_handling_requested(lflags))
> -			evl_release_file(&le->oob_state.efile);
> +			evl_release_file(&oob_state->efile);
>  		return -EFAULT;
>  	}
>=20=20

Merged, thanks.

--=20
Philippe.
