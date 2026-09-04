Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B30334688
	for <xenomai@lists.linux.dev>; Fri,  4 Sep 2026 13:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788528419; cv=pass; b=XZeBq7fOBRJWTe2hIYLPnAVoN4TQIzWz5518+r8ScEgRIfxOzacpNFzp+uM3I7j0HLxs6pfB8YBgJtExM/Q354nBmetHASBDutKjHIXKnMa5z0cY5IfGiKoQ4hdjesPen3A5cqDN2+O7/jTs+7O1YAjWzQf52XF9mGERM2krFBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788528419; c=relaxed/simple;
	bh=yCW3wnGhVfmeFnfs/VeksP8XSavenN53Ld93nZrwtnU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QokyOfe1T9ibYWD5v9BCNa97gO+JuJ1yIswYRC9Y1Q880XS05ObcvMN7NWxZm/mhZZsqPVPWHy/uwi6/CBXAwIgcgOyCyfffvR19g3lDn+/Lee63zJiu579URZ7ocinhygnSWrVdMZlKS2qIq+ls5tDmD47uirmDbnclUM3Gpas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=elk.audio; spf=fail smtp.mailfrom=elk.audio; dkim=pass (2048-bit key) header.d=elk-audio.20251104.gappssmtp.com header.i=@elk-audio.20251104.gappssmtp.com header.b=HSUurhf6; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=elk.audio
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=elk.audio
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elk-audio.20251104.gappssmtp.com header.i=@elk-audio.20251104.gappssmtp.com header.b="HSUurhf6"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-867edb54b0bso660957b3.1
        for <xenomai@lists.linux.dev>; Fri, 04 Sep 2026 06:26:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788528416; cv=none;
        d=google.com; s=arc-20260327;
        b=sY+80ni4GMlPg9HSBQtnm2wl5+Sml2aVNxvKDig/RfqqK+1pCM1XJ8NGTrgBFvBe5s
         nqtHIVwvmL1zsld4pEk8TxIPo3cEZYi3A/jZM1scmnUj6cTz6IXjnzx8c894LNMYcbAw
         Q4E0mgB7PG4cPDyWxuNR3MsNipXTmboCOXylKbQoVlNLfHjD/RIw3sxk+wv8eoODBEYL
         oRX1+B5XbnPrxIAFO2cWp3CxtMEUhV9Qt7Co2MC6Zk5YLPRiMdQO1IvCJ9KYIdfdfbS9
         ZBcyPVYCuP70bHAPnkVrbvLzsDN85gGsd22lEwlfvtZZuI1HZs+67EgkONv6JYGXH+yh
         x6Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=yCW3wnGhVfmeFnfs/VeksP8XSavenN53Ld93nZrwtnU=;
        fh=YB3B87WifQ96wNOuamgxI2TmGE/J/7vmGnp4rylPnkg=;
        b=brJlNp0U+HWavaUpU+3ENUnPVdhjz3tkM8gTfEJRskxjxe6NqaYf06PcR9UbUQ/9+j
         OPtICTZMWnVkzU4R/YlpaLHZclfVx5RWXflNAFJB2ZbEd+STcHIyylK0jbhsYCoteK3Q
         LnNROjPBZksRSYYdOXX4SqYD1+p+1Z5ttR/1nCK6+/Hd/AQAtZ2lQSkeDcMP4sJWQxeu
         FwsyZuiTIRAWBSYsSm5L1gbN7j2Bk32v+BI2ki8D/mkk9Iji7zddd4dTDlmzCXpqgT1Q
         boJaGCY08c6X4uRIiNpenLWp08L6UH3UDabwIhGs3/IQHAQ72b1LZMCahuwf2XDBvrVZ
         Zm4A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elk-audio.20251104.gappssmtp.com; s=20251104; t=1788528416; x=1789133216; darn=lists.linux.dev;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yCW3wnGhVfmeFnfs/VeksP8XSavenN53Ld93nZrwtnU=;
        b=HSUurhf6bpzLUG1IgCDMOvn4o74FwiTOXV9hGTn7BwhTi1VRV4d/tHtTznZ0i1CUe1
         buMqwHayZbjL2ur72pwfJepqCyMRFGeHJU1w3D6MXw3WIAHFw+blwYdXSTyKmKY6gNy/
         KbMBBsOi+0J5uIvfQv6pIeVh/nUkbVcq3L1ZQpGhM5MqbOlqtK/VjAh2YLROsBwCTgi+
         zJ2CrUvNSxV8AjkKoTt/aI9SWDjxKjwEHh2XsdEMI8y7+oURWS6HgO3JS3hFMX0zpevI
         +Lv5isKXvOb/jP+9iyzonbDj1MbEuD4zsV+Oq59QX1KYFg28dUazRFt/GgOP+CIvwN5i
         FSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788528416; x=1789133216;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yCW3wnGhVfmeFnfs/VeksP8XSavenN53Ld93nZrwtnU=;
        b=HBym2bD+oJ2/LL3JURL8w8N9jajQ8/Thj2GQwmTCVuWpzC0fUKnu2ntRHVpkzxlXXQ
         siAJmZIeOeeACI8bEKne1y2nJdvtXHOpcvzzHKo08NkQZg3p4lxyw/rZiw1OX2F0dYQt
         6eBpb/SXmtClZPY0Ckplr1KyzKxaahNuqRHQzUyOCW9BI5HhMT3CmesMazX25CGxtA6R
         jJg1taK9iiCqIGMsmPQI28qZZDbz63umfV3sA4oDJ/gd4FY5EVBFJUctyzaXvnircJVj
         XE6VVnvI+kPRAp1Bv5E5QYtPSlMJ2lmHibx9PeHnNPrVLBSB6zH/BAZ2B1LZWTKfzazJ
         EYVg==
