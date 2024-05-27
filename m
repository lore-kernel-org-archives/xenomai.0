Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AFD17BA9
	for <xenomai@lists.linux.dev>; Mon, 27 May 2024 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716794399; cv=none; b=ki16Wz+MRNscw8tjVX47PJJlFL0VeHUgaz4jPqpjdwnuesI+VRAzHxbf+TkrTRyBbPnseVlmau2KNCUy7sjN9yU0JrBu6jagdwoEzCri+y6atZqbxSsi3tBJe6XwOWIIUeNNJ9NbhR46wDu2OiITzzCDntL38we47L6UGs0Xbaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716794399; c=relaxed/simple;
	bh=HZ6oDYFzE4S9dAB+02oulUoVgdVY4rlaMlNSOpDlrs8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jssyKly6ohpjmBvlkj5K3WbyX5c7lBFLM/wQVk9lvaQbxI/tzPPBtPqT/eZqoLFtvjkkebeBiTo9SEYZA6FeXBbOqAMXbTHknJPuoxPnvEU2vO6LV9oa1XVHwpD5bnQMwekT6LpF2ahBovALgEplpQtUxqkDeA7CaK9GqvvWCFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=SQbEAGdJ; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="SQbEAGdJ"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240527071946c8d131bc2db88fe367
        for <xenomai@lists.linux.dev>;
        Mon, 27 May 2024 09:19:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=pISz6pAahiALDlkzhFWLH5nykLM9d8gQ+7RKTI3Ht5Y=;
 b=SQbEAGdJTVQ3Qc72ApzgxYRxdukdduy3QikiZYZy1S46r9JBPuNU4b8HEL4yDREWCHv1DH
 wap1+xvkVrsZptg2W0pJ7kKyKtS+jwAKRZQQS6TPQrLdXeR1+naWScS366R28FrReaMOUhCV
 lUBLGYeWJ+3tfiXgTH4hQ56OUj8ow=;
Message-ID: <4236b09da042f9bfb766707a95dd60f229b69a51.camel@siemens.com>
Subject: Re: [PATCH 03/16] prepare-kernel.sh: Convert to tabs
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Richard Weinberger <richard@nod.at>, xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at
Date: Mon, 27 May 2024 09:19:44 +0200
In-Reply-To: <20240525115806.12101-4-richard@nod.at>
References: <20240525115806.12101-1-richard@nod.at>
	 <20240525115806.12101-4-richard@nod.at>
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

Hi Richard!

On Sat, 2024-05-25 at 13:57 +0200, Richard Weinberger wrote:
>  patch_reverse() {
> -    file=3D"$1"
> -    if test "x$output_patch" =3D "x"; then
> -        if test -L "$linux_tree/$file" ; then
> -            rm "$linux_tree/$file"
> -        fi
> -        mv "$linux_tree/$file.orig" "$linux_tree/$file"
> -    fi
> +	file=3D"$1"
> +	if test "x$output_patch" =3D "x"; then
> +		if test -L "$linux_tree/$file" ; then
> +			rm "$linux_tree/$file"
> +		fi
> +		mv "$linux_tree/$file.orig" "$linux_tree/$file"
> +	fi
>  }
> =20

This part is introduced in patch 1 and completely rewritten in this
patch (patch 3).

We could avoid that by applying patch 3 fist, so basically reordering
the patches so that patch 3 becomes the first one. Could help if
someone has to bisect later...

Best regards,
Florian
