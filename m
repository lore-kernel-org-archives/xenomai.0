Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B11DFE1
	for <xenomai@lists.linux.dev>; Wed,  9 Jul 2025 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072945; cv=none; b=V07eK3VAEiQFpOy5jmhEioVjWxvZy8fceZCabJcmZQW9RmCHCRzRmjLpuQ4CnXgOhZY7wiIRDT+V9M8udo96bLsbWvL7BtDwzyRamVESOodOBAbtPCnP0z1lWb9O/DWMs6wOBDRpiPrQ3rlugjWIR5Tv0U6Wz8LHjJK1kg1Ba4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072945; c=relaxed/simple;
	bh=nI0EFksw9EjzaLHpffIUjxfz4W/onS62QXSCNV59fZI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kJsamGwPthSVV0P6Cobyby3+n+V8ZIvT1kM0RIO+uEyn7hjwRqRmEiHJNb0drqu6e61UkO5KpnE1qx2hwj1QibRFs7saPa58PA+stnDnwo6YvQr+Xz4iqK6gJQAZPQKUGsSjPzkDpZixzwR35DK8rvAUv6GGJ837m+op2iE/+zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VT2B8T7c; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT2B8T7c"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b39011e5f8eso70411a12.0
        for <xenomai@lists.linux.dev>; Wed, 09 Jul 2025 07:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752072943; x=1752677743; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m8HQO07no7+rA2UCeU/RWDE194WHV9lUeobbn3buZKk=;
        b=VT2B8T7cek6AXIeC7nbsJCcpTM8dBxDBWvUYyEhK6izdmbktbXS8nEMts3KKPco/DQ
         yCPffoer6sqyOPMH4+0ZqqP6ZdiiRaxyDZoJ05PJorZx2j9IVE7p6Hf0o4n27OzNeF5j
         KXPTFv89J1b7DsQ7oT5KBsn4u0qdnXB45LxeZX5fSC2ZoeReGBzaKBI2Vg4wGBYEeubD
         FbVYgnDceKhM1Ai11KHA0ADDokd0VNPzLIyflIN2tEgccQOWdRnEbLVQCvuTiPNxhjIH
         KXXvwJywMW6pD/D31rVA5IyoUr+VRXfwPL7IF8vuc3W7y2qgAWJZ9Ls4nU1R3KmvMU4k
         uUzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072943; x=1752677743;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m8HQO07no7+rA2UCeU/RWDE194WHV9lUeobbn3buZKk=;
        b=rYJ2aOE+hE2c039eNAmBFVzlXgBcDBY1lr3D51HNndP1Ug/txAOCa9fmtDWZF0SeR6
         HV+gMrMI8repS5NUrzkAWlDQ9fD36X8RY9CrN+6Qu1qE++EqQ6wZKJtcn2G2dhMqR5rM
         7b4+f88NWPXfXTP8pkLqOFfkRJyhjfvt+kCM8w5dekTQX+IfI+v0zINKVriS72RXW/YD
         M0JNparUoR26aRqM68bOXXalDf98FI+EcA4RFZidvAbHYRprR0HgM/+7dOBwSPyxbLGN
         nrznFdNiFqq9gWVc/5GgArKhO9t076+O0vry9xXmzJOWgxEIyjYcuakmaTcY5aYKmdNY
         YxDw==
X-Gm-Message-State: AOJu0YyYas8jsNsXrF+aITWX08JQmMlPicnUDKwCXGHhgQTtE7oZp5fD
	D/s2kzQVu+KCDqRtobDUcIGEOIRZrRtKRK1lLnqg29uPUYRgFSU7OPcj+Ik52LclGQKNoD3N6Qh
	opA3SDn4zK9WjyS7A9sdO238lvOMl+P+eBDcH
X-Gm-Gg: ASbGnctupzH3jCsm/3GkE2MotTuFOxxRhoMoJ140h8ct50D6U+JAsqD8AH61dq9mZWo
	QQg4ky4t3J67W1T5nDPp4iajT/sHPsjE1xRIraStwsg3GGoS5LwdrAljPTDxIR5D4x5tFt8wNfm
	LsYI0r5nqUpn826O4taFDjsWQYwU8u/IoaocEoATpwp0pviQ==
X-Google-Smtp-Source: AGHT+IEnItmwbRHbnGDAONfx4MKXfSWJkK5kZNpZPRNdXSayCH19qDLJYPc5cPPCNIzCBoof1M6/sBu6AgFWvYOOors=
X-Received: by 2002:a17:90b:1dce:b0:31c:38f8:7e84 with SMTP id
 98e67ed59e1d1-31c38f87f76mr1841781a91.16.1752072943421; Wed, 09 Jul 2025
 07:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 9 Jul 2025 16:55:31 +0200
X-Gm-Features: Ac12FXx58VwCyMxJAbf2R24_aEhQ5U8tvJRdtJrv3geizTPwC9UBIDzlqoe1CdQ
Message-ID: <CAFLxGvy2U_0hfTKfPPZAui8XFBMAFqxLnjgCUcD2-Xw3=79UBA@mail.gmail.com>
Subject: Xenomai Meetup at OSS Amsterdam in August
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Like last year, I expect that some members of the Xenomai community
will be attending
the upcoming Open Source Summit in Amsterdam. If there's enough interest,
we could arrange an in-person community meeting at a local beer
garden?

-- 
Thanks,
//richard
