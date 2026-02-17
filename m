Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C10729E0F6
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 20:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771360445; cv=pass; b=dHA/WZAkiWiwgMhBz59HYpPDWCL5h29Lldo6d6VD5zmdyCmFe40x9sOxzH4H7wb6ib77S3zSpB5UUrLhVhaeectNQZIbdRi/yjjfZMI1rDmtTEI6Su+ox6zxiXSJ6RcQlBXWJugdo10jhY4oD8k78Dg2/3RXzN9tYzd3q854e4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771360445; c=relaxed/simple;
	bh=3t01HI5/fevX7zkfTjMr8D+QVjEgoqhOfk5aMipBL1g=;
	h=From:Subject:To:Message-ID:Date:MIME-Version:Content-Type; b=lO7BTfeaafaEDYoAy67lcvZiAypIGA4T1b3vGp37TE+FUcYyL/sSxhGZ9FZGWQ3MJ7KzhrMtPDSw5a0VaDEQhENnzuIrb3bFOjQBjNet22iC+vmYP3ok+FcMB0qHHF+DfCr/mT24pKwKEwkK+GWhhF5q54ALdMaAF97UOCi8Sg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=VB83Dxid; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="VB83Dxid"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D851F9235DF
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 20:28:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a222.dreamhost.com (trex-green-7.trex.outbound.svc.cluster.local [100.99.24.1])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 33E5D922F92
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 20:28:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1771360104;
	b=QRBAekSVNwQ2Jh5qEf2BgSICb99elcztkOUIKTcDDemnOCTgQDcVZFozQzAXngyxKmfnvI
	z2vipGWPeAKS4zlNyLb2cVflBspH3x3pq52OsQOEzzwDNv1YU3N+vrhBmH6pvMGzaazJWL
	Z7L7hTR3fDPEe6NDNjr8VErxTiP27fg3gAszFRldRplthD99J1ZKC5Rjqa8LaVX1pgfZzN
	hfuOd1aO8BMdTTTxPXaLZgpsjzJctt3tsZ8VG9lcuY5zISFM7b5Iniy+o0sR6H0sB0QoZz
	bEJL17EjoQ3lfgWNSnbfnMv4f95hR+2p0Ve8XCkVNVQ3cTkn9F57HG2cz2Vs5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1771360104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=0lMCFw+S8C3Z88CiQMrf7Expf+CYtbqPmULEU7AWeyY=;
	b=lDzde+37v+O9Z7/ENoBZiLBRVb3OOp04DmW5nnm4b7hOrMqgalXqNBmgR6BOzbOUgoHpVc
	kHHfIwoNK1345tWRMFg5DHzOdyliq4qvK5ZJCN3bVizkOlTDhK0KzmPDqR5ztWpWADhJ3x
	Be2XNHd9BPqOvi3wNXc2LMufYBr+TqN+/Yuw0WwVZFxLfJRMePBlmyZTsUirLq9zSDzBUi
	++C2H+a/SYLsp7R19cjqyoqcxOLtmfrOzg1xUUI688aYAsaPASlfL7KlH6v8KG8WYcPbG0
	wdaC6avW8Atpj3N01VFlFyBGUOJl/iS+4X65xMvdWk6RGDh9BaOf445OiOrOUQ==
ARC-Authentication-Results: i=1;
	rspamd-659f7bc6cc-q7dr7;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Whispering-Sponge: 2bd314d50ac81a21_1771360105726_456158763
X-MC-Loop-Signature: 1771360105726:3388420531
X-MC-Ingress-Time: 1771360105726
Received: from pdx1-sub0-mail-a222.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.24.1 (trex/7.1.3);
	Tue, 17 Feb 2026 20:28:25 +0000