X-Gm-Message-State: AFuF++k49puSK4ux4slDow/NelD7AfKOgs8GO+cr2Fr8MT+xHWxi1jIk
	u2s9/NvwwRnVsFg21unwIhnmODZcF/EcsvB6HsubEt++pCxe6urQvCIYZHUQyS8llM+kdA2J8I3
	w91XPflFUyjqefKEktGGpxJmBPlMUgsnINQ0+kuipUZ9+fRpp3bwwtaA=
X-Gm-Gg: AYBFou21nmI9Lx+rESeWHWWjPUH5+FrV33typbmowl40JccXrCKRACSeNCjDHu5D3v6
	NTw+4goOyg70+F++KKX7nUXwvifSgifRoLS31cy9zCGPC0lWGzmU0Klk/TFDJTyxg6oPvCo40Tk
	gxBLqwFYmQx5X3lHqKtQZ2kGhT4vZwFhIX72PpwAGqdvLAjjourI4BqaHsTEbLfIjE4MU4LRm8c
	ce6yUUhuK8ont6px05RAPsb5FozzspLUGJmr6UNL/BdFPWP8FauV7ZR6pJrrFaW07mnpysWGgFV
	a3o7TgUYZwgf6b/xt/+IKSWBPJHsaqw1UCtAC0k9z+ws
X-Received: by 2002:a05:690c:680e:b0:820:18ab:ff72 with SMTP id
 00721157ae682-87127d2b0b6mr29115327b3.3.1788528416151; Fri, 04 Sep 2026
 06:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Andrew MacPherson <andrew@elk.audio>
Date: Fri, 4 Sep 2026 15:26:45 +0200
X-Gm-Features: AcwNN1V7DSUjfQkM8G5jN9ceZBqgnPSk7qKz2hzvvvq_kGGBlfCoWTREOFHm8PE
Message-ID: <CACiVkw=Vs1KUgfZ=Mq-rXU=4gPFDtmuoNoMv=rzy_kvV7KgpKg@mail.gmail.com>
Subject: perf getting all-zeroes IP on STM32MP1
To: xenomai@lists.linux.dev
Content-Type: multipart/mixed; boundary="000000000000eada68065aa83873"

--000000000000eada68065aa83873
Content-Type: text/plain; charset="UTF-8"

Hello,

We're working on an STM32MP1-based system running Xenomai and found
that perf top shows every symbol as "unknown [00000000]", i.e.
profiling is collecting samples, but they all point at address zero.

I'm not a kernel developer but went through a few debug kernel builds
with an agent which eventually led to the attached patch. This change
does resolve the issue with perf, however I'm not sure if it's the
correct solution.

The reasoning is that arm_arch_timer.c's percpu IRQ registration never
sets IRQF_TIMER, so Dovetail's copy_timer_regs() never populates
tick_regs, leaving get_irq_regs() to always return an all-zero
pt_regs, which in turn breaks perf's sample IP.

We're on kernel 6.6.48, i.e. an older revision of the (now-deprecated)
v6.6.y-evl-rebase branch, so entirely possible that this is fixed in a
later version, though the code appears to be the same.

Just wondering if anyone has any more insight around this and thanks
for any help!

Cheers,
Andrew

