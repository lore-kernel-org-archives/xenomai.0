Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40CC3EE1F1
	for <xenomai@lists.linux.dev>; Wed,  8 Jul 2026 07:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783495179; cv=none; b=i1yHJ8z7ihr+3qbnBwyUKo3R8Jf69HNRak6oEuMcOVT8GB1wb0pBMs4Uof3gJFLS069xbxI5viYmJ1omR589qjuX4I9JoeKGjMWhzkE4+G9KbbbJOBak1qRU2mK+N49i+jYbzNqV4PjJuvklN6j8wtSbReERQMIfUCcgmhKjlSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783495179; c=relaxed/simple;
	bh=eOGtf7NnFe+WM3HTkHgZ9jX2qrjg7eaEogWLo04xYtQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H/K9JtNbpugyNnNw3Z3C9LTcR99+BVsVcoZG9RfM56K8TT1cZQeUSE7XMdJjj3XhllKxAMqpyjrjGxP4pvFOFwEJgZwAyEhln3EmH01jM3QB10E7iC2FyiCot3Dv1WAWuOvq4CGFPbjXvjqQe49IcwHLEzif9sHX3ooOvukS16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=E2QkNthr; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="E2QkNthr"
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202607080719155c5c9b1aaa00020781
        for <xenomai@lists.linux.dev>;
        Wed, 08 Jul 2026 09:19:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=eOGtf7NnFe+WM3HTkHgZ9jX2qrjg7eaEogWLo04xYtQ=;
 b=E2QkNthrm5ClseVmWjzJatnyt16iaVBiOgpBvClS/sfT6CFQBOIVtaZvmNkcorzA8Y5Ia9
 R6FciNOwSWCN5wUNUYryeF4xxpeB95dT1W0UYCrFlOl7axx2F/eRfBsvMdBqH8C10iQtI+cV
 pTdU2eewjuxkiiitkWp7L8DrdJSsntzCewYnofwUxBlOzN/rnKbe5Xb4dW4px0xoyH6U2516
 WH4k56+lfoIfAtUV+5dqeAWw5aix/8NIRp51eHDYzNye4zoci5h6fmEPauClQ+GN5wpLzZ9s
 iF7QsrRsZw3fimjlgz9rihnnF93gCs+4KAXvo6tPx4c5HUPYk7NLG+Hg==;
Message-ID: <c318d9f72d698bd20cb3b75817ec011330b06144.camel@siemens.com>
Subject: Re: [PATCH dovetail v11 02/11] riscv: irq_pipeline: add IRQ
 pipelining core
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Philippe Gerum
	 <rpm@xenomai.org>
Cc: jan.kiszka@siemens.com, shannmu <shanmu1901@gmail.com>, 
	xenomai@lists.linux.dev
Date: Wed, 08 Jul 2026 09:19:14 +0200
In-Reply-To: <20260708062748.1029852-3-tobias.schaffner@siemens.com>
References: <20260708062748.1029852-1-tobias.schaffner@siemens.com>
	 <20260708062748.1029852-3-tobias.schaffner@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

On Wed, 2026-07-08 at 08:27 +0200, Tobias Schaffner wrote:
> This patchset integrates IRQ pipelining into the RISC-V architecture,
> bringing it in line with the Dovetail/IRQ pipeline model used on other
> architectures. It adds the core pipelining infrastructure and adapts
> low-level primitives to cleanly separate in-band and out-of-band
> interrupt handling.
>=20
> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
> Co-authored-by: shannmu <shanmu1901@gmail.com>
> Co-authored-by: Philippe Gerum <rpm@xenomai.org>
> ---

Philippe, your Signed-off-by should be added as well, so that all co-
authors approved it.

A short confirmation is enough, I will fix it up on merge.