Received: from giulios-MacBook-Pro.local (unknown [186.112.184.216])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a222.dreamhost.com (Postfix) with ESMTPSA id 4fFrnM4wJZzRr
	for <xenomai@lists.linux.dev>; Tue, 17 Feb 2026 12:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1771360104;
	bh=0lMCFw+S8C3Z88CiQMrf7Expf+CYtbqPmULEU7AWeyY=;
	h=From:Subject:To:Date:Content-Type:Content-Transfer-Encoding;
	b=VB83DxidtLKU24jSgjRDYIdZ1Ux/4yQ1Eegtai+Yns778RFpowymObFZs7ZL1/mWz
	 8HcjB0kMYcjYEUQLAvr/MBUPIhpkyi3TGmWNFg8RgUBjsMuVhjk2Oyq+SW8ikgwEnp
	 nB80ToZPyA3v3bID5px+vezgc31kFhQVwlK3wiLbjc00d9YkyA5MhBvAnjVqLW78z+
	 SMV++WOxOsLOM+o113ITCa+GwVO3JBvIhwlFmpnM5eAmVLZKS7czw05UP8eS4TX5ia
	 LQYEgGwaEhTRt7IrVam7H7LEEIFWMdt5JDXhBqQUTi5qZun5cvp8EOwXDvEpEu9jHN
	 r6CvvW+XDvt/w==
From: Giulio Moro <giulio@bela.io>
Subject: evl. event and mutex
To: Xenomai <xenomai@lists.linux.dev>
Message-ID: <facf1a8f-697a-453d-758c-acaa2c92c804@bela.io>
Date: Tue, 17 Feb 2026 15:28:21 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.8; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.23
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi everyone,
I am trying to use evl_event and evl_mutex so that two threads can signal each other when either needs work from the other, so they each need to call evl_signal_event() and evl_wait_event(). The first thread to call evl_wait_event() seems to correctly drop the mutex, thus unlocking the second thread. When the second thread signals the condition variable (while holding the mutex) and then calls evl_wait_event(), thus implicitly dropping the mutex, the first thread is, unexpectedly, not restarted. I noticed that if a third thread acquires and then releases the lock (without touching the condition variable), then the first thread is restarted. This sounds like a bug?

I am running this on ARM64 (PocketBeagle 2)
evl.0.55 -- #98a8b88 (2025-10-08 22:41:39 +0000) [requires ABI 42]
Linux bela 6.12.49-arm64-ti-evl #4 SMP EVL Sun Nov  2 19:24:32 UTC 2025 aarch64 GNU/Linux

Below is a demo program to reproduce the issue.
If I run the program it prints the following when executed:

main: evl_lock_mutex
main: evl mutex locked
main: evl_signal_event cond
main: evl_wait_event cond, should drop mutex
thread: evl_lock_mutex
thread: evl mutex locked
thread: evl_signal_event cond
thread: evl_wait_event cond, should drop mutex
[HANGS]

If I #define AUXTHREAD (thus enabling the auxiliary thread that periodically locks and unlocks the mutex without touching the condition variable), I get:

main: evl_lock_mutex
main: evl mutex locked
main: evl_signal_event cond
main: evl_wait_event cond, should drop mutex
thread: evl_lock_mutex
thread: evl mutex locked
thread: evl_signal_event cond
thread: evl_wait_event cond, should drop mutex
[wait]
auxthread: evl_lock_mutex()
auxthread: evl locked mutex
auxthread: evl_unlock_mutex()
auxthread: evl mutex unlocked()
main: sleeps
main: evl_lock_mutex
main: evl mutex locked
main: evl_signal_event cond
main: evl_wait_event cond, should drop mutex
[wait]
auxthread: evl_lock_mutex()
auxthread: evl locked mutex
auxthread: evl_unlock_mutex()
auxthread: evl mutex unlocked()
thread: sleeps
thread: evl_lock_mutex
thread: evl mutex locked
thread: evl_signal_event cond
thread: evl_wait_event cond, should drop mutex
[wait]
auxthread: evl_lock_mutex()
auxthread: evl locked mutex
auxthread: evl_unlock_mutex()
main: sleeps
auxthread: evl mutex unlocked()
main: evl_lock_mutex
main: evl mutex locked
main: evl_signal_event cond
main: evl_wait_event cond, should drop mutex

Demo program:

#include <pthread.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <errno.h>

#include <evl/evl.h>

