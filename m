Received: from dormouse.elm.relay.mailchannels.net (dormouse.elm.relay.mailchannels.net [23.83.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A987B
	for <xenomai@lists.linux.dev>; Tue, 23 Aug 2022 09:35:36 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1D62F2243F
	for <xenomai@lists.linux.dev>; Tue, 23 Aug 2022 09:29:07 +0000 (UTC)
Received: from pdx1-sub0-mail-a304.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9DDCC22A08
	for <xenomai@lists.linux.dev>; Tue, 23 Aug 2022 09:29:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661246946; a=rsa-sha256;
	cv=none;
	b=KEKWO2JzBgT1Cvg6is19q8ziWo5Y7bEnQTSl8/ZeZFdnqB3rTJDuu/5MGLEttfl7Llb3qt
	syAg6PRkkYV12Lhyfw8iGvgU/D3x8/129COnERuvagZVYMFl70SajJcx7yVZe5vZ5J0MAf
	MP65G0BNsJfpg5GjfcgypXElG3BgPCVVDtzp8XEo5wBSxCveJDI/AKMRAwwlOYdNK7MDRg
	R3eOYLwtyFoVM8jwT+QGmhQz6TqcbU80XiSlIsIh6pVK2x/sqj5NLiiqhlzuAl/T4MS+YK
	kPfBVctNCC+l+YTo2zDWFixCHH3qkVfNQvVOLZf0PDmkOtn21aZvDnuEzJH7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1661246946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=DHqyhJd1v2Vop0KWN9CXKIC1+I3TWXR+8wAzq2IDjh8=;
	b=V/ivBU9Z/rPgPnZHS2wnvHSHrZeev3Ba7OFMBQdWVL5yGeUUSIGX0P5ZQ9mKjvgzqDaII2
	AH9uW3chDxH2JCA8PkvhmjvqHSW2CybxLftoA5pf8v/d1LuKYAzpxYuQr+Dih5fsj7hz0b
	atrwZxXdy5+FaO3u8lseIoCWfH6oRxBJvYs4qQ5zHg1X03zpBj9z1FTGth90P4yDecCl/A
	L/UmH58+meXzbj37jJEgTcGKLguJOT/gRqEYXHMMMbckdqY6EBepl4Yt2OghokK7kO84qP
	pd7wC7gdUA5ldJKDtcaYRfLcKcVNEtjlGB0g5hmePyFc2Pr/cchB1/+cSf/4ww==
ARC-Authentication-Results: i=1;
	rspamd-79945fd77c-5lkgm;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Obese-Dime: 28ba3c55606f3646_1661246946867_2618990542
X-MC-Loop-Signature: 1661246946867:3170989954
X-MC-Ingress-Time: 1661246946866
Received: from pdx1-sub0-mail-a304.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.120.38.149 (trex/6.7.1);
	Tue, 23 Aug 2022 09:29:06 +0000
Received: from [192.168.1.77] (unknown [5.77.127.243])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a304.dreamhost.com (Postfix) with ESMTPSA id 4MBkSd32pszPV
	for <xenomai@lists.linux.dev>; Tue, 23 Aug 2022 02:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1661246946;
	bh=DHqyhJd1v2Vop0KWN9CXKIC1+I3TWXR+8wAzq2IDjh8=;
	h=To:From:Subject:Date:Content-Type:Content-Transfer-Encoding;
	b=tVMsO27LNOMsQGhL5x4nxGrEhOTux7Smc1BAuzB/Rfa2zgjnBHRnxAxG7JM8F5YrA
	 db4hLKuMLCc/rzE/gmiv33nVmr2AFU2Q0uV7Qg1xN29EJTHJKh0jKNFYnQE3dtTwK4
	 JEzEvrW1Xwiykzv7qD8yInRc8liTWXZsIo/T9CwZSCLnWSIYscE0O3ch8waupS12i0
	 czkHkBY4bLtb5kVoSxZiuEAw7OdEsTlfqh1a02bSPJK8NhU621KZT8qKUOWPBchC/E
	 WhX8j0G0oBtqYOv4FS6NBH4oEUZFeL44Rxu36SKbMH7ZI2ClRrzRFllsZCdzda8sM+
	 mDhimOSDN20MA==
To: xenomai@lists.linux.dev
From: Giulio Moro <giulio@bela.io>
Subject: EVL: EVL_HMDIAG_SYSDEMOTE is not marked
Message-ID: <44bc4a56-062c-6041-2d5e-dfe00aed3a51@bela.io>
Date: Tue, 23 Aug 2022 11:29:01 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Firefox/60.0 SeaMonkey/2.53.4
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

My understanding is that when setting the thread mode to T_WOSS | T_HMSIG, then when the thread switches to inband via syscall, a SIGDEBUG signal si will be delivered to the thread such that sigdebug_marked(si) is true and sigdebug_cause(si) is EVL_HMDIAG_SYSDEMOTE.

The test below tests for that but it fails: a SIGDEBUG is indeed delivereed and sigdebug_cause(si) is indeed EVL_HMDIAG_SYSDEMOTE, but sigdebug_marked(si) returns false, in fact sigdebug_code(si) is simply set to 2.

I build this from within libevl/tests with
   gcc -D_GNU_SOURCE switch-warn.c helpers.c -I/usr/evl/include -L/usr/evl/lib/aarch64-linux-gnu/ -levl  -pthread -o test-switch-warn
and when I run it I get:
   NOT MARKED switched inband (syscall)
switch-warn.c:87: FAILED: notified (=false)

This is tested with this branch https://source.denx.de/Xenomai/xenomai4/linux-evl/-/tree/vendor/ti/v5.10.120 and commit 7ccc58d62905724f1b8de4823e0fe8e0129b0fb7 of libevl (r37 + 1 ). Other tests testing for sigdebug_marked(), e.g.: stax-warn do work as expected.


Full code below:

/*
  * SPDX-License-Identifier: MIT
  *
  * Make sure we receive EVL_HMDIAG_STAGEX when locked out from the
  * out-of-band stage because of a stax-based serialization.
  */

#include <unistd.h>
#include <signal.h>
#include <pthread.h>
#include <evl/evl.h>
#include <evl/compiler.h> // fallthrough
#include "helpers.h"

static volatile sig_atomic_t notified;

#define raw_write_out(__msg)					\
	do {							\
		int __ret;					\
		__ret = write(1, __msg , strlen(__msg));	\
		(void)__ret;					\
	} while (0)

static const char *sigdebug_msg[] = {
	[EVL_HMDIAG_SIGDEMOTE] = "switched inband (signal)\n",
	[EVL_HMDIAG_SYSDEMOTE] = "switched inband (syscall)\n",
	[EVL_HMDIAG_EXDEMOTE] = "switched inband (fault)\n",
	[EVL_HMDIAG_LKDEPEND] = "switched inband while holding mutex\n",
	[EVL_HMDIAG_WATCHDOG] = "watchdog triggered\n",
	[EVL_HMDIAG_LKIMBALANCE] = "mutex lock/unlock imbalance\n",
	[EVL_HMDIAG_LKSLEEP] = "attempt to sleep while holding a mutex\n",
	[EVL_HMDIAG_STAGEX] = "locked out from out-of-band stage (stax)\n",
};

// a variation on evl_sigdebug_handler
static void sigdebug_handler(int sig, siginfo_t *si, void *ctxt)
{
	raw_write_out(sigdebug_marked(si) ? "MARKED " : "NOT MARKED ");
	// print cause regardless of marked status
	switch (sigdebug_cause(si)) {
	case EVL_HMDIAG_SYSDEMOTE:
		if(sigdebug_marked(si))
			notified = 1;
		__fallthrough;
	case EVL_HMDIAG_SIGDEMOTE:
	case EVL_HMDIAG_EXDEMOTE:
	case EVL_HMDIAG_LKDEPEND:
	case EVL_HMDIAG_WATCHDOG:
	case EVL_HMDIAG_LKIMBALANCE:
	case EVL_HMDIAG_LKSLEEP:
	case EVL_HMDIAG_STAGEX:
		raw_write_out(sigdebug_msg[sigdebug_cause(si)]);
		break;
	default:
		raw_write_out("SOME OTHER SIGNAL\n");
	}
}

static void *test_thread(void *arg)
{
	int tfd, ret;

	__Tcall_assert(tfd, evl_attach_self("switch-warn-test:%d", getpid()));
	__Tcall_assert(ret, evl_set_thread_mode(tfd,
			0
			| T_WOSS
			| T_HMSIG
			, NULL));
	evl_switch_inband();
	return NULL;
}

int main(int argc, char *argv[])
{
	struct sigaction sa;
	pthread_t tid;
	int ret;

	sigemptyset(&sa.sa_mask);
	sa.sa_sigaction = sigdebug_handler;
	sa.sa_flags = SA_SIGINFO;
	sigaction(SIGDEBUG, &sa, NULL);

	new_thread(&tid, SCHED_FIFO, 1, test_thread, NULL);

	pthread_join(tid, NULL);

	__Texpr_assert(notified);

	return 0;
}
