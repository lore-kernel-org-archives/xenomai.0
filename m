Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E02236828B
	for <xenomai@lists.linux.dev>; Tue,  1 Sep 2026 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258042; cv=pass; b=KlIIiC0ZO1rAPplwErGHaBipc62VbeOorViQAYD+ws59FlaFR4b5oIIA/OlsB/X1R2bjKXKpIbGbgTD4DtqchJjNjoh498YTJbQp9Kk+RNsZJah0c7fe/JiMZcnK5pYseVqi5uj7LWopYH9TBWKeDVl0uZ/fhFWl45CBEUj6h8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258042; c=relaxed/simple;
	bh=GncmK2rIVMT19kKppznnVQvuVShJYaMeRuVOf8qOzjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pehDUe1FrRoHitEBqaeNWp9CaoqzKawpO3YNeYUwBNEYFunHEOuWCUijsa50LfHarNMdNEffLMU6GJy0ndXeGFBAJv1/WGviOA2W/ZZKJhxFJfMiemewjk8ohlMvEuxWyAjiOH9+01TLsbYOD3g/72Kdnl/ad9E2v6IiFfRjjSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com; spf=pass smtp.mailfrom=lmitechnologies.com; dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b=WQ0JcvvO; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lmi3d.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lmitechnologies.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lmi3d.com header.i=@lmi3d.com header.b="WQ0JcvvO"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a623987d32so1104263a12.1
        for <xenomai@lists.linux.dev>; Tue, 01 Sep 2026 03:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788258039; cv=none;
        d=google.com; s=arc-20260327;
        b=qkufDUzANbJgJ/Qoi9WazEf4XBZ3s/171COG5JQgQaKPN+lnUfK8sjy2SBTa6kMUUu
         6INOpywQMXOsGoUdvcaMIxewrLDwZ4sCUNOblDfkuVUPGbxBblzvkwGdpbVx5O0HPxjk
         YuA7oTWgugne0PLg0Y+TnuKxQMKtzvghVZkUjH5M16/wPwX2P+cIfzuX2aNEg+WYRjpk
         4RW7MER/357TYNYuuq3ip4IQSqVZ/dVTV9smnjKjSNxJYlCSh/K3QGySY1aezwfJtAMF
         0raKYn0SGRNi1X00Tiux/MJljXqtCywk7j+YrQS0frmmE+tAgR4qVVtHcGNX2EmIFQFv
         x3wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KOD12tgbkiFUzbSBT2SvSBv+k3X8eJ31fzszZlQ7mp4=;
        fh=LT3E7z1OhinzAbWZz7o/sop5JKdqEDmDpjLO8xiqjQs=;
        b=icZrUDSEkbBdHyD+U2v7rkLSi1TkNDybrak8uohdNNSZrkJddYI5RiiEqEmIiTTGbY
         lkJ4MjBUf31Soj/gKBOgQI2oqdBD05SdtluIOJ49uDSrk9n81a1nBjgdcBtVHiMwEd0q
         AcHnShc2BSpAts8LVVUoXxULtxFpawZg0GB1oVAisdbYrs4xrlmg1cGujL0BxtbaJEs3
         2NkzD5CVSN8x7Jxjcv2rqvSY77eqdqo424kmTz2B4S8JtORok65TnN3U7uIhJITXNhza
         auXhOH8zcWKqoQeXbOyll5mfG/u4KP4p2vhSL+04rjZDUILuoKQ9p4uoekQxnl1GfqKM
         uASg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lmi3d.com; s=google; t=1788258039; x=1788862839; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KOD12tgbkiFUzbSBT2SvSBv+k3X8eJ31fzszZlQ7mp4=;
        b=WQ0JcvvOxT5ViHQiB8NXYm2/t18jdn+kK6oA7+aqGNoCixHnNpq5B6Pb4PHQng0HW1
         F/iwh8X5KhX/D3qI15gbPKpVvyd+iofLKzcNHGqPt0KYjqAmV2qjLBEUnO1qmDBEY3T4
         4ZM1TN4dTawuAm9IrY9QR8I3WSzBtzsOnYB6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788258039; x=1788862839;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KOD12tgbkiFUzbSBT2SvSBv+k3X8eJ31fzszZlQ7mp4=;
        b=RhA9uJgQChWyubFTc+V3pqnyPrRJjPCzb0wwo/JFt88WmzQR22pVAcHS3u3yj/XL7F
         OD+FLlMadnAa8NZeBKM3YJ6KVXHXgyoQegtzLVq1n3ljf8lycfm38u68m4GfxatglLc8
         iAxd6YQlgNiQjmXF8ytHKLlyJrSvvT5xtZqbtBUN5BTAxEl9Cyg4+JAEUGlYEshzBlNb
         JgHd11wAbnBXwUYkdOTzeZutNlptNt7filwRHaiEYDZ3DchKVHnfesq6zXQc0KJhTHU0
         RF/69nrMVXmYOsp80KVBJqLOzmdXO/tmoGuipsvuVj7oYtF08gKakSyUkXMqhx7AA9P+
         mJ7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxxI987CN3IW8Vx1nVT0FaCzXMFpwZbXulxZYv/lPAhOnemmuqdM8BRTl+kUOkE3cUQDVTcBREc@lists.linux.dev
