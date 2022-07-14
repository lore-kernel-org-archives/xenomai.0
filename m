Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739AA20E1
	for <xenomai@lists.linux.dev>; Thu, 14 Jul 2022 08:16:28 +0000 (UTC)
Received: from relay1-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::221])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 1852BC9265
	for <xenomai@lists.linux.dev>; Thu, 14 Jul 2022 08:16:15 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id B350724000C;
	Thu, 14 Jul 2022 08:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1657786568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M0EDHkP7+1mc5rjdDHeh9K8mJx0v810SqN4301OgH9U=;
	b=DJVHv+zFHKm6d2Cn9GMKM5IrFuvxHtSNLuPfUaKRsBbdzp40uPh7B/Ifl/KgOsImDgubn/
	oR1Ay/DFa3/uNlSKIOMmmU07Vh+w5WCUPjlzOBVxkFUaAzUsRDZt7jFvr8ogV4iBuK4MDW
	iR7ldnUtv5pzeEl5yodt6wTIA6pNWhX9tqWC4XBXYxMlIqHz0nnVbABRYnrYiNgrUEsQx8
	+e/xh6LoGnAp1UJPwtrO3wGjTelQ+GUeeYEy6q370n6LUXasiA7cgjD1EwrcxbZbXDmFqN
	S6dUJiUrlBlBIVDfsLPdD6Fxilu25k7MzSprsF/xK4mHHHGGiIloLXBEQ21P8Q==
References: <PH1P110MB105057E1EB4A12D83DE85CA2E2899@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 27.2
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Using the heap in an EVL thread
Date: Thu, 14 Jul 2022 09:55:56 +0200
In-reply-to: <PH1P110MB105057E1EB4A12D83DE85CA2E2899@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87k08gds8p.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> I have done a bit of unit testing using an EVL thread along with a
> structure such as an STL vector. I created and resized the vector
> (which uses the std allocator) in the EVL thread itself, and I am not
> seeing any in-band switches. Is it not a requirement to use the EVL
> heap in an EVL thread? Especially when it comes to dynamic allocation
> such as resizing a vector during realtime processing.

It is. If the std allocator eventually relies on malloc(), the latter
may have to issue in-band syscalls to obtain more memory from the kernel
by extending the data segment or mapping more anon page(s) to fulfill
the request. The caller may also have to sleep on a common mutex when
allocating a chunk, upon contention with another thread doing the
same. If malloc is fed by mapping memory pages and not sbrk(), it might
even want to release unused pages at some point depending on some
threshold, which would cause an in-band syscall too.

IOW, there are several reasons why the calling thread may have to switch
in-band while allocating or freeing a chunk of memory, but these
conditions look random from the POV of the application. Therefore
anything which is not based on a real-time allocator would be unsafe to
use in this context, even if execution _seems_ to be ok most of the
time.

-- 
Philippe.
