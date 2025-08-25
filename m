Received: from cczrelay02.in2p3.fr (cczrelay02.in2p3.fr [134.158.66.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ECE2BD01E
	for <xenomai@lists.linux.dev>; Mon, 25 Aug 2025 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.158.66.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756111980; cv=none; b=kazcd10hGT8Yr5x5F2ih8NETo/JwvuqEv5ZV4IDSiQRtuvNUNL0BbgiESrpoN9uIQJnVHUSyhMK7iXIAJjuAqnB1b8PjU0PzSye6g03goF99aaSZ0StN9XmMFK3a03A60d1zQWZW8ylBYW70JL0Y2NMmo0wZ7MgkMAJF1hIIYPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756111980; c=relaxed/simple;
	bh=IipS4o2j7jbtmT9OwdA4p+JLXGpK9mFJKqwl0/gpETk=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=FbYjUaiyPZX5Cr+aVYQJ5dRUDvJjlnZRUcTrsRee2sai9p7nbGVleFxF0OcE300pZdvkHnIoIwFrtoNzWOAKjYWehvX9f56PSzIHZHMBeGyP7Fera0zF1xLGQ15MAYFeelD70bi2yzZjERK4bfrTrjeQFzXP7pJDfBtQPnUW8JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lapp.in2p3.fr; spf=pass smtp.mailfrom=lapp.in2p3.fr; arc=none smtp.client-ip=134.158.66.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lapp.in2p3.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lapp.in2p3.fr
Received: from [134.158.99.46] (lappc-p898.in2p3.fr [134.158.99.46])
	(authenticated bits=0)
	by cczrelay02.in2p3.fr (8.14.4/8.14.4) with ESMTP id 57P8qldd004537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <xenomai@lists.linux.dev>; Mon, 25 Aug 2025 10:52:48 +0200
Message-ID: <6103a8831efc075fea7ddc7d7cea574f411a7795.camel@lapp.in2p3.fr>
Subject: Documentation port to relearn
From: Emmanuel Pacaud <emmanuel.pacaud@lapp.in2p3.fr>
To: xenomai <xenomai@lists.linux.dev>
Date: Mon, 25 Aug 2025 10:52:47 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi,

Browsing the Xenomai4 documentation I was annoyed by the sidebar loosing it=
s
scrolling position at each page change. It looks like it is an issue with t=
he
hugo learn theme. In a commit I saw learn is reaching its end of life, and =
there
is a plan to use relearn instead. I'm willing to do the port if it is still=
 the
plan.

I have started the work here:
<https://gitlab.com/emmanuelpacaud/xenomai4-website/-/merge_requests/1>

I think at least the first commit is already useful, as it fixes a bunch of
broken links.

Please let me know if the port to relearn is still wanted.

Emmanuel.