X-Gm-Message-State: AFuF++kfTni3MK17T1gMXS0rHDczouz9BF7hs40Ys2HYooALNe1wuGIW
	YQJtifGBL0DyxHNovXhzw97N3RAZfgeRlABDYQDyoIgUo8wPOyB7hH0Zl5xKHRxht7nD0bDYq1/
	dyEab962vFAqmfQEcoFhYNTbcqve6tfVQC3duK9y16bytPJleCxDMFowPJg9KbVBFA1NvwnGbr4
	bGIYbThW0h1qDedx3WULXR/4jJKoi0b8/vlb7H0wdWUQoYM8q11VdSuj3tMRcefCdIF19H/AI6w
	Nzk4WN3RYJ/flxtUkCkL9jAWlL5GwU=
X-Gm-Gg: AYBFou2YjDLBzdWvWTAhI0Zyop77ml0uAOv0VCnaXVTvQ7AAbavjNdPCTUAnh2A775L
	lzUAbaRkm0WUm+xb/VvjJPMYmouPjqoNongfXqZVlndyg33yQCzRYwEvdunvhGZnsACkhLyHnrH
	cjy/QlS1qTeWLkoHtzRS+ZAf+EQ9kkOysX2X0g4xgK0kh+WDmrnW1LEDkHEs17S1XeV43OBQMBM
	rU9Bpwv0JjWk8B9bsoCtKh1K0Jbtgqs+NUMKIAwzDtCKaaxpU7rSVYW3pnOfFKs9BfpG+Hj5kVN
	6Tnsygg8luef9+DmOCelc0XdGO7WsdWpHEQJ8KwWqpsETu80oCaTgLq8uoBUDSqXphyQw4/5Hhn
	GTW3wjpLV6o81QbALb8uYaIQcjBNh9RqE7F9nqZwZI4h2SZ1nBueZo2CnvMzEddnjm6V8bzAx6r
	jzL44LWF5Yxe+ZFevNGQ==
X-Received: by 2002:a05:6402:a251:10b0:6a6:3e9d:26c2 with SMTP id
 4fb4d7f45d1cf-6a63e9d27b7mr7832461a12.1.1788258039277; Tue, 01 Sep 2026
 03:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAKndYJGo5Yu7Ak694tX=cqRjtJneXs22DPjz=UDVkUcNJMWyOA@mail.gmail.com>
 <87v799kt2q.fsf@xenomai.org> <CAKndYJFhN5MfybdumExs7b5gTqW_CHa_i=cOL7R6xgjad1ytDQ@mail.gmail.com>
 <b7d8d1e3-0353-49dd-b626-5aaae76f7526@siemens.com> <CAKndYJFsiha4BZ1VmyM4-XADyNJ0RusC+TPJAm9k2q99=khLLA@mail.gmail.com>
 <87bjb0lqob.fsf@xenomai.org> <CAKndYJGm0Ne6_fMkrNmQoE92LZmSghyH23CYmht0Ogs-obRH1A@mail.gmail.com>
 <87ecfv31rb.fsf@xenomai.org> <CAKndYJH5PjEnOz9Y1e_uDTHf7Lupt5d2W=hhc11jVpGjN0HcQQ@mail.gmail.com>
 <CAKndYJFO3n=fsAGCZq1bgTy8Sot+QkZ8NHG9H-H-dtVBzS1azA@mail.gmail.com>
In-Reply-To: <CAKndYJFO3n=fsAGCZq1bgTy8Sot+QkZ8NHG9H-H-dtVBzS1azA@mail.gmail.com>
From: Gerte Hoogewerf <ghoogewerf@lmi3d.com>
Date: Tue, 1 Sep 2026 12:25:34 +0200
X-Gm-Features: AcwNN1Xwweq2ua_RJe3tdi5uOqC7t2tYMbGi8ISL67MtphvkpDRTfQeHMNVrhHQ
Message-ID: <CAKndYJHo--bOwSh4Sg7wyuPuWnFcHkPrg_bBRLNYWBm3VQ-VnQ@mail.gmail.com>
Subject: Re: The state of Xenomai 4 on Xilinx Zynq-7000 (or ARM32 in general)
To: Philippe Gerum <rpm@xenomai.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hey Philippe/Jan,

Did this fix land?  I can't really see it on the remote.

What's the commit hash?

Thanks,

-- 


This
email and any attachment(s) it may contain is confidential and is 
intended
solely for the use of the individual(s) to whom it is addressed. 
If you are not
the intended recipient of this email, you must not take 
action based on the
contents, nor distribute, nor expose any part of the 
content(s) to entities or
person(s) beyond the original distribution list. 
Please contact the sender and
delete the email if you have received it in 
error. Thank you.
