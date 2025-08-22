Received: from cczrelay02.in2p3.fr (cczrelay02.in2p3.fr [134.158.66.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC502FB609
	for <xenomai@lists.linux.dev>; Fri, 22 Aug 2025 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.158.66.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867169; cv=none; b=Rg0Bo0CtzhnaYZnuzKtCzUaXPO1qJP0L/VWjqXz75OcHk3Rw17c01YWtpxhoOhlYpCHpyG1PqzSlzAlek5wXFdiJOloai4m7+IovLmX9Wr7StXta4pNKaFA1F+ObZ+3XVniT5wFWiSaihSIqS2EH9XYPuSqUnexyeefW7SPenbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867169; c=relaxed/simple;
	bh=5j0fi3uKN1xTj7Jn4mo61U84CNtd3kUYIgp0dHAFHRQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dcZ/GtLAfFmxN0sJjzGQBSfbYcAVKi74EwXnJ6dEjzn9QyFW1i5OWxAwFzrSPfdotnbFyhxXJsPLWKka8XQgnlQxL2ZgmtXHqw5agh4qRm0Fmj6RISA7ZPktMuVm1vYOcBqfqtjAa3ORw8J2A41nlCATadwDfuZhF2jbdyOrgOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lapp.in2p3.fr; spf=pass smtp.mailfrom=lapp.in2p3.fr; arc=none smtp.client-ip=134.158.66.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lapp.in2p3.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lapp.in2p3.fr
Received: from [134.158.99.46] (lappc-p898.in2p3.fr [134.158.99.46])
	(authenticated bits=0)
	by cczrelay02.in2p3.fr (8.14.4/8.14.4) with ESMTP id 57MCKEnx008993
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Fri, 22 Aug 2025 14:20:14 +0200
Message-ID: <081761922aa2b6b7b292a6a083cd26334942df7b.camel@lapp.in2p3.fr>
Subject: Re: Simple Xenomai 4 API use examples and a question
From: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai <xenomai@lists.linux.dev>
Date: Fri, 22 Aug 2025 14:20:13 +0200
In-Reply-To: <87349jhk9h.fsf@xenomai.org>
References: <9330e95ad45a1742cedfdf2335141c3f79b7223d.camel@lapp.in2p3.fr>
	 <87349jhk9h.fsf@xenomai.org>
Content-Type: text/markdown; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Le vendredi 22 ao=C3=BBt 2025 =C3=A0 09:45 +0200, Philippe Gerum a =C3=A9cr=
it=C2=A0:
> EBADF is likely returned because your driver does not register the file =
=20
> as an oob-capable one, therefore it won't accept oob_ioctl() requests.

That was the issue. It works fine now.

> The way this works is explained in this document:
> https://v4.xenomai.org/core/kernel-api/file/

I'm pretty sure my eyes went over this page, but the information did not pr=
opagate to the brain.

Thanks,

Emmanuel.
