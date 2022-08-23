Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2EA7B
	for <xenomai@lists.linux.dev>; Tue, 23 Aug 2022 10:10:00 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id CBF522000A;
	Tue, 23 Aug 2022 10:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1661249393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j9ldX3OYmdVDfEdw1rLeqKilV4OIQ4hi4au+CtRXVYI=;
	b=Q4CKWNHT/jHyx8/SOkAv32MwndjiQisxVtzFpKJeNJE+yXz0BPVPOsCEJq1tK3LpJXT1u5
	lH7bfrcxrJDXy/01hNiugYaSYwQd4KGWDRne8DP6PfqEQyTv1iSu/4YULM8mSrPca2vimF
	x8fd5GM8Uj9JNuUdeKOgau73qjM9G6Fe1zhbyirKjUAOOsgyX5RSzbNNc9WbBDU3LPjjOW
	pVYoec3vadDkYCMeNJ+t1VkDYINdlmek9OXG8bGsfKSWUvsXXZKAJ5PFEYEzAKNnmmbkV8
	X2KTWdb7QUllpFQ7kXSSJ1QaT1bW2gycbbQy4d9qv0AZXLSu4QqewGVElqbF4w==
References: <44bc4a56-062c-6041-2d5e-dfe00aed3a51@bela.io>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Giulio Moro <giulio@bela.io>
Cc: xenomai@lists.linux.dev
Subject: Re: EVL: EVL_HMDIAG_SYSDEMOTE is not marked
Date: Tue, 23 Aug 2022 12:07:57 +0200
In-reply-to: <44bc4a56-062c-6041-2d5e-dfe00aed3a51@bela.io>
Message-ID: <877d2zw9sg.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Giulio Moro <giulio@bela.io> writes:

> My understanding is that when setting the thread mode to T_WOSS | T_HMSIG, then when the thread switches to inband via syscall, a SIGDEBUG signal si will be delivered to the thread such that sigdebug_marked(si) is true and sigdebug_cause(si) is EVL_HMDIAG_SYSDEMOTE.
>
> The test below tests for that but it fails: a SIGDEBUG is indeed delivereed and sigdebug_cause(si) is indeed EVL_HMDIAG_SYSDEMOTE, but sigdebug_marked(si) returns false, in fact sigdebug_code(si) is simply set to 2.
>

Confirmed. Please let me know if this patch does help as expected:

--

commit 52f547a9a83f6e5430a72dd213968703ce0213d6 (HEAD -> rebase/v5.19-evl)
Author: Philippe Gerum <rpm@xenomai.org>
Date:   Tue Aug 23 12:04:26 2022 +0200

    evl/thread: duly mark SIGDEBUG cause on direct signal
    
    The sigval information was not bearing the SIGDEBUG marker in case we
    signaled from in-band context directly. Set the marker in the common
    code path shared between oob and in-band contexts to fix this.
    
    Signed-off-by: Philippe Gerum <rpm@xenomai.org>

diff --git a/kernel/evl/thread.c b/kernel/evl/thread.c
index 606f24b902e5b..65c6dabc1b488 100644
--- a/kernel/evl/thread.c
+++ b/kernel/evl/thread.c
@@ -1304,7 +1304,7 @@ static void do_inband_signal(struct evl_thread *thread, int signo, int sigval)
 		memset(&si, '\0', sizeof(si));
 		si.si_signo = signo;
 		si.si_code = SI_QUEUE;
-		si.si_int = sigval;
+		si.si_int = sigval | sigdebug_marker;
 		send_sig_info(signo, &si, p);
 	} else
 		send_sig(signo, p, 1);
@@ -1336,7 +1336,7 @@ void evl_signal_thread(struct evl_thread *thread, int sig, int arg)
 	init_irq_work(&sigd->work, sig_irqwork);
 	sigd->thread = thread;
 	sigd->signo = sig;
-	sigd->sigval = sig == SIGDEBUG ? arg | sigdebug_marker : arg;
+	sigd->sigval = arg;
 
 	evl_get_element(&thread->element);
 	/* Cannot fail, irq_work is local to this call. */

-- 
Philippe.
