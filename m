Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E10173
	for <xenomai@lists.linux.dev>; Tue, 30 Sep 2025 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243456; cv=none; b=pRG4XZYzHyTzEnEM3YfDieNh1GjvmH9bRQyzdK66c9ssrLymbthCKescNNeednCgEJEvGfvpLak5PHo/nZKh3xH2a5RN/jGfYwHS2Hs383qRGEsfoPc5ykNO94q6pmO0h86KPcvHljAgKwa0WqI0S04DvNO9yZ43z9q3bBdM/c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243456; c=relaxed/simple;
	bh=UOqUPnS5dKleqvrghaCb486K4n0lfyL72+cMbJtYF+k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=LJIR3dN4BgadNGntRZ/j3Sr9Ycr92QAWjjg+6cUPHYH5sv4hxEZUYaKkyKKTmcH3F9QooIkzeR9B0VjzGnU9KOOt/iVgefXysL6cS6FdC4MH4K38DhQZy09Nx0YC5sKk5NEUQITln1pR3figM8YUy4XHzSBEyVmGF74Cu65ZEsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=tyhOwIzn; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="tyhOwIzn"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-373a56498b9so3047371fa.1
        for <xenomai@lists.linux.dev>; Tue, 30 Sep 2025 07:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1759243449; x=1759848249; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rx6O076M/tLx8zWpWqTyZgDDFa9CvJGeiXqE+CAdMMs=;
        b=tyhOwIzn+460lRWfBBXDkJ3fjU9OXNp06TvC1Tr9CZfX9LTjFpz8gOicRZWCeo47nA
         XUjgqLa1ohF2Gb4yDD/bFL4k+cR4ItTvdIiLYaMG2clyOPfdwZ6SwKD5l7yNWwkUqgVy
         r2QWuGdAoutvjeKMxFhZEURe2lQ0IArkHLuX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759243449; x=1759848249;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rx6O076M/tLx8zWpWqTyZgDDFa9CvJGeiXqE+CAdMMs=;
        b=oPiFXqfRIGFQOQljJ27QXpoZaRhzs0w9GwOpT8Jo6W0JCIcpq/I+KfjGZQBCiIDqFJ
         T76q8cWLHHioJMzOYS9cjzZ13JFwgsgHQlyuvsSflzOkY5UjplC0ukLzp1hhY/2TDgMX
         blgqnBfnLg9E5wgeI0AZoqCP2ovDtZAaHI6I878G9ZDjD69hyvmwH/ZOtvtT7tFw9lgv
         /uoIezmkbe29uYekKJQLwTXCoetfS5AXu7+hvICzQJmEMcOuEsdBtaGnCo6yJ2r6bbXO
         xtzOmgIR+9LODbSruXr6QRkcp2gjMV5skYTUYoZdfXEP7EGY8IybWI89f5f4GVadeDH0
         Lr1Q==
X-Gm-Message-State: AOJu0YxwFhNJtHBf6FiJVXKujungddN4CTZ4LB8aookoXrzwMMU4wNzO
	2dQ/l7B4dQAOEemOr/iTZsG0P4m2zNs6aIKvRS4g0sWOontNNmCq9za3RVHYaSXuIj/BWBu9+tH
	v2RhCxWzkxjbsKNmpLxrUYaY2F3Yz+54Kt85oKuRkyL92gQat6b7Pgxk=
X-Gm-Gg: ASbGncuk2d4jOOLKa3j/amFPp90JmuyCnBNZ+0041lP3bHiE+K/Y4InPzkzMwfEW+tX
	jYjtp5fSs3I1RsSRjjELB8LIVV4vIbgkETZS0M72E4uIaSJ1FKCIAakMMO6PTyWFs3Is5yBYJVh
	VTCjbrccT9jcACzTND+sl7YWpDaGVqhKnpUXVtIYIPIldXvCFc2OSNN3JSvNS1UfsB+GOx43ke7
	ZnooXqCygbh4L7mPbcw3649bJC+vDBZSWasGcLn4F0ktdWN2WiibU3satvo2zGN
X-Google-Smtp-Source: AGHT+IEG8fK0MGIikgPzvmYfXNW8BHnugz5J/ZiPOL8O3nbu1TCT60ij74dBEpvQzQLyPOFLnmluurzF3nR7u/xClr4=
X-Received: by 2002:a05:651c:502:b0:372:89df:9673 with SMTP id
 38308e7fff4ca-372fa29f95fmr13260621fa.13.1759243448622; Tue, 30 Sep 2025
 07:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Pierre FICHEUX <pierre.ficheux@smile.fr>
Date: Tue, 30 Sep 2025 16:43:56 +0200
X-Gm-Features: AS18NWAmwW0VOjPsAw2T42xa-u5iS5oN0PNLs0s8zny9RApQawf2mUbpIAM7LoA
Message-ID: <CAFc1U0tVxe4sYCkmjyUxTBZDphUm71V8wfpjj9CbyeDwe9gVNA@mail.gmail.com>
Subject: Used memory by a Xenomai 3 application
To: Xenomai <xenomai@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Linux, one can get the RSS and VSZ for a running process with top or ps.

Is there a way to get the same information for a task running in the
Xenomai domain?
'rtps' does not give such information.

Maybe /proc/xenomai/heap?

# cat /proc/xenomai/heap
    TOTAL      FREE  NAME
  4194304   4188544  system heap
   262144    262112  shared heap
   262144    262112  private heap[18470]

Thx by advance

-- 
Pierre FICHEUX -/- CTO Smile ECS, France -\- pierre.ficheux@smile.fr
                             http://www.smile.fr
                             https://smile.eu/fr/offres/embarque-iot
I would love to change the world, but they won't give me the source code