// #define AUXTHREAD

struct evl_event cond;
struct evl_mutex mtx;

void allCores() {
	cpu_set_t set;
	CPU_ZERO(&set);
	for(unsigned int n = 0; n < 64; ++n)
		CPU_SET(n, &set);

	if(sched_setaffinity(gettid(), sizeof(set), &set) == -1) {
		fprintf(stderr, "sched_setaffinity error\n");
		abort();
	}
}

void loop(const char* id) {
	while(1) {
		printf("%s: evl_lock_mutex\n", id);
		int ret = evl_lock_mutex(&mtx);
		if(ret) {
			fprintf(stderr, "%s: evl_signal_event returned %d %s\n", id, ret, strerrorname_np(-ret));
			abort();
		}
		printf("%s: evl mutex locked\n", id);
		printf("%s: evl_signal_event cond\n", id);
		ret = evl_signal_event(&cond);
		if(ret) {
			fprintf(stderr, "thread: evl_signal_event returned %d %s\n", ret, strerrorname_np(-ret));
			abort();
		}
		printf("%s: evl_wait_event cond, should drop mutex\n", id);
		ret = evl_wait_event(&cond, &mtx);
		if(ret) {
			fprintf(stderr, "%s: evl_wait_event returned %d %s\n", id, ret, strerrorname_np(-ret));
			abort();
		}
		evl_unlock_mutex(&mtx);
		printf("%s: sleeps\n", id);
		usleep(10000);
	}
}

void* thread(void* arg) {
	int ret = evl_attach_thread(EVL_CLONE_PRIVATE, "thread:%d:%u", getpid(), pthread_self());
	if(ret <= 0) {
		fprintf(stderr, "evl_attach_thread returned %d %s\n", ret, strerrorname_np(-ret));
		abort();
	}
	allCores();
	loop("thread");
}

void* auxthread(void*) {
	int ret = evl_attach_thread(EVL_CLONE_PRIVATE, "auxthread:%d:%u", getpid(), pthread_self());
	if(ret <= 0) {
		fprintf(stderr, "evl_attach_thread returned %d %s\n", ret, strerrorname_np(-ret));
		abort();
	}
	while(1) {
		usleep(1000000); // long wait
		printf("auxthread: evl_lock_mutex()\n");
		ret = evl_lock_mutex(&mtx);
		if(ret) {
			fprintf(stderr, "auxthread: evl_mutex_lock returned %d %s\n", ret, strerrorname_np(ret));
			abort();
		}
		printf("auxthread: evl locked mutex\n");
		printf("auxthread: evl_unlock_mutex()\n");
		ret = evl_unlock_mutex(&mtx);
		if(ret) {
			fprintf(stderr, "auxthread: evl_mutex_unlock returned %d %s\n", ret, strerrorname_np(ret));
			abort();
		}
		printf("auxthread: evl mutex unlocked()\n");
	}
	return NULL;
}

int main()
{
	int ret = 0;
	ret = evl_init();
	if(ret) {
		fprintf(stderr, "evl_init() returned %d\n", ret);
		abort();
	}
	ret = evl_attach_self("%s:%d:%u", "main", gettid(), rand());
	if(ret < 0) {
		fprintf(stderr, "evl_attach_self() returned %d\n", ret);
		abort();
	}
	allCores();
	ret = evl_create_mutex(&mtx, EVL_CLOCK_MONOTONIC, 0, EVL_MUTEX_NORMAL, "mutex:%d:%p", getpid(), &mtx) < 0;
	ret |= evl_create_event(&cond, EVL_CLOCK_MONOTONIC, EVL_CLONE_PRIVATE, "cond:%d:%p", getpid(), &cond) < 0;
	pthread_t t;
	ret |= pthread_create(&t, 0, thread, 0);
#ifdef AUXTHREAD
	pthread_t at;
	ret |= pthread_create(&at, 0, auxthread, 0);
#endif // AUXTHREAD
	if(ret) {
		fprintf(stderr, "Initialisation error\n");
		return ret;
	}
	loop("main");
	return 0;
}
