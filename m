Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDED374
	for <xenomai@lists.linux.dev>; Mon, 27 Feb 2023 01:26:45 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id ec43so19547613edb.8
        for <xenomai@lists.linux.dev>; Sun, 26 Feb 2023 17:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d4kzwT0VMH0rpdtFS2EJqYVDiJ1EdPyCSV/9T2G+M4U=;
        b=qmvdkPZXpLzSTSpl/YpGbRa9qXwc9u2k5Awu61/PmF+/82M/HYQUlx9qhSqxOCxqHi
         Me5pMiwv9wrNH0F45bbjjkObyp7bYDpfqpBaaCS6VHxgIIES5j+F2933Q8GQELDfnnRU
         6CJ6K/NawCRswPDtBHWeQJ4w4WfuNKcvcoBTJ1z8YpuiP9G5kzpfkZAR6otFJ4XEPnLL
         yNrsZ+i+tQz9K/N0gfWqbWap5R6FWwMV/TSBVJTHtQU/eTA/Vn/AinJnbAWWef8rgapd
         JVkC6MfKhJ10oZK5Iw3eG9BsA2ItzpCwOlqkzmfx05pH7n32ex9u0Y9CFuSCQebiVMl1
         WqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d4kzwT0VMH0rpdtFS2EJqYVDiJ1EdPyCSV/9T2G+M4U=;
        b=RMXSkPL01jDehQo/HQ8w0tKVocnmcHdu2udUCKEde0jQK52ddCxmkxwmDDbY1byld3
         O5tFzgalf7aHnOrE30ZUBPxa8ByvCS+It3PHM9cQmvhHJ1Ffyqmxw2vK2zhBE9UQoyE8
         l87ZtJChK6OKp8Y+yXxjbYAWiOfcaj7AxOeiiWyxVpucbtEYy+UvNktolP6tBTWCTjom
         wRdqKN31w+OnG5cGTzQaTKDfBEvMizT5Z6Fp6kkESfJteMAX5jwZmXGcFMGhS6OGmX27
         esXjiFBquDqaufAwvjFgZdjYoo4w5JV29ut7wPc0l0UP2YXaK8XdIGxnthI7U/fQJP/1
         3Zaw==
X-Gm-Message-State: AO0yUKWcmeNIIYBq8Kx1uspAkA1mf+qjAMpuLz8WCMblzGJUKOZfcAQg
	nUyyZAno0xflZwq2QBDU5ot+fVwROxWOHVTmTDv2nNA4PXA=
X-Google-Smtp-Source: AK7set8q+jd6CLhByp1PEvVjoINpuz+et0BAFcPVy6W6d25yuDRoPi2SjETkXmE+k47t+v64lnjjVJx0a3qzsgi7Zec=
X-Received: by 2002:a17:906:9410:b0:8b1:b795:110a with SMTP id
 q16-20020a170906941000b008b1b795110amr15817416ejx.13.1677461203743; Sun, 26
 Feb 2023 17:26:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Sun, 26 Feb 2023 17:26:32 -0800
Message-ID: <CA+K1mPGxOi=GFfDbE+nq99HsMWEe0+Q37bw=X=UHjqb-yNfj9A@mail.gmail.com>
Subject: xenomai 3.2 compile failure : cobalt_lookup_vdso
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

I am unable to compile xeno 3.2 after patching and booting kernel
5.4.228 successfully.

I had done: git checkout origin/stable/v3.2.x
Kernel is patched like this:
[root@host linux]# ../xenomai/scripts/prepare-kernel.sh --arch=x86_32
--ipipe=../ipipe-core-5.4.228-x86-12.patch
I am compiling xenomai for 32 bit apps, so maybe that is unique. Here
are the configure options:
./configure --enable-smp --enable-registry --enable-debug=symbols
--enable-shared --host=i686-linux CFLAGS="-m32 -D_FILE_OFFSET_BITS=64"
LDFLAGS=-m32 host_alias=i686-linux

The failure I got is as follows:
...Making all in regd
make[3]: Entering directory '/usr/src/xenomai-git-master/lib/copperplate/regd'
 CC       regd.o
 CC       fs-common.o
 CC       fs-cobalt.o
 CCLD     sysregd
../../../lib/cobalt/.libs/libcobalt.so: undefined reference to
`cobalt_lookup_vdso'
collect2: error: ld returned 1 exit status

I got the same problem when trying to compile 64 bit, with:
./configure --enable-smp --enable-registry --enable-debug=symbols
--enable-shared
But I actually need to compile for a large suite of legacy 32 bit apps.

I can send my kernel .config if you want it.

Thanks in advance for your help,
-C Smith