--000000000000eada68065aa83873
Content-Type: application/octet-stream; name="arm_arch_timer_flag.patch"
Content-Disposition: attachment; filename="arm_arch_timer_flag.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mtmyz7g60>
X-Attachment-Id: f_mtmyz7g60

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvYXJtX2FyY2hfdGltZXIuYyBiL2RyaXZl
cnMvY2xvY2tzb3VyY2UvYXJtX2FyY2hfdGltZXIuYwppbmRleCAwMDAwMDAwMDAwMDAwLi4wMDAw
MDAwMDAwMDAwIDEwMDY0NAotLS0gYS9kcml2ZXJzL2Nsb2Nrc291cmNlL2FybV9hcmNoX3RpbWVy
LmMKKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9hcm1fYXJjaF90aW1lci5jCkBAIC0xMjM1LDI1
ICsxMjM1LDI1IEBACiAJcHBpID0gYXJjaF90aW1lcl9wcGlbYXJjaF90aW1lcl91c2VzX3BwaV07
CiAJc3dpdGNoIChhcmNoX3RpbWVyX3VzZXNfcHBpKSB7CiAJY2FzZSBBUkNIX1RJTUVSX1ZJUlRf
UFBJOgotCQllcnIgPSByZXF1ZXN0X3BlcmNwdV9pcnEocHBpLCBhcmNoX3RpbWVyX2hhbmRsZXJf
dmlydCwKLQkJCQkJICJhcmNoX3RpbWVyIiwgYXJjaF90aW1lcl9ldnQpOworCQllcnIgPSBfX3Jl
cXVlc3RfcGVyY3B1X2lycShwcGksIGFyY2hfdGltZXJfaGFuZGxlcl92aXJ0LAorCQkJCQkgSVJR
Rl9USU1FUiwgImFyY2hfdGltZXIiLCBhcmNoX3RpbWVyX2V2dCk7CiAJCWJyZWFrOwogCWNhc2Ug
QVJDSF9USU1FUl9QSFlTX1NFQ1VSRV9QUEk6CiAJY2FzZSBBUkNIX1RJTUVSX1BIWVNfTk9OU0VD
VVJFX1BQSToKLQkJZXJyID0gcmVxdWVzdF9wZXJjcHVfaXJxKHBwaSwgYXJjaF90aW1lcl9oYW5k
bGVyX3BoeXMsCi0JCQkJCSAiYXJjaF90aW1lciIsIGFyY2hfdGltZXJfZXZ0KTsKKwkJZXJyID0g
X19yZXF1ZXN0X3BlcmNwdV9pcnEocHBpLCBhcmNoX3RpbWVyX2hhbmRsZXJfcGh5cywKKwkJCQkJ
IElSUUZfVElNRVIsICJhcmNoX3RpbWVyIiwgYXJjaF90aW1lcl9ldnQpOwogCQlpZiAoIWVyciAm
JiBhcmNoX3RpbWVyX2hhc19ub25zZWN1cmVfcHBpKCkpIHsKIAkJCXBwaSA9IGFyY2hfdGltZXJf
cHBpW0FSQ0hfVElNRVJfUEhZU19OT05TRUNVUkVfUFBJXTsKLQkJCWVyciA9IHJlcXVlc3RfcGVy
Y3B1X2lycShwcGksIGFyY2hfdGltZXJfaGFuZGxlcl9waHlzLAotCQkJCQkJICJhcmNoX3RpbWVy
IiwgYXJjaF90aW1lcl9ldnQpOworCQkJZXJyID0gX19yZXF1ZXN0X3BlcmNwdV9pcnEocHBpLCBh
cmNoX3RpbWVyX2hhbmRsZXJfcGh5cywKKwkJCQkJCSBJUlFGX1RJTUVSLCAiYXJjaF90aW1lciIs
IGFyY2hfdGltZXJfZXZ0KTsKIAkJCWlmIChlcnIpCiAJCQkJZnJlZV9wZXJjcHVfaXJxKGFyY2hf
dGltZXJfcHBpW0FSQ0hfVElNRVJfUEhZU19TRUNVUkVfUFBJXSwKIAkJCQkJCWFyY2hfdGltZXJf
ZXZ0KTsKIAkJfQogCQlicmVhazsKIAljYXNlIEFSQ0hfVElNRVJfSFlQX1BQSToKLQkJZXJyID0g
cmVxdWVzdF9wZXJjcHVfaXJxKHBwaSwgYXJjaF90aW1lcl9oYW5kbGVyX3BoeXMsCi0JCQkJCSAi
YXJjaF90aW1lciIsIGFyY2hfdGltZXJfZXZ0KTsKKwkJZXJyID0gX19yZXF1ZXN0X3BlcmNwdV9p
cnEocHBpLCBhcmNoX3RpbWVyX2hhbmRsZXJfcGh5cywKKwkJCQkJIElSUUZfVElNRVIsICJhcmNo
X3RpbWVyIiwgYXJjaF90aW1lcl9ldnQpOwogCQlicmVhazsKIAlkZWZhdWx0OgogCQlCVUcoKTsK
--000000000000eada68065aa83873--
