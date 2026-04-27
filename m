Received: from mx2.mythic-beasts.com (mx2.mythic-beasts.com [46.235.227.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B17394499
	for <xenomai@lists.linux.dev>; Mon, 27 Apr 2026 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777275964; cv=none; b=ctvDBKilnRz9Bij7kS/c4cLbtjXSpOBT8HbxQkCTf8z7Fuped2gFYemrLVXGJsdxEEOVdYzBDD3dkw57Z79tVHm1tejieWkdvd0UIN7YLxMIV5ta9tLYzVBOD9b2RPZ7LOrXJJcgwGzNA4T/T5vCClxdk7q0qWOn0VXIqHOjQBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777275964; c=relaxed/simple;
	bh=lO4k3RqfC5BnPSmHs5P+aiXkWxRxmpqAIMgm9TJaaJk=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orTBvJDhs4sHeEY9LNI4GpDfGmPxCeAu/HlsoU0nAkAAUGJclsC0q1m4KlXx6pNLgp7Isyq5PmlJlAr87DCxb1X2VFqsWTFWqFejzBXpMJTwRtj1Dht8Wjgm6L87nqT7hJL8Vj7/rojMjArc42bMtxf85lQPmO86lrpgAtV73xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxcnc.org; spf=pass smtp.mailfrom=tuxcnc.org; dkim=pass (2048-bit key) header.d=tuxcnc.org header.i=@tuxcnc.org header.b=b3YJuOhS; arc=none smtp.client-ip=46.235.227.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxcnc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxcnc.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxcnc.org header.i=@tuxcnc.org header.b="b3YJuOhS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tuxcnc.org;
	s=mythic-beasts-k1; h=Subject:To:From:Date;
	bh=r83kTNLUzABmIFN1B1taOtoLbjy06FBE+CVQTMtXSOc=; b=b3YJuOhSeIQk9ng9Yr1kgKpUgn
	m9PM7glNXzMxk5CnIjYiq1Vuy1fQ52F1XcihugzEYukgLTSOC86BS2m5y7PwsgpOqKv1bYXQwukV5
	2ATTI4LA/WRriSPf+c59NVH8RbO7Bm4SfJDxFeaUcCKV2loUpoQxSABIhXIQbcgHrKLL7dwZfeIXX
	RfMebKmMeDCZ/PcCecFPzMtjR3OCLUK7F1lolLaFJQXMogMDMb/POmGj9Sm9FZnKomNg4UnVgDqrZ
	YGW3UXFX1qbhOGmiFB9vTDYK3L4lcZAKEEx+3RJIdaSsU7DhC3XnNuqeTgI4Xbj+kSvePRoZDa3wX
	9MtuNRRA==;
Received: by mailhub-hex-d.mythic-beasts.com with esmtpa (Exim 4.96)
	(envelope-from <paul_c@tuxcnc.org>)
	id 1wHGSl-002hsv-2i
	for xenomai@lists.linux.dev;
	Mon, 27 Apr 2026 08:33:04 +0100
Date: Mon, 27 Apr 2026 08:33:01 +0100
From: Paul <paul_c@tuxcnc.org>
To: xenomai@lists.linux.dev
Subject: Re: [EVL] Kernel WARNING: notifier callback netevent_handler
 already registered
Message-ID: <20260427083301.1e8e5191@Babylon>
In-Reply-To: <8e08bda6-1fed-4a5a-9bb3-74f019b05855@gmail.com>
References: <8e08bda6-1fed-4a5a-9bb3-74f019b05855@gmail.com>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 5

On Sat, 25 Apr 2026 18:24:14 +0200
Hannes Diethelm <hannes.diethelm@gmail.com> wrote:

> Some background: I am working on integrating Xenomai3/4 into
> LinuxCNC. Due to this, I have a full desktop running with a Xenomai
> kernel. Probably one of the installed applications triggers this
> issue.
> 
> It is just a hobby and I am not an official maintainer of LinuxCNC
> but if it works well, it might get merged.

Please, no.
Linuxcnc is so badly written, it is extremely difficult to debug. I use
it as en example of how not to write efficient code.
