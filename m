Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA0A4879C
	for <xenomai@lists.linux.dev>; Mon,  5 Feb 2024 23:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707175501; cv=none; b=dNfnVCzDEVaxtX3gzOadB/c6ev9/m25OZnU2PITgL9zh3FIjrw7TnbGVoup7b+DLtxWbhdurkPT1u49F3XJ0c8G9b8Ml7aD06tsYo6+XgC5zvaev7NxXZc4OCFZ3yzP4E/VCO5czvIKqMOtZRoZsi77bRYjCjidt51P9So7h+0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707175501; c=relaxed/simple;
	bh=GUnZnRMEWeC5PzvBUYe56SoqX0/LEfp4EFfomUMsirs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SnbaeKcFPr1Bj78eOb/vswHfj5/gb2i/NevQFWmbD7jyAJkfKWo/SpZd0m+lHX+AkH1FWCnv0u1xogHcP1hnenORN6ufl9iG7CM+qVhHvLN4LEfRLjf9FSrNnYiLKuMYEsBfyLz0iFvq6TNWoLWYq0B1wCDrglEPNctBrirb3Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mytra.ai; spf=pass smtp.mailfrom=mytra.ai; dkim=pass (2048-bit key) header.d=mytra.ai header.i=@mytra.ai header.b=C3qiV+XM; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mytra.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mytra.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mytra.ai header.i=@mytra.ai header.b="C3qiV+XM"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-296c58a11d0so184021a91.3
        for <xenomai@lists.linux.dev>; Mon, 05 Feb 2024 15:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mytra.ai; s=google; t=1707175499; x=1707780299; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GUnZnRMEWeC5PzvBUYe56SoqX0/LEfp4EFfomUMsirs=;
        b=C3qiV+XM1s/htCSjMGRkU0/yCrQlDW7vFWQJSnKrvB6c2eSL+ayHHr5lKDXKgutYwO
         fPCHuW5/qAJW57TLcbFowUUrjJccmkTSySSDhrBtvaebt55BblGqchHKzH1dosRfAenL
         /bavk+R53csiy/CwNZM4rpM/yRFyUfGxG9PGGjgv83sGRKFz/sDUKSnYAUpqbHgaMj+5
         9F781pPpfw273TvnvpHi8cnyjJANKcZk6FoyMYpncp2C/PjBnSAPaAnvrKATDsdzeX8c
         TfE3D5qsVomtZ5J6H5oodNdNqSIrxVAinEyje+9oTtd8vz2kdIRe0cptuz33He+063Gg
         Ne9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707175499; x=1707780299;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUnZnRMEWeC5PzvBUYe56SoqX0/LEfp4EFfomUMsirs=;
        b=lGGC2sgyo9h+aQrV7M2KzKZR9popdAwh8fZhbR8aLaGOSf/DGaeZuvR8w2PQ4m/jAC
         6g9+i2DEJzWI59huL2tnBP4+dB+Sx/Naalk+vxnqIfdfuaY8LD+nC+BSql8QnZlPUsMx
         Vm8Ehri+IDA9r4rKn/+ML0xVD+y9hP7Goj3e2TNjgHK6d43CKkmmIMnQIDhVwAoEM8nN
         HNSdQ1abUHtxjZy/zeqljk72LrV7jaqqNDytjoPT+MHYKqY9NB0PYakUVGqWIdrZ9TfI
         ml53D0oM4OiBhGyeDd5Wmn/m2/ih/57LjAET9jn7bgY3cV62IJuPsoqTExdXgn46o75c
         PUgA==
X-Gm-Message-State: AOJu0YwljrAf7G1XGPh45cyrai/KW2hL19zrP4O6pQnh+7CbgP5QyeFz
	gkGeYKmO+agkMxLaOxR6uwjCya/jOesnoudSCbDuhF6ajc9la0Qny6oGptmXSBCL8tnOBU0ocsT
	aQc48XOxY74cEkmAoAh4jirkPNLYeKFRcTJW4boCeg777bzBqPyjIkw==
X-Google-Smtp-Source: AGHT+IE2PbBgQy7qboa71zapMQeKDhOLNM3kAtVt6L8AuM1HG3TNKG6OT7w8dhNe30UqPWc5iCFBEp+7S/nFo61FFdk=
X-Received: by 2002:a17:90b:23cd:b0:295:fe86:ad25 with SMTP id
 md13-20020a17090b23cd00b00295fe86ad25mr937347pjb.36.1707175498866; Mon, 05
 Feb 2024 15:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Mit Jothiravi <mit@mytra.ai>
Date: Mon, 5 Feb 2024 15:24:48 -0800
Message-ID: <CALB5Fwj5g-feayCXagd+rYhq2Wkwu0cgixZssDJs5A_WAmNuQQ@mail.gmail.com>
Subject: Xenomai 3 setup for BeagleBone Black
To: xenomai@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Dear Xenomai Mailing List,

I hope this message finds you well. I am currently setting up the
Xenomai 3 project for a BeagleBone Black based on the instructions
here: https://mairacanal.github.io/install-xenomai-beaglebone-black/,
and I've outlined the state of the setup currently:

Specifications:
- Board Type: BeagleBone Black
Operating System Specifications:
PRETTY_NAME="Debian GNU/Linux 11 (bullseye)"
NAME="Debian GNU/Linux"
VERSION_ID="11"
VERSION="11 (bullseye)"
VERSION_CODENAME=bullseye
- Linux Kernel: 5.4.106-ti-xenomai-r33

I would like to run the `configure` script to specify the single-core
processor using the following command: `./configure --enable-smp`, but
the script does not exist in the Xenomai 3.1.x stable branch:
https://source.denx.de/Xenomai/xenomai/-/tree/stable/v3.1.x?ref_type=heads.

In addition, the self-contained source tarballs outlined in the README
-> http://xenomai.org/downloads/xenomai/, returns a 404 Page Not Found
error.

Any assistance would be appreciated to unblock the Xenomai 3 setup for
this board.

Best regards,
Mithun Jothiravi
