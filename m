Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EC1221735
	for <xenomai@lists.linux.dev>; Wed, 16 Apr 2025 18:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744827986; cv=none; b=HX9cRW+GHy3FWpyeuPoRph9mM5RI0WPQ7an3YiSTAW8oIxnMeRdoMr4rkLgN8ZX9AWX7BNklYVRcId7vMZZ1UnBpCWwS1CpSQX/ZVr/ZydZjhDIZaD1nrZuYYdXHI7GAGqUMWpk+57IXV693GbEKv20c6Di6iFIBT0G8oEAa7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744827986; c=relaxed/simple;
	bh=QAHWf5a+Zl1LYuqvkd8t8JHIl4Rmvmld6aEaB0L/cjA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=BW06MApuAW8qOBfqpzyoe6ITMuOU9PSSws9h131hETxU2jE46/m3SnwifvwdZ8GtuBoh+Q2hjiYVTp6l6Do/m0rtNC8ScQIBoBRBEH5KHyA7lGQA3b83ZRQd6BlyC/Pl2EYF1fnthgECpsO4b7Te8BQ7JYY2B1lARNk4jTtKV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2eDOMUq; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2eDOMUq"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2963dc379so1179692266b.2
        for <xenomai@lists.linux.dev>; Wed, 16 Apr 2025 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744827982; x=1745432782; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wAvTflNuoF+E8QXxoGQ0MWLnEuaH4nAf0art4Q3jQ4I=;
        b=e2eDOMUqoID0eBl5AMee23FUpOf93GC416tklbafCicF/83bhYHPvsHmuymAxFapY4
         9094joCr8tUW9wJTbzj2IX/5VDHrbGwRVTOd2BHr/teBsADr/9iJPAQQoq1X+uPZJHmS
         S0R8toFYyBDtc7wyQ+dp/VMh1X/ZTXKOq8jdGWouFE0DUnjFfZASgmlprqtXCFWqB9di
         AtmrirCBaD8s5aPnsj+5sukFyfRVLDD87jvkGw6ocP9+ttGjgG1QVzHPgAN+KoSNnQA5
         aF41q2WFrKcmwjUjLj1IlSo2ZUluq5lpg3FlTl7qGoah80ODapUIXf/++YU/lpUnZbi2
         yz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744827982; x=1745432782;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAvTflNuoF+E8QXxoGQ0MWLnEuaH4nAf0art4Q3jQ4I=;
        b=Xn0PdGqyCFlSJ54Mm/eW4XWyNK+uG2bCjHIOYqQmqbhbRUyvN/YpnvWJtlmhEtH2LZ
         HCg4k54vzlFZoDr8I35+vRdQQUcQvBtrZUmX5WW8SNtT5IB/eB0B+BGBR8y9LEDwPTdl
         InIb6BUJE7SQ7uVgw9XMOL2QlRn8D8QtCuOBB7Ztj76pjDRTJhDoWXfAspGJKEEPbFrv
         yiMTb1xo6EbnU544G+HDATpNBvcpdY6NmfNBg/pLwtYNotWXd7iR529B6HbaJayvyBiq
         g8Okz9zICR+LuTTUY3iZAeGhqSsUECNIdbKH654+kQiC1eRJndd27BEh7AMCaXZ0pkoA
         4nJA==
X-Gm-Message-State: AOJu0YxDVSVBO2hat3kjFh41tHJNr+Q80WMVlMzwg7TKIyx03mfe2C7X
	lOBxx4hrfYmfJJKKemghEdoqh+cfdaj4g7z4qlRhx8meCtA5P4GdKj65mgPAePH+iyaaeXLncW5
	z/KiYHvGr1Jn8GkpFhqpY50eydEbj8NKw
X-Gm-Gg: ASbGncsAtclDPKvYs8pbFuN2PWtaab1HfQBxvZAdAMkBWvRQ95pQsnBiAV/1rKwHTA/
	Es/winELaCiKWEd9dVWeB2pIAuvwldoDro9uNcn7gznO3OrH5EAIzfIAM3bvIy0PnHa9MhJcyYZ
	QUrRlRbgz7cNzqTcZxnEAMd5tZ
X-Google-Smtp-Source: AGHT+IGYFulZeyspSSOiL2jqiGXJRzcrBO8moP1tDsLVIeGbveaqJrQCde/wWBsgagkPwZ4yq/1dUbjRQDPaOONdyY8=
X-Received: by 2002:a17:907:86a2:b0:ac4:4cd:c26c with SMTP id
 a640c23a62f3a-acb42a4712bmr283167466b.35.1744827982388; Wed, 16 Apr 2025
 11:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Wed, 16 Apr 2025 11:26:11 -0700
X-Gm-Features: ATxdqUEx89vJrCJ5odkOkDf7lh17hwgd1wv2ofNt5t4oNpZ71S-yUholNlKtXY0
Message-ID: <CA+K1mPGcVn1BF0sdG0YHAZHDuQe=68DpBK-bXSSbApP2TV7Q1A@mail.gmail.com>
Subject: select() sets -EBADF
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

I am having a problem with select() in a Xenomai RT Task. A valid file
descriptor is associated with the serial device but select() thinks
the fd is invalid. A snippet of the code is shown below:

struct rtser_config Serial::serial_config = {
    .config_mask = 0xFFFF,
    .baud_rate = 115200,
    .parity = RTSER_NO_PARITY,
    .data_bits = RTSER_8_BITS,
    .stop_bits = RTSER_1_STOPB,
    .handshake = RTSER_NO_HAND,
    .fifo_depth = RTSER_FIFO_DEPTH_8,
    .reserved = 0,
    .rx_timeout = 250000,
    .tx_timeout = RTSER_DEF_TIMEOUT,
    .event_timeout = RTSER_TIMEOUT_NONE,
    .timestamp_history = RTSER_RX_TIMESTAMP_HISTORY,
    .event_mask = RTSER_EVENT_RXPEND,
    .rs485 = 0 };

int rtser0_fd = open("/dev/rtdm/rtser0", O_RDONLY);
ioctl(rtser0_fd, RTSER_RTIOC_SET_CONFIG, &serial_config);
fd_set read_fds;
FD_ZERO(&read_fds);
FD_SET(rtser0_fd, &read_fds);
struct timeval timeout;
timeout.tv_sec = 0;
timeout.tv_usec = 250;

int ret = select(rtser0_fd + 1, &read_fds, NULL, NULL, &timeout);

The expectation is that select() will unblock once data is received,
with no errors. However, select returns -1 and an errno is set to
-EBADF.
My app prints the strerr() below:
[ERROR] 10.746 ms IO Thread Select Error: Bad file descriptor

To verify that the file descriptor is valid, immediately after the
select() call, a read() is performed and valid bytes are returned OK.
Why is select returning -1 and setting errno to -EBADF when my file
descriptor is valid?

thanks, -C Smith
