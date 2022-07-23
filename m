Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AFC7E
	for <xenomai@lists.linux.dev>; Sat, 23 Jul 2022 09:03:48 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 4AE12200003;
	Sat, 23 Jul 2022 09:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1658567020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WVRppT23/GsNNT21NfMaax1xRNVtivn6mrAo4p9zk+o=;
	b=TI11WeciYF/6lY2xQTM3tgMQV57HNLIwTZ9QvzkwlRftYWxE7EhFMqIphtZmFwBef2F6hV
	5QL/F40xM31zlMmemLpF1xyEWXUdeH72brfDcgHlfXnSXmDLxUBandYfyFkvMvbWL5wLhh
	jRWhjHX4Qevgd0xN6FzbP83ChWhBV/3mo7tq8Y49c105V4hPqoLLiV/QzA01INlNxeKmWa
	T8nsKyEd9myq8Sj5kEGSDJ1rSvqAQ1it5MCjW+fk+LhFSUMbVyb/bGveo511kUBn68D09/
	5mjPMCkuFyVlbgEJEq93ZGORY8uXDhdHQVp673ij532mRkNtlWg585m4fKnmHg==
References: <PH1P110MB105042C5A2262DF250224C69E2919@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: Weird debugger behavior with events
Date: Sat, 23 Jul 2022 11:02:24 +0200
In-reply-to: <PH1P110MB105042C5A2262DF250224C69E2919@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87sfmsmc9h.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> I ended up adding an xbuf and another thread to better replicate what I was 
> seeing and exacerbate the issue. I can verify that all 3 threads show up as 
> expected under "evl ps -l". You can just run the debugger with no breakpoints, 
> and you should see the "-1 error occurred" message printed to the console at 
> least once. You can also put a breakpoint on that print after the 
> evl_timedwait_event call, and the breakpoint should get hit just about every 
> time. Lastly, you can run the compiled app outside of gdb, and see that the 
> error message is never printed out.
>
>
> // g++ -Wall -g -o test 
> test.cpp -I/opt/evl/include -L/opt/evl/lib -levl -lpthread
>

Ack. Working on this shortly. Thanks for the test code.

-- 
Philippe.
