Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4079A2570
	for <xenomai@lists.linux.dev>; Mon,  2 Sep 2024 13:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725282692; cv=none; b=sBdHNXBxekQMNzKjn+tsMpn38FTnBpqbVtoqZ+xhI674Ac4R8ZzkcnZ0oEQdj5qn3Y4KxEQSgmgNLuFPv7TRtM0wrW6Pvng+Qwt5Hk8tyxT0p1I5ymVvj27zuRnE/MfhMISINC9e9+EgRePXMVJhEjwSPE1eeaJTqqi0OoOxefw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725282692; c=relaxed/simple;
	bh=7Nm2N0Kdsw+4RHo5Dh87Nrm9+lxrQfPBdJmrdwI9JR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ATYrJIiVXAotY3otuU5izTknths/XD5kmBrhNUeMGPbG2fLP2uMRypDvpfex7g+KNk51mb0gFHQbX0GKD6mNsKvEH/Wx897pJmbboCva8Pp/mfDgg96BObuVPK3IliWfCXW5ebtWj8SMO/++U3sz6Qr58pPBKTmpIyOfGOJLpYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=E4kT2mqD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="E4kT2mqD"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374bb1a3addso1494700f8f.1
        for <xenomai@lists.linux.dev>; Mon, 02 Sep 2024 06:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1725282687; x=1725887487; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DAkCkClV8jwvTWLcJRCs46vuWm2vyQGLcST9Yh3r+0w=;
        b=E4kT2mqDn9sIHq4dix8837f28Y2GgODCduu7OyOPB9C+qu+xdO3+yY4G8y2FX1CaJ4
         wI06Cus/Xex3AHiDWDKXFOjjcGXZ9yTwjrLsF9O45iYdWdxPnseGD/7rEjvdCnXGCUZp
         YNSairIEe/5gkz+rdqoayjGy9WQZuaQo/tzjZgiEgSaRO924nhxr8uWocYqQNdN5fmdz
         wf3l4sruQQdHBGEEEJO/M8qXiQHxW2NnCzp9nS82wVzkRmRcfjzqG2V5/otpOROF4TQm
         fv3i1jprRh8cHqqRkVD/K3EVNh5V5rXOaoNmW7Sa3ckYHDPqRdLA1Hsp+bm7+fs2t1fq
         nyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725282687; x=1725887487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAkCkClV8jwvTWLcJRCs46vuWm2vyQGLcST9Yh3r+0w=;
        b=L4jCvXpMTc1GxToB9+xGqOD+4DeBgKWepZjajML2Dxwmxk5irBwRhiQbLZKkNMBPzw
         2LFN5fb+PUvLvvhZVyMCBreZqY549H1Ad0JU+ORFdZols5xUuSruxiB3mkDYX2srl9NL
         r4HvL2vminmXhbI94zKMwRAd58OU29zTOKoOqGKyV6/aNuq87PdtHA6FCXX0pvwTb2xF
         P/ZZzwqUy5c9ptzYRzwGsh/vxkOjc170TTgpMIPUztcrErakcCxr4g4tMkBEl9/Rb9SQ
         YMOyyGXLD1AmBaUXMC8+RSuT3G4Z4I4IRwjeYXWadTXBVVDnOxIJE/cf85CnU82hcl/Q
         eumw==
X-Gm-Message-State: AOJu0YxQyqBc5Yq544nVC9DMWHF9s1gO3Bn55brSom9HQGFQLSZuUkWS
	AQlRTks/SO0vCt92n6hc2YAX7ScTTx4wMHc2wOTXK4o0eaqIHGC/coNBwnIyc0fiE673NkVnG19
	Wg0w=
X-Google-Smtp-Source: AGHT+IGrChgDzdrWmRVBuxrTnhvgS0m0L/2b3vWL0JgvRJ16VQEKS9Ut3UimZPuIssfw7Le43zALgA==
X-Received: by 2002:a5d:4dcd:0:b0:374:c142:80e7 with SMTP id ffacd0b85a97d-374c142857cmr3451727f8f.1.1725282687016;
        Mon, 02 Sep 2024 06:11:27 -0700 (PDT)
Received: from probook-s.corp.sigma-star.at ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba83sm11511430f8f.54.2024.09.02.06.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 06:11:26 -0700 (PDT)
From: Simon Graber <simon.graber@sigma-star.at>
To: xenomai@lists.linux.dev
Cc: upstream+xenomai@sigma-star.at,
	Simon Graber <simon.graber@sigma-star.at>
Subject: [PATCH v4 0/4] Add env vars for session and cpu-affinity
Date: Mon,  2 Sep 2024 15:11:20 +0200
Message-ID: <20240902131124.37844-1-simon.graber@sigma-star.at>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Revision 4 of this patchset clarifies the purpose of patch 3.

Changes since v1:
 * Usage of environment variables is documented
 * lib/copperplate/init.c: Conditionally query XENO_SESSION_NAME
 * Reformat patch 2 to adhere to code style
 * Reword commit message of patch 3
 
Simon Graber (4):
  lib/copperplate: Get session name from env var
  lib/boilerplate: Get cpu-affinity from env var
  alchemytests: Set cpu-affinity by env var
  Add documentation for env vars

 doc/asciidoc/README.INSTALL.adoc             |  7 ++--
 lib/boilerplate/setup.c                      | 39 +++++++++++++++-----
 lib/copperplate/init.c                       | 21 ++++++++---
 testsuite/smokey/alchemytests/alchemytests.c | 10 ++++-
 4 files changed, 58 insertions(+), 19 deletions(-)

-- 
2.46.0

