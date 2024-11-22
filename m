Received: from redirect.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09678134A8
	for <xenomai@lists.linux.dev>; Fri, 22 Nov 2024 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732283911; cv=none; b=QhfcNJd5Mj05TiWPzW4sRo+rwb9v0AHtGNoXceJWaEHUP0bzOqdSvksHLVa7ZJprrPkEDIpiBcafP9yhzxIWA01D92yZfYWGI7LX9P50gQ6Cek2VvWZBVipTUQyzNUEPG6z3gQLZReaACPaZQ5EO0d1+EssuiIZIwll0TE4FvGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732283911; c=relaxed/simple;
	bh=3GaX1h1oiOg6hRPBgBBrkDWoNTFOsFInZDZSxYvQUEo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BW6nsQdaRGz8pKBfpkJerFbjxUcePZ61TSzCne+DN3g7vSFr4iDGL77VHIdEHpRr7HZKcFqkVilwmuyLhwSbe0v8KoGDm5P/3lhDr+0WJdDmqyP8/aGBjCmUNPQTMPikqyZpgRMIQyTmBdDQFYcaqlQh3mhBCCx2zyV1jzonz5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net; arc=none smtp.client-ip=217.70.178.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redirect.mail.gandi.net
Received: from spool.mail.gandi.net (spool2.mail.gandi.net [217.70.178.211])
	by relay11.mail.gandi.net (Postfix) with ESMTPS id 0B2C1100002
	for <xenomai@lists.linux.dev>; Fri, 22 Nov 2024 13:58:24 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	by spool.mail.gandi.net (Postfix) with ESMTPS id 541C874003D
	for <xenomai@xenomai.org>; Fri, 22 Nov 2024 13:58:23 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3823eaad37aso2075457f8f.0
        for <xenomai@xenomai.org>; Fri, 22 Nov 2024 05:58:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732283903; x=1732888703;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0nCHjz2N6yEQEPOI+OsrPYq/PgyZFu696Jk35aJGQg=;
        b=pC76O5GHpRuFfuZJTjnPkeLslZeiQ5ovY67gm6AwqUGUpVCWqg4IjTFFp4/uzPp4WZ
         nLWTSqUo2Mr8U9xQuJXIQrNyd5FkPS6FBwB8WJcL+c+LSKrkxAquXkWpToo+Fos+bKq5
         7KbVjaV1wNHK6CZlsko9gvPp7ugDgoPZMvcbAzt0wOXRltdOfTFW3kvmyq7LwhJv90n2
         7Zb+RuZ5dIf2cII8Ra7/46s6Su0Be4ngl1++DuJyFMIeM/TdNvqV/vAuKdPw2QY5Ok1z
         VuFUxxo5sWHaOGLbDGtRWORpXtZ6cGWsOR0o/xv+Kf65LD93NPhtETLaPklVOGfxfEl9
         v2fQ==
X-Forwarded-Encrypted: i=1; AJvYcCWntasmPxcBz3AXe74m6HJwtQv2r9E+0xX76/bN9PIb9DR4xPGsEoHNrI0JG0ErNYmkkPkxb7Iq@xenomai.org
X-Gm-Message-State: AOJu0YxiYGdle2jzBxScgYsOdajZNQKvnGIQ+BeMHtyofZpIG4iCkb3S
	wrSq4l8ZhtlOU1sfj18lBw5Nem9dSdcN9w4X6Niz197q9Ar9yDSbVOzUDjpm
X-Gm-Gg: ASbGnctrrYPzud+PQu9Vt4FaVx/CynIuokpmX7DH+DfdP+u7ANmNOFEdUgSMP7aGT4+
	7jOoabcKPxxBNz/cPRstPNH5J/xY51DJzXPRWksNAAL1HJoTGi0a8SAGv3o7Qh3LnYlDl+yQQ5s
	VT2Dnh4bSBArRsRgnBqtHlkRMkCTZ5xpHRJwk+CTOU0amXC68cWryITRYJ/qsx9VN58FTLk7/vQ
	KClf0ESUgofSLKgRSNczLHKSxZc3Yku4Qk=
X-Google-Smtp-Source: AGHT+IFGhU/lwufoysjQ1bNhNH10/5AP2Lmx3WDASVraIrO7u9AFX9gfsdYyqe9o+Opr5IdV8AGPwQ==
X-Received: by 2002:a5d:6d03:0:b0:382:22d6:988c with SMTP id ffacd0b85a97d-3826011336cmr2842435f8f.5.1732283902514;
        Fri, 22 Nov 2024 05:58:22 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fad627bsm2473835f8f.12.2024.11.22.05.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 05:58:22 -0800 (PST)
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: Florian Bezdeka <florian.bezdeka@siemens.com>,  Jan Kiszka
 <jan.kiszka@siemens.com>,  xenomai@xenomai.org
Subject: Re: [xenomai4] POSIX API
In-Reply-To: <d276fea7-2873-6014-aea3-acced9943f7a@bela.io> (Giulio Moro's
	message of "Wed, 20 Nov 2024 14:34:56 -0500")
References: <87ses62bi5.fsf@xenomai.org>
	<d28b8d0200ef0e3ff63e833b64c2ad00c554e351.camel@siemens.com>
	<878qthiw8i.fsf@xenomai.org>
	<afea1670c26d61ccbd18b6a7b609498bb1dfb020.camel@siemens.com>
	<8734jm3try.fsf@xenomai.org>
	<d276fea7-2873-6014-aea3-acced9943f7a@bela.io>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 22 Nov 2024 14:58:21 +0100
Message-ID: <87jzcve5fm.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: spool.mail.gandi.net;
	dkim=none;
	dmarc=none;
	spf=pass (spool.mail.gandi.net: domain of philippegerum@gmail.com designates 209.85.221.48 as permitted sender) smtp.mailfrom=philippegerum@gmail.com

Giulio Moro <giulio@bela.io> writes:

> Thanks for sharing this with the list.
>
>>>> __real_frob() would require explicit call via some macro trick like
>>>> __STD() with libcobalt. Others would be invoked under the hood via a
>>>> plain call to frob(), depending on the insertion of liboverride.so
>>>> _before_ libposix.so on the linker command line.
>
> I am not sure I have a full grasp of the suggested approach, but I'll
> share a request for clarification/feature. On Xenomai 3 it is
> currently possible to avoid link-time wrapping and explicitly calling
> the `__wrap_func()` version, while regular `func()` calls result in
> the stock version (equivalent to `__real_func()`). I find this
> behaviour useful and would like it to be preserved in Xenomai 4. I
> hope this will still be possible for at least some combination of
> build flags.
>

Yes, this will be preserved for x4. The approach I'd like to see should
prefer explicit over implicit when it comes to wrapping, the use case
you described falls into this category.

-- 
Philippe.
