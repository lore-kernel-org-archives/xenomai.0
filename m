Received: from redirect.mail.gandi.net (relay14.mail.gandi.net [217.70.178.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CFFEBE
	for <xenomai@lists.linux.dev>; Fri, 20 Sep 2024 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726811869; cv=none; b=tY8/1r8J+MqwJ2AUGAEy+B4p3bhcz1UNsVoF5YHrF84h9svoAhsJcH4mTjYSSlVUkJiRVek7UOFwTO5yQJCZ8Bm2m3HA4z9fO4q8TBWM/VkElusqBlG0mclxvBudq6Fmcd3Dsh5jEpnWEZkDzWNEupuW0EZhq74geXX/F0mN820=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726811869; c=relaxed/simple;
	bh=iGr99V0xOLCJ6agCQ+qYSPrjfSatvpvRS2ybrAXMnh4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JXv3d72pkxYi9YKVfeb6dEUjzTzN5FCbvnZuV6AxtgsRewR0jYRRNR42z2GrV2PCoiGz7APLeBuIxAOdg/Jx6wsChlhKVosWLIKSF142mKlnD47vCXhkyDRfj754w+V4u6oNVn/1+PpZ4H1q2dl8JM2UcgNmvtSkoqoY0uzoj3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=redirect.mail.gandi.net; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=hbtCc5BL; arc=none smtp.client-ip=217.70.178.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="hbtCc5BL"
Received: from spool.mail.gandi.net (spool3.mail.gandi.net [217.70.178.212])
	by relay14.mail.gandi.net (Postfix) with ESMTPS id BBD5B1A0005
	for <xenomai@lists.linux.dev>; Fri, 20 Sep 2024 05:57:37 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by spool.mail.gandi.net (Postfix) with ESMTPS id E73D4AC1129
	for <xenomai@xenomai.org>; Fri, 20 Sep 2024 05:57:36 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2f75d044201so16650121fa.0
        for <xenomai@xenomai.org>; Thu, 19 Sep 2024 22:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1726811856; x=1727416656; darn=xenomai.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0GfEoQ3LAReEluOt2IpLjTzolMshKUym03jguhTSQVI=;
        b=hbtCc5BLJSboO7LokwNFkXmhkPv/+dGSeIGmUkSlZZ4yf1dEHU9X8NlIWFitG0m8Jg
         0F3hqwdRjCC2XmqZUl95Hn2Z9As3jgnd85NtWCfwXZe2O4IYcivOO1AMJaSYJVFXBP/L
         Lmnu5B+xoT/PvK7LQwJNIj29Cigx7fFWTCDws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726811856; x=1727416656;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GfEoQ3LAReEluOt2IpLjTzolMshKUym03jguhTSQVI=;
        b=EQMNIwT5ZsokKL+scQpFednd2oVMfnBMoZ10VDIg5ABzoc0LjJp3skvmAu25mEM+f9
         qtbj/a8+tbZPqCcri6Gv3sApP1PERylY8Gcx5jG9ENNCRa55JQcJ4S1ySVJnqbaBTTas
         JD+L8bfnjFiMuKK/ExQeCU44NdSaX0ALTNzknypmY64BQDOfa1331exw2pAk75FuJWba
         GhJ0vT1o97+ElQjosSRWcNjfLPE90bCUdrrZaZ9yAmFNPb+p8kLHrlG3Zpx6NfnT7EzL
         +T0du66e/ltGbaace3U8NDnTFBtEsoYONepDL9jwK0jJEY8Knk2K1FMdf6PLpilDWoTh
         NaAg==
X-Gm-Message-State: AOJu0YzWe8XqfOI5MQvNw3UyWHVVtNhfmbbmU7v6otQHiIzAWbd23GSG
	zw1jrLO1C7K72R3AKgK7w+UWKY5g/peJPNmXxpIIbtyCO50OPOL3pPfjsLF/zgEuUte8JD2zYm4
	842J2a20y1Zys0BQ+nyYKDy3VG0clt9krxGNTusncrD+It+XqmB8=
X-Google-Smtp-Source: AGHT+IGJiNKkZfiwopwHkoXmjVWELAZSnEKR8YF7+WOjVHAemGB+Y8YHnaC7nDnLnNMWzEO16VQ0024wdKQC6RP0Gis=
X-Received: by 2002:a2e:8048:0:b0:2ef:2f8a:52d5 with SMTP id
 38308e7fff4ca-2f7cb319be4mr4647251fa.8.1726811855553; Thu, 19 Sep 2024
 22:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Fri, 20 Sep 2024 07:57:22 +0200
Message-ID: <CAFc1U0vYfF_aj5a0zz7GwpjZATgB9td4Usc6JivATCe6tmoSLQ@mail.gmail.com>
Subject: POSIX API for EVL
To: xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Authentication-Results: spool.mail.gandi.net;
	dmarc=pass (policy=reject) header.from=smile.fr;
	spf=pass (spool.mail.gandi.net: domain of pierre.ficheux@smile.fr designates 2a00:1450:4864:20::22d as permitted sender) smtp.mailfrom=pierre.ficheux@smile.fr

Hi all,

I've read some discussions (may 2024) about the lack of POSIX skin in
EVL.  Supporting several skins just like for Xenomai 3 is not
really useful but POSIX is an industrial standard and so for people
willing to use Xenomai instead of PREEMPT_RT.

In the EVL documentation
(https://evlproject.org/core/user-api/thread/) I can read :

The main kernel=E2=80=99s thread is the basic execution unit in EVL.
The most common kind of EVL threads is a regular POSIX thread started
by pthread_create(3) which has attached itself to the EVL core by a
call to evl_attach_self().

Don't you think a kind of POSIX "wrapper" could be useful or is that a
silly question ? Did I miss anything ?

I'm about to start a study for a big industrial company and the lack
of POSIX support is a real issue.

Regards

--=20

Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
