Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFB74F21D
	for <xenomai@lists.linux.dev>; Wed, 15 Jan 2025 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736955704; cv=none; b=o1Rvbmi222jEzzBaCCo35PYkFwVgBRQekGttB4uqsSiPNYBDHmrE2v+p3pp71B4cASq+ZSf/byFsdCHuVnzgc92hXj+x6PH0xOaM5pTmopmR42fUm9A4B9NNePOFOO8DTOvqDmipwJmprWjpTwGLh9DCad2XZyGlz2T/Ha9rFSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736955704; c=relaxed/simple;
	bh=s6lZFsO9kDm7VXp5C45cx5C3XFCglWvnuLXe/aDTIZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SGkybTSpWx2XP9Wr/P6CLx1Ln9OeqZCKhUBzAbtRAEKrSQaG4BibEu1Di7f6iZ2Pa/v7ld/dbnaEAIHgfTzOdXFnhVYhO/n0fwpFORJ5IooxVVyauLsUTWWBb4THf2fcuyZJ1lxen+GhGIPxiHAudhn9GrBGMTwqpj7wZ7EjCsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=XjJQPlNC; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="XjJQPlNC"
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB94240002;
	Wed, 15 Jan 2025 15:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1736955694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=YTKhuifuEPFzEpDA0wLZkt/pgQQZnJbk52gK1tF30Yc=;
	b=XjJQPlNCSq5Pv8HcWOjCppRqJs8jvV4BFNHVno80GiX/GB2mtam2/QWCFOQH4A401qarKD
	dd6VyigaWFqvJ/Vd/oDtf7kyRQO8cjsHX5MQaByAXEy4J0I6yiIydAIwDeXMJYWodjOaDo
	chFXGsm9ETS7QhMqyqQHGy2d/ZUkiEHRxKjZiGWGmfZ9jOhJplE7NfZ8h+ffpPseBMRUk5
	FNcupUBlm5NkYRCIzShcYeSXxQONDONWg/mDrL5dUvGjPPvhb7RFr5xTCfPO7Fra0BkjFx
	Ra5YOVL0n1t5zyzXm4hGk3EfU3CL8IUXnGD5JHsRao3/yG35UJOSySLCJ4ug4g==
From: Philippe Gerum <rpm@xenomai.org>
To: xenomai@lists.linux.dev
Cc: jan.kiszka@siemens.com, florian.bezdeka@siemens.com,
 tobias.schaffner@siemens.com, shanmu1901@gmail.com
Subject: Dovetail situation report
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Wed, 15 Jan 2025 16:41:33 +0100
Message-ID: <87wmew84pe.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org


Here is some information about the current state of affairs with respect
to the Dovetail development.

1. SLTS, LTS kernels

   - We moved the SLTS kernel we maintain from v6.1.y to v6.1.y-cip
     [1], which means that we are now tracking the kernel maintained
     for the Civil Infrastructure Platform, with a projected EOL in
     2033. The old v6.1.y[-rebase] branch is still present in the
     linux-dovetail repository, but won't be maintained
     anymore. Please track v6.1.y-cip[-rebase] instead.

   - v6.12 moved to LTS status, i.e. v6.12.y[-rebase][2]. Please update
     your git remotes accordingly.

   - IMPORTANTLY, we now have three (S)LTS releases to maintain,
     namely v6.1.y-cip, v6.6.y and v6.12.y. As things stand with
     respect to our resources, this is one too many. For this reason,
     we may consider dropping maintenance of the v6.6.y tree. If you
     have any concern about this possible outcome, you may want to
     bring us a plan for keeping this maintenance alive.

2. RISC-V port

   There is an ongoing port of Dovetail to the RISC-V architecture
   which I'm willing to merge when EVL runs flawlessly on top of it.
   Tobias <tobias.schaffner@siemens.com> and Shannmu
   <shanmu1901@gmail.com> have been contributing the code so far, I've
   been reviewing that code and consolidating the resulting tree
   [3]. No ETA.
  
3. Maintainership

   Florian <florian.bezdeka@siemens.com> is stepping up as a Dovetail
   maintainer, along with Jan and myself. [Thanks mate, the past 22
   years doing just that have been heaven on earth as far as I'm
   concerned, I hope you'll enjoy too!].

NOTE: everything mentioned about linux-dovetail above applies to
linux-evl in the very terms.

Thanks,

[1] https://source.denx.de/Xenomai/linux-dovetail/-/tree/v6.1.y-cip-dovetail?ref_type=heads
[2] https://source.denx.de/Xenomai/linux-dovetail/-/tree/v6.12.y-dovetail?ref_type=heads
[3] https://source.denx.de/Xenomai/linux-dovetail/-/tree/wip/dovetail-riscv?ref_type=heads

-- 
Philippe.
