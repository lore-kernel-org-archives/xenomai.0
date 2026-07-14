Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D370542BC26
	for <xenomai@lists.linux.dev>; Tue, 14 Jul 2026 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061875; cv=pass; b=YvpoOQOmUbUcdAwYlSll0TzWNSCZvWIFa/CyT/VrfVyhzhmca50E23fhXT2kGM7MZ5V0W+mG8jgFYiv6izm37W2zUonoHrab/wi7S0IjAd7gewe9JoSFz/k7SUbV4d7jCGakS+Yv8y21CYASyJuozTV8j4v0g4quf6X4kZhagL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061875; c=relaxed/simple;
	bh=0Zh/XVDigj+PY5dQrXckEXvZEthCYVWuUQ+4uxnC4H4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uEQf84sjPAMuyPBwBmKEuYv9NiyYDFIwGPhR9jytEFFQyHH4BzKpBZUskTNPg7I1yGdCnjecKV4wKzGzx0VzXY5y73oAM+3eg9Qjw7Mg31Eqzk4jw26dhSXfkJk7lJ4WCApPsVPv44cYBOG2XH+vM8thhq2D8CzIVm8YkwA/Nas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aerotech.com; spf=pass smtp.mailfrom=aerotech.com; dkim=pass (1024-bit key) header.d=aerotech.com header.i=@aerotech.com header.b=U7uATxR4; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aerotech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerotech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aerotech.com header.i=@aerotech.com header.b="U7uATxR4"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c16794450aeso11942266b.2
        for <xenomai@lists.linux.dev>; Tue, 14 Jul 2026 13:44:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784061872; cv=none;
        d=google.com; s=arc-20260327;
        b=lj247Yd8EERi6vwQ/t7/hPX+kHBaesjE3d8hv2Nt2P+LK2uOKcAmSfIHSlh76V9wkA
         iwlYfq/fGaDe7Wizv2hVMlVxcrb142VmoTm63cGtTGtONJNlHHFUSyl5rYwKZssj/I3x
         YRyEMTmrpG7I7VcCmOolMZgEPn3omXN5mNwM8NuMOrL+J0njsSR+zg6GtIGxUkuY0KM8
         d9I1HxD1AUH5HpLD6LmKnjZSLv8co7sTyfGsQUhSIDjecMyhHESlSJ6lk8y+hBgBM/0Z
         Xx/7IAC7LR/MI/wvSLU+S1RjLGHcUpPTftJnhSSxrByXvp3vdKaVzWK1t65xSqlqM0yt
         98Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0Zh/XVDigj+PY5dQrXckEXvZEthCYVWuUQ+4uxnC4H4=;
        fh=YB3B87WifQ96wNOuamgxI2TmGE/J/7vmGnp4rylPnkg=;
        b=RwOZPx+EdyHS9LbSuKzwD8ZG76fvmmKwzzcDAhB3GyKUxDF8r0o488rSrlk6O7gSs8
         V7TEsQFl9OSzuGnJ4Z9/urDq2ZEaXDpkVLYYbf1ECInpiEMQXUAlyYybg/p2KBqnp/12
         WyiESdcqywGTKJ/taB2tutaGyhlJvPecE+uUNSWRf+dMCcqFLJP79swgqIxp5r4hxZP2
         H6Z00mNAnURN38Q5A70Wz6HcXFgEC4KvmFw1Rn/63PguS/+Ekm78a8MyNvE7sJr96B6O
         U97RcylWiTUn7TtyluLInSk9ts84G78VwlN2FBNhIwrWAdtUg1SZdmF0hgrcGZ9brbs8
         qk5Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerotech.com; s=google; t=1784061872; x=1784666672; darn=lists.linux.dev;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0Zh/XVDigj+PY5dQrXckEXvZEthCYVWuUQ+4uxnC4H4=;
        b=U7uATxR4K0lvVFEQHP3oqJDbHFJA4PkWaUJ+bTGOmkrvdbysBdyutd8VaBFHCcrqIg
         7QBN8Rd6qqsI4d5Lh5YG1cPLVgVGB6SEaduNmt/+FXb2WfzQgpP1L2FB8L5XHUBLBslb
         mvmWSLObMbGeTsA2wuENnOKTh4RmeZiU899nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061872; x=1784666672;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Zh/XVDigj+PY5dQrXckEXvZEthCYVWuUQ+4uxnC4H4=;
        b=cF5Oan0zZnPVUAiavWtrO8dnrORH04Q4DOuGjdpHvkrcmudMKxjs6jyCA7T6xy+6ll
         wdAmTpawFUwgImPNPyUenBFWjSAs0LzO56jJoG/fD3kKJlRacmtLZ0Ri5QX07hDYsEtk
         7eXqbHdkD3EdY+s9QWcOFz/p6iOlJLFIX9G79t7I407yhTSm0uC0kpej0OQ/hqbV7ZMT
         u01zem+I9ms8gemXPUHJFUXca10gcV7rx9rC+UHu8hvCHnNot2L37IodEIzFHfqzI6Mw
         34cFjNhZTT3sXa4UQtyHQs2pW5BncrrCRUvGWe7Akv2hP041bLO1xJWI+Mz5LvBMunDw
         EF1w==
