Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B674C71
	for <xenomai@lists.linux.dev>; Fri,  2 Dec 2022 16:05:49 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::229])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id C0246D10E7
	for <xenomai@lists.linux.dev>; Fri,  2 Dec 2022 15:45:14 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id CBFB2FF806;
	Fri,  2 Dec 2022 15:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1669995906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v6Di8t3YwitCRgByjWgOgyxo1lL1Qwa1sOP2hemfVyI=;
	b=V77z0jYvq0YZXCGP9zWDD7qnNPlOYNuvIawr/LMKXrz4oUEVQxf8ksA/bGUBsTZdRGlSI0
	+ltf7aR31Zg48nqIYQ68Qcf1C94XAl7oU1Zak7OhswiR0ve1qLkLx/PqTmra2lgfkizgNI
	rtPTDqMu4omhi0WMdlrX6qsxDUeITzUTF8UHmSZQxTwNOz/sqboro6lzMyMuWFEsFKl7fu
	0UlV5loQrjr60Yj57JHb+IUOMpt3P+Fl2yN3kWi6jm0A476Lo2HlHaooySJ2FHUby8uoiE
	YjEk7eWBCJG9sodwRi9lJZyNvoHyQLgVWXLyuw924aYfH0E03J9HLwXXV5XgqA==
References: <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87zgcs4ma1.fsf@xenomai.org>
 <PH1P110MB10500F942C9666D27F48E154E2049@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87v8ng3vv7.fsf@xenomai.org> <87edu2dh2j.fsf@xenomai.org>
 <PH1P110MB10505104BB0814A3F46A86BCE2079@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87tu2xbk5k.fsf@xenomai.org> <87cz9kbrkr.fsf@xenomai.org>
 <PH1P110MB105079B5A344B300F33874E3E2089@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <877czothz0.fsf@xenomai.org>
 <BN2P110MB1288677543F1950D08808B3B8F0A9@BN2P110MB1288.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10502B0F1F62BFBA1CE3D3EBE2139@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87h6yj6mvg.fsf@xenomai.org>
 <PH1P110MB1050D4E123EE6368D98E071AE2139@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <0082bff2d91b0125ac60050159d3003e64b45bffa35e0c4f0ed9799e38b97b8c@mu>
 <87h6ygwi2l.fsf@xenomai.org> <875yevw5ln.fsf@xenomai.org>
 <PH1P110MB1050DA6B7C1C21B2866038CCE2149@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <871qpiw3zd.fsf@xenomai.org>
 <PH1P110MB105039710BB301C7126FF2D9E2179@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <87wn797rj3.fsf@xenomai.org>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: Bryan Butler <Bryan.Butler@kratosdefense.com>, "xenomai@lists.linux.dev"
 <xenomai@lists.linux.dev>, Shawn McManus <shawn.mcmanus@kratosdefense.com>
Subject: Re: [External] - Re: EVL Memory
Date: Fri, 02 Dec 2022 16:38:26 +0100
In-reply-to: <87wn797rj3.fsf@xenomai.org>
Message-ID: <87sfhx7qta.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Philippe Gerum <rpm@xenomai.org> writes:

> Russell Johnson <russell.johnson@kratosdefense.com> writes:
>
>> [[S/MIME Signed Part:Undecided]]
>> I do already have that enabled and have confirmed the proper commit shows up
>> in uname. I will disable LOCKDEP and re-run.
>>
>> Thanks,
>>
>> Russell
>>
>> [[End of S/MIME Signed Part]]
>
> I realized that the line information from the kernel splats was matching
> the latest sources anyway, so you are definitely running the right
> kernel. Can you observe that the threads are indeed stuck with a boosted
> priority that never changes, using evl ps?


The patch below should capture a trace snapshot when the assertion
trips, with a backtrace of the most recently executed function calls
before this happens. This works with the "evl trace" command [1],

e.g.

# evl trace -e
... wait for kernel splats
...
# evl trace > tracelog.txt

[1] https://evlproject.org/core/commands/#evl-trace-command



diff --git a/kernel/evl/mutex.c b/kernel/evl/mutex.c
index 16750fd193377..c3c1576975c7e 100644
--- a/kernel/evl/mutex.c
+++ b/kernel/evl/mutex.c
@@ -653,6 +653,7 @@ void __evl_unlock_mutex(struct evl_mutex *mutex)
 	 */
 	if (IS_ENABLED(CONFIG_EVL_DEBUG_CORE)) {
 		bool bad;
+		trace_evl_trigger("BOOST1");
 		raw_spin_lock_irqsave(&curr->lock, flags);
 		bad = curr->state & EVL_T_BOOST && list_empty(&curr->boosters);
 		raw_spin_unlock_irqrestore(&curr->lock, flags);
diff --git a/kernel/evl/sched/core.c b/kernel/evl/sched/core.c
index 3bfbe37b1eb7b..d1307fb1b4fd5 100644
--- a/kernel/evl/sched/core.c
+++ b/kernel/evl/sched/core.c
@@ -985,6 +985,7 @@ void __evl_schedule(void) /* oob or/and hard irqs off (CPU migration-safe) */
 	 */
 	if (IS_ENABLED(CONFIG_EVL_DEBUG_CORE) &&
 		curr->state & EVL_T_BOOST && list_empty(&curr->boosters)) {
+		trace_evl_trigger("BOOST2");
 		raw_spin_unlock(&curr->lock);
 		EVL_WARN_ON_ONCE(CORE, 1);
 		raw_spin_lock(&curr->lock);

-- 
Philippe.
