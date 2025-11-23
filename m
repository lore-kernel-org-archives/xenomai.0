Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6902220DD51
	for <xenomai@lists.linux.dev>; Sun, 23 Nov 2025 07:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763881480; cv=none; b=WSg+BCjiGaANfzKaReEWVTfykhcgBJ8I7pkfZucha575G1n4lQbBD+dHYZvDXkUcvDNfAXU3s05DaZH3hOoQY18+FLXisaHZ4d9ee0V1aFENwCXTQwq1JOuwAmq85CGQMT4fxo7Bb8rmzGbl0qF0ZFpiqCTPVzwVRG2fte9IHuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763881480; c=relaxed/simple;
	bh=qAXsXZwCbPPF9J3C3/lvlPF8uf6QUEmHmjuR7xwiRRc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=EElER9HaYzvpEQ5D4Xbl6W9O31K1xLQILVlUPYozRK4O6B5FezWdRc18W0hUddbbCAHpmUGOoyo3XIqj68viAE+mEAvyCHRt7iXPPW5cF7YqhXO19W0CqM4GeH7JK0qHAMTNlL5eaWhSAjwzovCzUyke7BUOte1a4FV5PE5enLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgEx4bSX; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgEx4bSX"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-935356590ddso862701241.1
        for <xenomai@lists.linux.dev>; Sat, 22 Nov 2025 23:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763881477; x=1764486277; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qAXsXZwCbPPF9J3C3/lvlPF8uf6QUEmHmjuR7xwiRRc=;
        b=fgEx4bSXLiOl7pA17uRG1LM3pUqOpH2fbeDVfmCX7964e3bwdfo6CtDMoQzMdR0np5
         QpGa6uyggqZfgZtHSmlSMBta3+J9XYX4dG9fECQbNolhfNOCDHpcUyPlTnCrk/qttjtu
         sQxRn0bRKS7wbXfgCym5GNAmwFDxY8wKj876wsF7f63DAip0gS7aRNf/zEdZrJO2PRBi
         h7RQwkC8Pr2Rk5C29R1hbeZfxG+GT/Fi/79D2ZGaDUsp81D60DhznVZ6a3GzD+mFZr2D
         VHhMTylx6nKVUtoVrleCESsAUAT8EwdG8IInLA+AnIBfuOhot8RnA7+T+1bDegoUl0Vr
         FqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763881477; x=1764486277;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qAXsXZwCbPPF9J3C3/lvlPF8uf6QUEmHmjuR7xwiRRc=;
        b=p89A/DERxfvm0WSl4JMMcwAdRpJrfSVsJenZmSvMDnzmvbSWp7OcoCT0wVJgAMKEnZ
         K2rIyFi9CsAtYGoXeSJDc9O2YgrSu5+LaeMdeu2Zx00iVVSGaewHQHB/28q4qA8CVqdP
         Buc4XraogZfEy0OZu7cOK1rvy36+ruoOfEwsxzIl+cOpldO2Pw+/sHt2/I0NLhWRYkxF
         ebdWPqWwS/MW/32HHfNE1vg7cQn1M/aDWTQPvoiCYFDPgmfrjBmNK83o5iFgWbkyC2WC
         VF5g6uND6G0NJhMLrbZhizvG8v2RS5dukZX3cpMS9aefCsD+9rGKA7pGcGyLmseB6u8e
         /hTw==
X-Gm-Message-State: AOJu0YyoNvGYgHdonvixAtYBoRRsEO7VrjB8OwBqD4YMhcAjvio+1HiM
	/6FhKpF3tEg7/lBryYtvPukFto3Frv5j5YgEDdpV/kzzPakW9PbMhlvPFGAH3PI3Iq5ysAxjQfy
	TfaDcUIOqeoMMnNKl94Tjpfcvjeva8N/+OUb9cLE8Fw==
X-Gm-Gg: ASbGncuWm9I415EtFagGFK5BWw0kQrzAN/jQwyosBLL3pvcKJ8DVrqR2HGD2R+JkCvY
	kTW9cTkxE0s4qMcwMe0Kd+E/feBsOYDvjTvDZ0bPfZJgXqDbXDmAdbQDBPWemR1wsPbEr1Wcgsw
	8YiDQ8T/21HJF1EujZdUkD9LnYOir13fIKnHUgBSNW2sm9MlVkRZ5TStu50iDCrDZJ4LzpoCzGQ
	mlY9udHbrjHhdjiqFG7k3LtFFq0nUGV8yOBGROOJZg2EWnXfaIU61oKu3qFwyCzd49reUL2Rhp4
	M+KngIiIyvKK8YQuM5ek55j2c4BpdfqMdAbsJg==
X-Google-Smtp-Source: AGHT+IHWRySn2RDJ9qLhhLnXlQa0XJMNQGF2k9x+uGmn+RW6vxLpkv97T2SrXBvs++hI9JxNthGstfFreMPO9GvNjac=
X-Received: by 2002:a05:6122:4689:b0:557:4110:6b97 with SMTP id
 71dfb90a1353d-55b8d76b72bmr2120666e0c.12.1763881476903; Sat, 22 Nov 2025
 23:04:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Noyal Johnson <noyaljohnson455@gmail.com>
Date: Sun, 23 Nov 2025 12:34:25 +0530
X-Gm-Features: AWmQ_bm1l4Lh9SMk9Tt86I8ST8_CbO54EW8rA3zsqwgOK5XB2rbH0LKcVoaLjh8
Message-ID: <CAGx0mQ-_=vJh0H9mKrTBjpy9G+H8GHuSGmxJFi=s=nEAfoq=9A@mail.gmail.com>
Subject: Kernel Porting Query: Xenomai Cobalt on CentOS Stream Kernel
 (Dovetail Patch) - Boot and Latency Issues
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Dear Team,

I am currently porting the native CentOS Stream 10 Linux kernel to a
Xenomai-patched kernel. I have successfully downloaded the CentOS
Stream 10 kernel source and the corresponding Dovetail linux
(v6.12-dovetail2).

I generated a patch based on the difference between the Dovetail and
native kernels and successfully applied it to the CentOS Stream 10
source. After integrating the Xenomai Cobalt v3.3.1 version into the
patched kernel, I can now see the Xenomai Cobalt configuration options
in the kernel's make menuconfig.

However, the following warning is displayed in the configuration:

"Page migration may increase latency. At least one of APM, CPU
frequency scaling, ACPI processor or CPU idle features is enabled, Any
of these options may cause troubles with Xenomai. You should disable
them."

I attempted to disable the recommended options (ACPI, CPU frequency
scaling) but the resulting kernel failed to boot. Conversely, the
kernel booted successfully when these options were kept enabled and
compiled.

I would appreciate your guidance in clarifying the following points:

Technical Queries-

Boot and Warning Conflict: Why are these options flagged as warnings
for real-time latency, even though disabling them prevents the kernel
from booting?

Low Latency Configuration: Which specific kernel configurations should
be maintained or adjusted to achieve the lowest possible latency for
the Xenomai Cobalt core?

Dovetail Patching Approach: Is creating a patch from the Dovetail
Linux version v6.12-dovetail2 the correct approach for this kernel
version? If not, which Dovetail Linux version would you recommend for
better results?

Benchmark Results: Are there any available benchmark results for
xeno-test runs on Intel i5 series processors that you can share? This
would be helpful to cross-check and validate the latency figures I am
currently achieving.

Thank you for your assistance. I look forward to your positive response.
