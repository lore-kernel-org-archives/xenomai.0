Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E2146D7D
	for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319080; cv=none; b=HsMnuFfu+2k0Kdq7XEn6BADpniu4gHWF2WFrDemMAB/GZE24IejzzOB2Cs3xEBo+9EU/cC2GhJzqn/rb8sewYzGiqsMCGTbkoAyqkPi/iqFDv3J/MQXJQpXi30THg9nZsKKB2YyK9+z2Wn04Z5evgxekndh2zZBLW1WlhGy93K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319080; c=relaxed/simple;
	bh=Hd3xdZj+COS7X77ef+S2pPATvjovbjh65JA7nN2R/zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gn32MHkD7DKmOaoohFI2NhKQTaIUUcmQBW0ffPQvCjQbvd2j8pZ2b0n8rH/n/quXXPWSA0UQ/X/spBQ/951F7TsL+vfa/S76wU5CVNhM81DLs72l/tcL3wdQB50J7qgwWtNvTXIDJ1rIAlmyCsRJVUstWgyWzWA6ubm9co8LV0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=pQbB44zL; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="pQbB44zL"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5bede548f7cso909413a12.2
        for <xenomai@lists.linux.dev>; Thu, 22 Aug 2024 02:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1724319075; x=1724923875; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hd3xdZj+COS7X77ef+S2pPATvjovbjh65JA7nN2R/zA=;
        b=pQbB44zLkKrpLwu+7HCZwMbvaiKFeyPfULrxQ3PrNlUkqBMXj3dOa+N8+B689GgX/k
         MvawMsQBLUTKQn9NuBaECzLNdDlbNyjwjrxARhuEfA4TLc6g36dgrv4yOEUN4wAPlOqf
         jbFF3AGaRn+J5WiaqJAHpgfUGFAmxjnsHzPJiDfZGSTxpGttbUONSMQCTDyHPu8IKYAE
         tGyyT7npt1NxlGksoBgVD0kBhSylkMNxhXguFvuWe3J8v/VRCs6iXZH78ObXiImrVn4Z
         QUC/U7R2HxJC8VCj/WVDvq4dm8jKer8WjiTk+DuHtWZdbNWuXcUu9jH7yeUkp98lntHC
         pIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724319075; x=1724923875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hd3xdZj+COS7X77ef+S2pPATvjovbjh65JA7nN2R/zA=;
        b=osVVB7opzcpmBkx75kv4ujQG1sfTrfbvr+oyR3d1ogVPD6j92ZFbA8jHlblo3XBsVf
         qudkGIT0XEVqYUQ+7EyXE7dCjhxo3d1It1nEbz+8FAklJ18D7/8T70SF00X9TfALyj1z
         5WZeh1M0OGqzPcwI0q4R4+R79pZwbPWn0EUsuL/NsfDV24YVLrywiA5pB3bwQJOkU69D
         TY+QnqccVlZmCYL/0EF7GUIacr0Qt+F6Z5/1ArMmgHWjhej1SuTyyveLBuSZPZk2eZLy
         a8xZYedzOerG90ZWFe0yu6roWQcBGdTCMQ0QN7xv0T9HqGr5g7on5wQavUzL58lfhX0H
         fsAw==
X-Gm-Message-State: AOJu0Yxs+KsZktJHiKxmCJyRG55uVl4CvVYiFCFFdmYil1hyXMepGsjw
	walajqCb7PsvhWoHMclWfk142E+itimqNo8IU16uKU+a9pBrFQCl9feus4BIiSxYEzduZb+KXcM
	d
X-Google-Smtp-Source: AGHT+IH/jPEWW7+ngZBEv1A/+4plhU+SoN0FqCBMoTPLX+EiJwhnKsM4AQ0oRBa3pqHR1pYiB0uPbQ==
X-Received: by 2002:a05:6402:3493:b0:5bb:9ae0:4a41 with SMTP id 4fb4d7f45d1cf-5bf1f238dcbmr3112154a12.28.1724319075119;
        Thu, 22 Aug 2024 02:31:15 -0700 (PDT)
Received: from blindfold.localnet (84-115-238-31.cable.dynamic.surfer.at. [84.115.238.31])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3cb0bdsm684864a12.37.2024.08.22.02.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 02:31:14 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@lists.linux.dev, upstream+xenomai@sigma-star.at
Subject: Re: [PATCH] iddp-sendrecv: Make it configurable
Date: Thu, 22 Aug 2024 11:31:14 +0200
Message-ID: <3094962.xgJ6IN8ObU@somecomputer>
In-Reply-To: <6dc0eaa3-c7cd-43ab-aedd-ba65cf17e536@siemens.com>
References: <20240818111208.19026-1-richard@nod.at> <6dc0eaa3-c7cd-43ab-aedd-ba65cf17e536@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Am Donnerstag, 22. August 2024, 11:22:01 CEST schrieb 'Jan Kiszka' via upst=
ream:
> On 18.08.24 13:12, Richard Weinberger wrote:
> Thanks for the proposal - but it looks like this tool and
> testsuite/smokey/iddp/iddp.c become more similar now. I wonder if they
> could be even united so that smokey calls this in specific configuration
> for running the tests.

Hm, sounds sane.
I can think of a --test option for this.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y


