Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32634215182
	for <xenomai@lists.linux.dev>; Mon,  9 Dec 2024 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733746854; cv=none; b=XSGbJrJKWqaQyLDmX6TNRiWln0vkXVzzbB+amaGKvQ8Eh7OcRN5lL8Y3hvkh/zTwfd84MEtgDm7trwHMPl992v4sbR0OBpaZDbm5dluIeByAMKTh8h8+JquBuK7ZANbZhNqZ5SJcHJe0gm6VdA6ctR+JbIQrKM4QVH6tFs1QLfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733746854; c=relaxed/simple;
	bh=LfUxA3KsCOuX7umz02ia0AsgKeagS+e2k6REM+0GLYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GMDaY+WIAxL+44lvbtlj9PCfRRQQcfvFnJVD4SNfIzKptDV0Ij7Gtl6ISLKTk4vB2PtG6AHApBKkKPCkLDo2C0qz6M5qc7VU5X1Pb4lcc6sSCLOCn9JthNWScQFry7mRukfC+pcmisAgS+KeHMOeCMXx65CgoYqcoYgeRfHanz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaEJZtZq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaEJZtZq"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725c49b5e45so1876996b3a.2
        for <xenomai@lists.linux.dev>; Mon, 09 Dec 2024 04:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733746852; x=1734351652; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp96rNOgUdCLF0OjUi40gHTRwy5UJB9B8VdsGeJYiwI=;
        b=UaEJZtZqg2OTA3IpsAQ83ZrYNggrMLq6HGQNnETdx3iE5AnQZzH9wq8ZqoT78WqToU
         5hLwa9QfWfLZJZ93wdvhRxgHsfo3MtiV6u5C1dsOFMmTqCtO6ON1vI5QKHImgLoUdoIB
         onwdBLDc3LfPSbykh/Ne6f5pX4EDgS5RX4IDjOARs4J/xmmkELy45Z4psxTqKOAN1KlO
         8O43sM153UY8DjT5TSj59bqy07r7dH6UMY1KaY+2p2Bm0M3gy8RZOagIMKVGvJC+PSWS
         hRUuQjHoChgVEufdF/jWPCukUlMRwICPRuwND/dluFwGKfhsDm9PPxY2WJHb4WLYOFEl
         XO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733746852; x=1734351652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vp96rNOgUdCLF0OjUi40gHTRwy5UJB9B8VdsGeJYiwI=;
        b=IjHynTOYsUz3u82zMkeTxsj7DciFhbuRF7oNOv4Dd76d/BLuofUpw6KnEofwQmplF1
         BXfFcMr5Um4/mDs91FuYOX+T5Ph62GRyF+you+xYdXq2nS9SIH2UU9GfYgwNcQUeC2oe
         iTxIIZoRNd5bfCfShH48jSCDMYXywCRhinu9RAnzf9u4CKZfoR6EhqZuuVDRdVUqjIBb
         4STHm75BcyigqybmxuZ8cg8vicxqz6hInBGQRkPGNqBh1QAnOogBndCvfa/qmI8K/mpk
         rdTdFh3hOqxP1OkVWivqVBUZbKlfIua9pHYNcbih1nICVlx6QJA3E1VChi8baVvJcHcd
         bMXw==
X-Forwarded-Encrypted: i=1; AJvYcCXitiu/mu81kaTp6zDAN5B6YAkjr4OHCCVMQ5wFl1jaM/Ogzei6bYVT22oWecAGW1UuIQNuzKVM@lists.linux.dev
X-Gm-Message-State: AOJu0YyhcMMneRfT6swC6oMMfn4hIKOoRilcqMwN2fUeStkp3yCbZgno
	nfGfjiczbp5B0vvOLalRuWP8IkIAzWGNdp/s+3leHKRyxhAkbY3H
X-Gm-Gg: ASbGncsM4KcKWxoCeY9YmQ2nujPOKTb7F/+9cIpyZMnbG6J8NORbiOr8Gym8wRT3QX1
	mPDcQG9chMnbgqUwGAZc0AL1+PXS5oLYslZlKYdk2m4wXh0jbjwOHllWE1/v+u6kXtnJblCVOuO
	iv7RL8B0HDy6HjAwKmlzG0ShaOoxfSGtRboXygCM4OWBTRIu0Fj39ibgX6ugsM3FLU4+xiVUfZO
	t+CJpoiGM4WRguAK7vO79PrIhN+dsh7Oo28KDDA6QQevao0QGderxQDte6oxyl58g2dfZrb
X-Google-Smtp-Source: AGHT+IFLjXzVVNJjymf27ThFBKxjKPsrNZovATz6/VJZDnGbM/z4YOwgRDmb+CJnuo/a1jHWivZi4g==
X-Received: by 2002:a05:6a00:f0f:b0:725:c8ea:b30b with SMTP id d2e1a72fcca58-725c8eab745mr13348178b3a.11.1733746852371;
        Mon, 09 Dec 2024 04:20:52 -0800 (PST)
Received: from c6b487f3e4fd.tail12dc50.ts.net ([223.72.120.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725deac1daasm3135655b3a.171.2024.12.09.04.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:20:51 -0800 (PST)
From: Qichen Qiu <ruiqurm@gmail.com>
To: florian.bezdeka@siemens.com
Cc: ruiqurm@gmail.com,
	xenomai@lists.linux.dev
Subject: Re: Re: [PATCH] lib/cobalt: remove unused `pthread_attr_getdetachstate`
Date: Mon,  9 Dec 2024 12:20:46 +0000
Message-Id: <20241209122046.706065-1-ruiqurm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <faeb387ee51b7d32574a582a771d4fe5108b6b76.camel@siemens.com>
References: <faeb387ee51b7d32574a582a771d4fe5108b6b76.camel@siemens.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Florian.

I apologize for not using the checkpatch tool initially. However, I 
have reviewed my patch again and did not find any DOS line endings. 
Here are the steps to reproduce my checks: 

b4 am 20241209_ruiqurm_lib_cobalt_remove_unused_pthread_attr_getdetachstate.mbx
./scripts/checkpatch.pl 20241209_ruiqurm_lib_cobalt_remove_unused_pthread_attr_getdetachstate.mbx

The output is: 
20241209_ruiqurm_lib_cobalt_remove_unused_pthread_attr_getdetachstate.mbx has no obvious style problems and is ready for submission.

Additionally, I used the hexdump tool to inspect the file for DOS line.
hexdump -C 20241209_ruiqurm_lib_cobalt_remove_unused_pthread_attr_getdetachstate.mbx | grep '0d 0a'

If there are additional steps or tools you would recommend for 
verifying this issue, please let me know.