X-Gm-Message-State: AOJu0YxjpAQMIsXMyeof93nG7g2CPNPum+cHUjLFDftPjiTHgqbvq22x
	k32uU5kyoZ4tMCpDuqztfvqxmIO8Cw/2wj4WS9Qyzn+fkhMp8bkqfCdY2acZERZVxjLYyxSF6JR
	6FM/1JiW47buCkbeK9EPb/VSdT18Ram4VK7mVfe34PZFR4u7l/M6kycVpaxc54IaxRY2r/NsNHE
	7ghANvHlNN5bRyaWvOqIkuWn82apxLik58F/18d2pPgvfxfsZ/36QRBZEIeTPIEPkLxDmirFB9P
	eEDBaushU6A9tfM8N5NFKDM+1E+wvI52XAvI8LqP2psw9/L0/oMuEBjaAPemwry9ldzUP7CCtE=
X-Gm-Gg: AfdE7cloqbNhyZNj7aKCFFPk0dzPyOlZKi+lQyEP7/XRUrf7YNDXpQPINc8D6IAxEke
	6I2tBC/35o1tkO1lQAbvCpQLMnwMZ4JXLEHV7HQHzKN5x6XP6KLTmdO+npYttHmS+/gVV1pfQxg
	0jYPTQKgMIlhfM1JH3/+TfY1R5s5YomtmimqHzGyGn0m8JQu8/ymujVpsM872OROP+JAlk5I7bG
	DvNI++N6mozo43w7l5zBBsqOXUwyBzoXodjVR51cVJiCe2NnXzLzh9juUEyn7VbT2HBARkWLg==
X-Received: by 2002:a17:906:6a22:b0:c16:b43:b802 with SMTP id
 a640c23a62f3a-c16616a7ffbmr277625866b.27.1784061872036; Tue, 14 Jul 2026
 13:44:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Kevin Strell <kstrell@aerotech.com>
Date: Tue, 14 Jul 2026 16:44:19 -0400
X-Gm-Features: AUfX_mxDHhNGyoqzwbKAFP2tzlu21CctoNVtdiRJSS516Qth7UhyCfDn3gHotA8
Message-ID: <CADfsJ_GwXvHioDB_HvGWardrTj_wFJJO-q0QtER42duwZFoi9Q@mail.gmail.com>
Subject: Xenomai 4 Allocator Fragmentation Questions
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: aerotech2,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

We are currently using Xenomai 4 on an AM69 on our new prototype and
appear to be running into fragmentation issues with the default
allocator while trying to use thread local heaps. After several
seconds of operation our application starts experiencing allocation
failures with evl_alloc_block_unlocked returning NULL. Our heaps are
allocated on reset and we do not extended or otherwise change the size
of the heaps during runtime. The allocated memory in question is
allocated out-of-band and is typically under 100 bytes but
occasionally there are larger allocations. Additionally, we have tried
running the heap_torture test on our platform and the results do not
seem good. Pretty much every test with the +shuffle option is showing
more than 50% fragmentation and many show more than 90%.

We did try the compaction procedure documented on the Xenomai 4
Caveats page but it did not seem to improve our situation. It is
unclear to us when the compaction should be triggered. The
documentation states it needs to happen before mlockall() is called
but evl_init() makes a call to mlockall() and the latter seems like it
needs to be called first.

We have been able to avoid the fragmentation problems by switching to
using the rpmalloc library (https://github.com/mjansson/rpmalloc)
instead of libevl's memory heap services. All that being said, we have
a couple questions about the default Xenomai allocator.

1. Other than the compaction procedure, is there anything we can do
with the default Xenomai allocator to improve the performance in
regards to fragmentation?
2. When is the correct time to run the compaction procedure in regards
to when we should call evl_init()?
3. If the fragmentation is a known issue of the default allocator, is
there any other allocator that is recommended?

Regards,
Kevin Strell
