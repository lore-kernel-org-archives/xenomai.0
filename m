Received: from dormouse.elm.relay.mailchannels.net (dormouse.elm.relay.mailchannels.net [23.83.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B2B1C2E
	for <xenomai@lists.linux.dev>; Thu, 25 Aug 2022 20:47:33 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1F43B5C1AF0
	for <xenomai@lists.linux.dev>; Thu, 25 Aug 2022 20:47:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a304 (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id AB27A5C1AD5
	for <xenomai@lists.linux.dev>; Thu, 25 Aug 2022 20:47:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661460445; a=rsa-sha256;
	cv=none;
	b=qViR6w8HVPXBUDmEeuITj77oL34RvR2FvBo3GTrFAI3grB1EuMj6VQLleAnJR1LHoDPGcb
	onbM9qjofrzf+Myi6pORIYO5HdVBfvgHFyabS4kAVDz/d5AISW0nWwJBLNhLUqaMe76lpp
	FOkXkCehHy0v+Ja8NwTbcgxpce4Y4YuSrthYalK1+HT6aIkuz9hZv8+Tugr6t+repkeA5k
	3T7Bo7PwTiVb726Djo3AjBdGzSdLI37OgEr6++BiuhXRc5EgzVsyRqlZu+ZqZFtNEDG6if
	c0cQ+ocGX7PCVUNkM4jEuimkWjDntePM9iOztXhxM0DV5Yhl/aI6CcnFDY1rqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1661460445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=0OC7F2+ND3UFPlbdiIxf1kLiM0qL8cLUggOItm6gLVA=;
	b=HOfYYDKcGoVCkPDxKsaJkTy936D5tFWMrlDWU4qQ7d58Xv6Ull7/jN2ZRJygkKO2/U1dsf
	Mq0r4gb5EVZdFlQC80mfEUvDMGpDDu76gqBqltp243mLpZN+fTZJxdSjdqvbMMGSZkVq3p
	8VJW1RhmqqZz+Lqyng6BPfbvo6c5QmcgfGxfNTKYnOOn4DqaY3ZlAxDlyt2qBxJOCZ7IPc
	dK1qQLtQ6PhtGTUfhz10ngWg1/s6qSp0oDdSvdCGiX+GquZeYnVbsT+i7eeWkAd9HtdGn+
	KIQAJiGoRT0x70i1XiuW6DmPBXWmo0Je7eSceEwDRRqSGMYXeJGvwY+c3Qzs+g==
ARC-Authentication-Results: i=1;
	rspamd-75b4464bd-zzmqr;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Thread-Irritate: 495775406fad1307_1661460445947_1742403890
X-MC-Loop-Signature: 1661460445947:770955233
X-MC-Ingress-Time: 1661460445947
Received: from pdx1-sub0-mail-a304 (pop.dreamhost.com [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.123.39.217 (trex/6.7.1);
	Thu, 25 Aug 2022 20:47:25 +0000
Received: from [192.168.1.77] (unknown [5.77.65.55])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a304 (Postfix) with ESMTPSA id 4MDFQN1m16zHb
	for <xenomai@lists.linux.dev>; Thu, 25 Aug 2022 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1661460445;
	bh=0OC7F2+ND3UFPlbdiIxf1kLiM0qL8cLUggOItm6gLVA=;
	h=From:Subject:To:Date:Content-Type:Content-Transfer-Encoding;
	b=aU9VYoK5m/qGg4nS3M03+ib6fAnkDVJb0LNm89wa+sSpYzk0mAs5kfq3eUr1KnF2y
	 2pPu3SZtWng4zTCxanLN3x2dwln5aiuYw0I700t953PrHmBieseAIjoUQv7wnHYyrY
	 I1/OTKpf54pnZCBgG+4upH/skcwBtdAtW6/u6mgBMO3FY1Du3meGyGRlMVTrsVwl2U
	 mF2qKK2F1tA7G19eklNRHUt5n0NnMEmIK/Y2648ZHS7Gp84t4vyHkMQnshv2R7Sbqc
	 Bq9Kh5GVH4xvkxJX2uuxhk6qcqcu9KbxeJO7mLR/SHB3aQj91Rx3Pw6BVmzEDncAYu
	 u5gWI7uX5rSOg==
From: Giulio Moro <giulio@bela.io>
Subject: Issues with evl_mutex_trylock()
To: xenomai@lists.linux.dev
Message-ID: <a4c1ed74-2ae9-9427-994b-54dd7773399e@bela.io>
Date: Thu, 25 Aug 2022 22:47:21 +0200
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

In the toy example below I start some pthreads with SCHED_FIFO, priority 94 and setting the affinity of one thread per core. I then attach them to the EVL core and share a lock between them and the main thread. The main thread has a settable priority and schedule (SCHED_OTHER with prio 0 or SCHED_FIFO with higher priority) and its affinity is set to all available cores.

Here's a summary of what I get when running the test with some parameters (arguments are: "max iterations", "number of threads to create", "priority of the main thread", "flags (t means don't print anything). The error code reported alongside failures is the base 2 representation of the return code. 100 means that errors were detected in evl_unlock_mutex() in the main thread following a successful call to evl_trylock_mutex(). During these tests, the output is piped to cat and then redirected to /dev/null.

mutex-test 100000 0 0 t :  Success real 0m13.583s user 0m1.218s sys 0m0.000s
mutex-test 100000 0 90 t :  Success real 0m13.350s user 0m1.177s sys 0m0.000s
mutex-test 100000 0 99 t :  Success real 0m13.347s user 0m1.179s sys 0m0.000s
mutex-test 100000 1 0 t :  Success real 0m20.087s user 0m3.575s sys 0m0.000s
mutex-test 100000 1 90 t :  Success real 0m17.610s user 0m2.133s sys 0m0.000s
mutex-test 100000 1 99 t :  Success real 0m15.466s user 0m1.333s sys 0m0.000s
mutex-test 100000 2 0 t :  Failed 100 real 0m0.259s user 0m0.083s sys 0m0.000s
mutex-test 100000 2 90 t :  Failed 100 real 0m0.374s user 0m0.176s sys 0m0.000s
mutex-test 100000 2 99 t :  Failed 100 real 0m0.207s user 0m0.109s sys 0m0.000s
mutex-test 100000 3 0 t :  Failed 100 real 0m0.253s user 0m0.124s sys 0m0.000s
mutex-test 100000 3 90 t :  Failed 100 real 0m0.383s user 0m0.149s sys 0m0.000s
mutex-test 100000 3 99 t :  Failed 100 real 0m0.283s user 0m0.151s sys 0m0.000s
mutex-test 100000 4 0 t :  Failed 100 real 0m0.526s user 0m0.221s sys 0m0.000s
mutex-test 100000 4 90 t :  Failed 100 real 0m0.438s user 0m0.178s sys 0m0.000s
mutex-test 100000 4 99 t :  Failed 100 real 0m0.434s user 0m0.178s sys 0m0.000s

So, when running with 2 or more threads, the same error keeps surfacing very quickly.

Typically, when looking at the log of a failed test (needs to run with the `a` flag), you'd get something like this:
  ./mutex-test 10000 2 0 a
---snip---
thread 1 unlocked
thread 1 waiting
thread 0 locked
main try_lock 72
main try_lock: busy
main try_lock 73
main try_lock: busy
main try_lock 74
main try_lock: busy
main try_lock 75
thread 0 unlocked
main locked
thread 0 waiting
thread 1 locked
main ERROR unlock: -1 Operation not permitted
---snip---

So - if the evl_print() order is to be trusted - the main thread's try_lock() call succeeds and when it tries to release the lock it fails because it doesn't actually own the lock (EPERM). Note that after the main thread locks it and before it unlocks it, thread 1 has also managed to acquire the lock.
This typically happens the first time that main has successfully acquired the lock after the other threads have started.

I tried a quick and dirty pthread equivalent (build with -DUSE_PTHREAD) and that doesn't fail, which makes me think the logic of my code is OK.

I further observe the following unexpected behaviours:
- in the 0 and 1 thread cases, I get increasing values in the ISW column for the main thread when monitoring with evl ps -st. This happens regardless of the priority of the main thread and of the amount of data printed to the screen doesn't happen with 2, 3 or 4 threads (for these I have to run with 'k' to keep going after the errors and be able to observe the output of evl ps)
- running `./mutex-test 100000 1 X a` (where 'a' stands for "print all", and for any priority X) will almost always quickly show the following behaviour: the main thread to stops running, and process kworker/u8:3+stdout:3033.O runs at 100% CPU. I don't think it's expected that a SCHED_FIFO thread attached to the EVL core becomes blocked because it calls evl_printf(). Note that only the main thread is blocked, the other thread runs. This doesn't happen when numThreads == 0 or numThreads >= 2.
- running with `./mutex-test 100000 1 X q`, where 'q' is for "don't print anything", gives me 90% of the time an immediate hard lock up of the board (not even a stacktrace out of the UART!) (X can be any priority). Note that if this is run with `t` (throttled printing) or `a` (print all), it works kind of OK, apart from the issue mentione in the previous bullet point
- occasionally I get other lockups of the board during these tests that harder to reproduce. For instance, one happened at some point while running `./mutex-test 10000 3 0 t`
- I do get some EVL-related stacktraces relatively often when ctrl-C a starting program. I will make a separate post about this.

As previously, this is tested on TI's SK-AM62 with this branch https://source.denx.de/Xenomai/xenomai4/linux-evl/-/tree/vendor/ti/v5.10.120 and commit 7ccc58d62905724f1b8de4823e0fe8e0129b0fb7 of libevl (r37 + 1 )

Code below for posterity. Same code and testing routine also available here https://github.com/giuliomoro/evl-mutex-test.

#define _GNU_SOURCE
#include <sched.h>
#include <unistd.h>
#ifndef USE_PTHREAD
#include <evl/evl.h>
#endif // USE_PTHREAD
#include <pthread.h>
#include <string.h>
#include <error.h>
#include <stdlib.h>
#include <sys/sysinfo.h>
#include <stdio.h>
#include <errno.h>
#include <signal.h>

#define ERR_OTHER (1 << 0)
#define ERR_TRYLOCK (1 << 1)
#define ERR_UNLOCK (1 << 2)
#define ERR_LOCK (1 << 3)
#define ERR_BITS 4

#define PRINT_NONE 1
#define PRINT_ERRORS 2
#define PRINT_THROTTLED 3
#define PRINT_ALL 4
int printFlags = PRINT_ALL;
const int throttledPrints = 500;

#ifdef __EVL__
typedef struct evl_mutex mutex_t;
#else
typedef pthread_mutex_t mutex_t;
int nop(){ return 0; }
#define evl_init(...) nop()
#define evl_attach_thread(...) nop()
#define evl_attach_self(...) nop()
#define evl_printf(...) printf(__VA_ARGS__)
#define evl_create_mutex(mutex, ...) \
	-pthread_mutex_init(mutex, NULL);

int evl_lock_mutex(mutex_t* mutex)
{
	return -pthread_mutex_lock(mutex);
}
int evl_trylock_mutex(mutex_t* mutex)
{
	return -pthread_mutex_trylock(mutex);
}
int evl_unlock_mutex(mutex_t* mutex)
{
	return -pthread_mutex_unlock(mutex);
}
#define evl_usleep(...) usleep(__VA_ARGS__)
#endif

mutex_t mutex;
volatile int shouldStop;
pthread_t* threads;

void* kThreadSuccess = (void*)2l;
void* kThreadError = (void*)1l;

void* threadFunc(void* arg)
{
	int n = (long int)arg;
	int shouldPrint = (PRINT_NONE != printFlags);
	shouldPrint && evl_printf("Thread %d\n", n);
	int ret = evl_attach_thread(EVL_CLONE_PRIVATE, "thread-%d", n);
	if(ret < 0)
	{
		fprintf(stderr, "evl_attach_thread for thread %d failed with %s (%d)\n", n, strerror(-ret), -ret);
		return (void*)ERR_OTHER;
	}
	cpu_set_t readset;
	ret = pthread_getaffinity_np(threads[n], sizeof(readset), &readset);
	if(ret)
	{
		fprintf(stderr, "pthread_getaffinity_np %d %s\n", ret, strerror(ret));
		return (void*)ERR_OTHER;
	}
	char str[1000];
	char* p = str;
	// assemble the string before evl_printf to avoid scrambling because of
	// writing from multiple threads
	if(shouldPrint)
	{
		p += snprintf(p, sizeof(str) - (p - str), "Affinity for %d: [ ", n);
		for (int j = 0; j < CPU_SETSIZE; j++)
			if (CPU_ISSET(j, &readset))
			{
				if(p < str + sizeof(str));
					p += snprintf(p, sizeof(str) - (p - str), "%d  ", j);
			}
		evl_printf("%s]\n", str);
	}
	long int err = 0;
	unsigned int c = 0;
	while(!shouldStop)
	{
		int shouldPrint = (PRINT_ALL == printFlags) || ((PRINT_THROTTLED == printFlags) && (0 == (n % throttledPrints)));
		int shouldPrintError = (PRINT_NONE != printFlags);
		c++;
		shouldPrint && evl_printf("thread %d waiting\n", n);
		int ret = evl_lock_mutex(&mutex);
		if(ret) {
			shouldPrintError && evl_printf("thread %d ERROR lock() %d %s\n", n, ret, strerror(-ret));
			err |= ERR_LOCK;
		} else {
			shouldPrint && evl_printf("thread %d locked\n", n);
			for(volatile unsigned int n = 0; n < 100000; ++n) // do some work
				;
			ret = evl_unlock_mutex(&mutex);
			if(ret) {
				shouldPrintError && evl_printf("thread %d ERROR unlock() %d %s\n", n, ret, strerror(-ret));
				err |= ERR_UNLOCK;
			} else {
				shouldPrint && evl_printf("thread %d unlocked\n", n);
			}
		}
	}
	return (void*)err;
}

void sig_handler(int var)
{
	shouldStop = 1;
}


int main(int argc, char** argv)
{
#ifdef __EVL__
	char backend[] = "EVL";
#else
	char backend[] = "pthread";
#endif
	int maxThreads = get_nprocs();
	if(argc < 4)
	{
		fprintf(stderr, "Usage \"%s numIter numThreads mainPrio [flags]\"\n"
				"Where flags is a combination of:\n"
				" k: keep going on error (default: no)\n"
				" q: print nothing\n"
				" e: print errors\n"
				" t: print every %d iterations or errors\n"
				" a: print all (default)\n"
				, argv[0], throttledPrints);
		return ERR_OTHER;
	}
	int numIter = atoi(argv[1]);
	int numThreads = atoi(argv[2]);
	if(numThreads > maxThreads)
	{
		fprintf(stderr, "Too many threads\n");
		return ERR_OTHER;
	}
	int mainPrio = atoi(argv[3]);
	if(mainPrio > sched_get_priority_max(SCHED_FIFO))
	{
		fprintf(stderr, "Too high priority\n");
		return ERR_OTHER;
	}
	int keepGoing = 0;
	if(argc >= 5)
	{
		const char* str = argv[4];
		for(unsigned int n = 0; n < strlen(str); ++n)
		{
			switch (str[n])
			{
			case 'k':
				keepGoing = 1;
				break;
			case 'e':
				printFlags = PRINT_ERRORS;
				break;
			case 'q':
				printFlags = PRINT_NONE;
				break;
			case 't':
				printFlags = PRINT_THROTTLED;
				break;
			case 'a':
				printFlags = PRINT_ALL;
				break;
			}
		}
	}
	int shouldPrint = (PRINT_NONE != printFlags);
	shouldPrint && printf("Using %s\n", backend);
	shouldPrint && printf("NumThreads: %d\n", numThreads);

	int threadPrio = 94;
	signal(SIGINT, sig_handler);
	threads = (pthread_t*)malloc(sizeof(threads[0]) * numThreads);
	int ret = evl_init();
	if(ret < 0)
	{
		fprintf(stderr, "evl_init: %d %s\n", ret, strerror(-ret));
		return ERR_OTHER;
	}
	ret = evl_create_mutex(&mutex, EVL_CLOCK_MONOTONIC, 0, EVL_MUTEX_NORMAL | EVL_CLONE_PRIVATE, "test-mutex");
	if(ret < 0)
	{
		fprintf(stderr, "evl_create_mutex: %d %s\n", ret, strerror(-ret));
		return ERR_OTHER;
	}
	ret = evl_attach_self("main");
	if(ret < 0)
	{
		fprintf(stderr, "evl_attach_self: %d %s\n", ret, strerror(-ret));
		return ERR_OTHER;
	}
	// EVL will have pinned this thread on the current CPU. Allow it to run
	// on all CPUs. Critically, this needs to be done before alowing
	// threads to run, or we may be starved by whichever one runs on our core.
	cpu_set_t cpuset;
	CPU_ZERO(&cpuset);
	for(unsigned int n = 0; n < maxThreads; ++n)
		CPU_SET(n, &cpuset);
	ret = pthread_setaffinity_np(pthread_self(), sizeof(cpuset), &cpuset);
	if(ret)
	{
		fprintf(stderr, "pthread_setaffinity_np: %d %s\n", ret, strerror(ret));
		return ERR_OTHER;
	}
	int policy = mainPrio ? SCHED_FIFO : SCHED_OTHER;
	struct sched_param param;
	param.sched_priority = mainPrio;
	ret = pthread_setschedparam(pthread_self(), policy, &param);
	if(ret)
	{
		fprintf(stderr, "pthread_setschedparam: %d %s\n", ret, strerror(ret));
		return ERR_OTHER;
	}
	ret = evl_lock_mutex(&mutex);
	if(ret < 0)
	{
		fprintf(stderr, "evl_lock_mutex: %d %s\n", ret, strerror(-ret));
		return ERR_OTHER;
	}
	for(unsigned int n = 0; n < numThreads; ++n)
	{
		cpu_set_t cpuset;
		CPU_ZERO(&cpuset);
		// start from the last CPU to avoid using 100% of CPU 0 when
		// there is no other thread contending for the lock
		CPU_SET(maxThreads - 1 - n, &cpuset);
		pthread_attr_t attr;
		ret = pthread_attr_init(&attr);
		ret |= pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
		ret |= pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
		ret |= pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
		ret |= pthread_attr_setaffinity_np(&attr, sizeof(cpuset), &cpuset);
		struct sched_param param;
		param.sched_priority = threadPrio;
		ret |= pthread_attr_setschedparam(&attr, &param);
		ret |= pthread_create(&threads[n], &attr, threadFunc, (void*)(long int)n);
		if(ret)
		{
			fprintf(stderr, "An error occurred while creating thread %d\n", n);
			return ERR_OTHER;
		}
	}
	shouldPrint && evl_printf("All threads go\n");
	ret = evl_unlock_mutex(&mutex);
	if(ret)
	{
		evl_printf("main ERROR unlock before loop\n");
		return ERR_OTHER; // TODO: cleanup
	}
	shouldPrint && evl_printf("main unlocked before loop\n");

	long int err = 0;
	for(unsigned int n = 0; n < numIter && !shouldStop; ++n)
	{
		int shouldPrint = (PRINT_ALL == printFlags) || ((PRINT_THROTTLED == printFlags) && (0 == (n % throttledPrints)));
		int shouldPrintError = (PRINT_NONE != printFlags);
		shouldPrint && evl_printf("main try_lock %d\n", n);
		int ret = evl_trylock_mutex(&mutex);
		if(0 == ret)
		{
			shouldPrint && evl_printf("main locked\n");
			ret = evl_unlock_mutex(&mutex);
			if(ret) {
				shouldPrintError && evl_printf("main ERROR unlock: %d %s\n", ret, strerror(-ret));
				err |= ERR_UNLOCK;
				if(!keepGoing)
					break;
			}
			else
				shouldPrint && evl_printf("main unlocked\n");
		} else if (-EBUSY == ret) {
			shouldPrint && evl_printf("main try_lock: busy\n");
		} else {
			shouldPrintError && evl_printf("main ERROR try_lock: %d %s\n", ret, strerror(-ret));
			err |= ERR_TRYLOCK;
			if(!keepGoing)
				break;
		}
		evl_usleep(100);
	}
	shouldStop = 1;
	for(unsigned int n = 0; n < numThreads; ++n)
	{
		shouldPrint && evl_printf("Joining %d\n", n);
		void* res;
		ret = pthread_join(threads[n], &res);
		shouldPrint && evl_printf("Joined %d : %s; result is %p\n", n, ret ? strerror(ret) : "", res);
		err |= (((long int)res) << ERR_BITS);
	}
	free(threads);
	if(err)
		shouldPrint && evl_printf("ERROR\n");
	else
		shouldPrint && evl_printf("SUCCESS\n");
	return err;
}



