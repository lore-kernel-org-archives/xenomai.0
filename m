Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037E320B7E6
	for <xenomai@lists.linux.dev>; Fri, 10 Jan 2025 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500912; cv=none; b=WJqf2T0Nr5Pzer8gIsH2kT1KgerSebB6kWiFaUBUYqyxtiIDJ+bE5MUeuIpnDUGiTc+yDF2CluNWDggQiP8EfNT4p3z2YMID0oJ/pYpcDE6MwBNw9nEQfB0KE3qTCi/XFCUacaJJ4aIkVtK5jIgcfX5WKvvHMnXwD6uQSzBNKWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500912; c=relaxed/simple;
	bh=q6k24NFUaTohJDZVgXsPM/NljOKlpzrEqlnmVNZXL/A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DjRrAH0BSqip+QYBRXlPYXYqB0VBr5/Gdfnj2gweGn+jWGWEnrAwWHroFOF1/l62ZgRrJqKjD4VDvgz3bxpcE980mnm/jxJAI3Y7Bdmfp/C3Dbe5bwEhN+Jg2vhWdaQ1duSDumxENCcXApglzAz0zzXsqj+2Tm3pfWX2kIxVNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1I4yu0Y; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1I4yu0Y"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso13567695e9.2
        for <xenomai@lists.linux.dev>; Fri, 10 Jan 2025 01:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736500909; x=1737105709; darn=lists.linux.dev;
        h=mime-version:message-id:date:user-agent:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHCshFuH3cykUn2alJRnDKTitPZabKchB410qz8qbSQ=;
        b=Z1I4yu0YfRrQcm2Dth/9yULCvx9NC3ElCUn5Wsajjmd/WtebQUlRUkoy/PeLvGfojl
         /s0ipFIixxwPRNKvcOEXosiIWL1vGLwoW6K0YCdrjn/IU4hQNsz95hjEEhJIlVsj7Xqb
         xh3qyXlDnwm4bbScYAp71D04RcDDmB/nEa1VQPSkN0upTNFWkegKvG4pjy7pd9JV9bfH
         E1Ge9ofL2VH93IsaVU9ElffpxgHo5Nl21610e5WPxzQrOVC4ekaLB1p6zaaQpewJb17D
         A5XAmkGS2a6K/JhB4cjCzLn7np60xxbHgeSyhSB0/MMCZTMbJ55trJyejO5wwiaplDuX
         M0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736500909; x=1737105709;
        h=mime-version:message-id:date:user-agent:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHCshFuH3cykUn2alJRnDKTitPZabKchB410qz8qbSQ=;
        b=EN7VwYI4kAV1ep927nLBkG4FJWknD0iwlrkrytrYjaDKIs1H/Zm+qaYmo6abZDIZ7n
         OuUUZiO5aJXMbw049Re7F441hLJuoyLP6+yzrqvU9lZ+SkN7J/ud7YF+reb3r0aFhlKc
         Kz+xO5cXDGUbNEt0rc8EapnurvNO0mfEs/a9WHLFSEyGf7jLUps+uSMZTh3D7UuXt/HB
         45zK7PtnRMJZsDavdLNyOdULMzZBzzS+vDqSphpDYgF6D7gxH95khyeCIDant0OpPEgI
         Z8GZRV4Ugm1gjcvFiekEfrFU1UQWSuqKEZTNrmcporVl8LFebtgMIhpoCs8I4W3QRYNY
         7smQ==
X-Gm-Message-State: AOJu0Ywd5fvS7bw30T/+rPDVxf/CzYYc1c2ehC+KCRdn91ykhG+ZRte5
	MVICQJadRpRo+z8yGVtK1Yd2ZHwO/dBoQm3S1o5gvceDeTHIxjz3QFHLMg==
X-Gm-Gg: ASbGncvRo+0+J5ud39/8aAwig2n1bcvcqp5iAx27bX5mjnecv0GAl2Poxa9igyX6cFM
	oWHgkAihVc1EflYj9JvSg/vsh7i55VdM8ieaICOLqZzfKAKzwWBnshc8Fx+ovMREqo/nzq2MoO4
	7NFAs8+Sn/+xTGeLHrFZFhVFoKNgy2sbu/VseJEi5j/J8VCF5voLW+VUtSLj4CKtMgJ9KwZI8JA
	jaYc2i7v2WNu3y4eAou23KHS3gJJ4VDD19hxwty9AmD8VvUjFwqzg==
X-Google-Smtp-Source: AGHT+IEFKgmLLeWdvQSH36XbVYwWKBEKm3gqkjkvPHnyCE4LlvqdrGQ+wQ6WaAP4yL3sxsTzL7j9CQ==
X-Received: by 2002:a05:600c:3114:b0:434:f609:1af7 with SMTP id 5b1f17b1804b1-436e2677361mr88927765e9.4.1736500909132;
        Fri, 10 Jan 2025 01:21:49 -0800 (PST)
Received: from pyro ([2a01:e0a:19b:3cd0:989a:5c4b:b7ff:baf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9df958dsm46041255e9.17.2025.01.10.01.21.48
        for <xenomai@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:21:48 -0800 (PST)
From: Philippe Gerum <philippe.gerum@gmail.com>
To: xenomai@lists.linux.dev
Subject: Paolo Mantegazza is gone
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Fri, 10 Jan 2025 10:21:48 +0100
Message-ID: <87ikqnuiqb.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


A month ago, Prof. Paolo Mantegazza, the founder of the RTAI project
passed away [1].

Paolo and I met for the first time in 2002. Back then, together we
went through a period of intense creativity, standing side by side in
the battle for a patent-free real-time Linux.  Though our paths as
contributors have taken different directions, we have always known
that our friendship would endure.

We got into the habit of sending each other pings of life, where
Italian and French jokes punctuated our conversations. Last December,
it was my turn to put on a smile in his mailbox. But Paolo didn't
answer me. He left before, on tiptoe, mischievous as he often was in
our discussions. This time I have to admit that you didn't make me
laugh, my friend.

Paolo used to describe himself as a simple practitioner of software
development, one of whose missions was to contribute a free real-time
system his students could use, study and improve for their research
work at the university, welcoming others to join. Many Linux users and
businesses owe him a lot, because under his leadership, the RTAI
project has always defended the freedom of developers to implement
real-time systems, particularly at times when it was threatened. His
fierce will for RTAI served the Xenomai project, as well as others.

Paolo was a brilliant mind driven by a great sense of humor, his
culture was vast, and his friendship was unwavering when he granted it
to you. He was often in a hurry like anyone with many ideas but no
time, always plain-speaking. One of those generous individuals who
embodied humility and that will leave us with an everlasting sense of
loss.


Ciao, Paolo.


[1] https://www.freelists.org/post/rtai/In-Memoriam-Prof-Paolo-Mantegazza,5

-- 
Philippe.
