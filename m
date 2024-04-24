Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE8D29E
	for <xenomai@lists.linux.dev>; Wed, 24 Apr 2024 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949200; cv=none; b=UOwmn21g2rkVI9OD4we1e6EVkb8gPgplbpi5ixF8HsnZsvIFRAb050/zPjAGIA62NTa72j2EJV8W8ZN7gvpLA8WT7R5HgOp0ZbLd24vYoAEXUGv0A0ZVyVpyHtvN3VEnK2UKRhNWLvcOx/vMmYHG1VGaT0tKES1Gf0sLyOd26aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949200; c=relaxed/simple;
	bh=mWR2yFVWFBzF1yEaBpJcP+S5ZTCk5XFGY3V0NVm3WQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=prKt9ziX9c6YiZp+EXw4f291VTH8mdqsgibsBlDPYKinrDGrMWD35fBASbAjJ6LONlbjiMIwnVoUIEe3XehsIqDykVns3sfeDG0+ZHeDH8X0PTi9uCDDdu2k7nfYWUEaAjY9wpIaddEQGoxNC8UmzwZmr2ENTfzcD0MCWuZTrW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=Fabian.Scheler@siemens.com header.b=mSxg4G15; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=Fabian.Scheler@siemens.com header.b="mSxg4G15"
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240424085953a91d3101051b475572
        for <xenomai@lists.linux.dev>;
        Wed, 24 Apr 2024 10:59:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Fabian.Scheler@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To:Cc:References:In-Reply-To;
 bh=mWR2yFVWFBzF1yEaBpJcP+S5ZTCk5XFGY3V0NVm3WQQ=;
 b=mSxg4G15XVlBOcUnJ4FKFZ83ZRXnKuvoYglVEi3gTOeG9RjaUMJ8fnAvn616eSXyjGiGFf
 FxeAFhyW9LA1cam+XnqGp8NsjtNw7Qm2y0hB++CnIVhV88+rbeN1S6gMqvbFvf7AdsHD/S5+
 GbgBrUZme8UTr6TFimp7Y86eVYy4g=;
From: Fabian Scheler <Fabian.Scheler@siemens.com>
To: xenomai@lists.linux.dev
Cc: roman.hodek@siemens.com
Subject: 
Date: Wed, 24 Apr 2024 10:58:34 +0200
Message-ID: <20240424085922.41944-1-Fabian.Scheler@siemens.com>
In-Reply-To: <87o7a0yx5f.fsf@xenomai.org>
References: <87o7a0yx5f.fsf@xenomai.org>
Reply-To: xenomai@lists.linux.dev, xenomai@lists.linux.dev
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1325281:519-21489:flowmailer


As suggested by Florian I revised the patch so that the correct author is stated in the commit.

Ciao
Fabian
