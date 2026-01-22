Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2925A38BF74
	for <xenomai@lists.linux.dev>; Thu, 22 Jan 2026 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769108469; cv=none; b=nxzYkCbtkvUIAKrSN1IAAnu1XzD9jLDEpo5TnqO0f4OSL4OM4v8J5a5k0NcoLPAhjgJQWBopfoVPb7PJ3tD+XTQ4t0/uokIYpDWz7nF26h8Iqlfd7bNwXeGikbRtG6Ic6HMjzxZIWzUN3E5B8l7+Tw3zCI/kGnEKfmLwtBoz8WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769108469; c=relaxed/simple;
	bh=n/E8Gw0FCUD4EZl15jYnL+0BSQHyQVgtLTi4IFhRTFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lEMWsOL/Y8uMwrOlzDbfvw1JtyiynBJPH6DmIrFgG7AHSwV6S8sqCdud3IcjEDNY/Tigwib30lPziTTNWlwGy7cC2Hgnb7GXAP8D4ZPYiJNc8SLUSuQjGAX/KL6qlRHlcuqGoo3cFQ1Fj8VcDU5SPSNmd5jWGkGQdbuwUbP4kZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=k+4k5w8z; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="k+4k5w8z"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5B19D204B4;
	Thu, 22 Jan 2026 19:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1769108434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MsP5iKReG5bWOsqz64loGljKg10kBtw6u1XNSRPz5WM=;
	b=k+4k5w8z2i3U/029RqyitYOT10b/IM+HYUgGHg++1qvaaNlP89U/WsbVv52sOUuwYpwdVM
	Ou+GJwbBgOiso8imJZZbasWzJtHR4awfF2RKK6i+rppNPDXyHQU2flwhHlP98RSjJprYIS
	yClExOA+a6+/oj1Um9ABpYjD2F15QDMGq8N0jm0c2aPELlXugzOy6poBhSN4fy6apcjCz5
	mz72SbEEuB47DZwga7es2R3vwUSX9UcjVPZUDM+c1glk2EiqvN3OBQ7Vj6ozONZzDsCEap
	PNlSmDAp4AZMscu3/mUnMZqT5gtDk4UNBaTwAQKPV+5hpZ75mxpRWdyQ8BFuTw==
From: Philippe Gerum <rpm@xenomai.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Tobias Schaffner <tobias.schaffner@siemens.com>,  xenomai@lists.linux.dev
Subject: Re: [PATCH xenomai-images] ci: run the EVL testsuite for basic testing
In-Reply-To: <1141d131-a699-4050-8f38-8775cfe13f6a@siemens.com> (Jan Kiszka's
	message of "Thu, 22 Jan 2026 15:46:17 +0100")
References: <20260122103928.424945-1-tobias.schaffner@siemens.com>
	<8ad846eb-c7b6-4056-818e-9e12f8a94cb2@siemens.com>
	<1141d131-a699-4050-8f38-8775cfe13f6a@siemens.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 22 Jan 2026 20:00:32 +0100
Message-ID: <87qzrhiib3.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeeileegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeeulefggfehtdefgeekgfffudetkeekhfehudehfeeigffgjeekkeelfeekjeeuveenucffohhmrghinhepghhithhlrggsrdgtohhmnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhqihgupeehueduleffvddtgeeugedpmhhouggvpehsmhhtphhouhhtpdhnsggprhgtphhtthhopeefpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehtohgsihgrshdrshgthhgrfhhfnhgvrhesshhivghmvghnshdrtghomhdprhgtphhtthhopehjrghnrdhkihhsi
 ihkrgesshhivghmvghnshdrtghomh
X-GND-State: clean

Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 22.01.26 13:48, Jan Kiszka wrote:
>> On 22.01.26 11:39, Tobias Schaffner wrote:
>>> Run the EVL test suite for some first smoke tests.
>>>
>>> EVL_TESTS_SKIP_PATTERN allows to exclude tests in the test suite. At
>>> the moment this is used to disable scheduling quota tests that fail on
>>> virtual targets.
>>>
>>> Signed-off-by: Tobias Schaffner <tobias.schaffner@siemens.com>
>>> ---
>>>  ci/gitlab-ci-base.yml | 5 +----
>>>  ci/xenomai_4_next.yml | 1 +
>>>  2 files changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/ci/gitlab-ci-base.yml b/ci/gitlab-ci-base.yml
>>> index 186d1cb..76e38e6 100644
>>> --- a/ci/gitlab-ci-base.yml
>>> +++ b/ci/gitlab-ci-base.yml
>>> @@ -107,8 +107,6 @@ default:
>>>          - report.xml
>>>      expire_in: 1 week
>>>    rules:
>>> -    - if: '$XENOMAI_VERSION == "4-next"'
>>> -      when: never
>>>      - if: '$LAVA_TESTS_ENABLED == "true"'
>>>  
>>>  .test-qemu:
>>> @@ -116,9 +114,8 @@ default:
>>>    variables:
>>>      ADDITIONAL_XENO_TEST_ARGS: "--vm"
>>>      ADDITIONAL_TEST_TIMEOUT_MINUTES: 25
>>> +    EVL_TESTS_SKIP_PATTERN: "sched-quota-accuracy|sched-tp-accuracy|sched-tp-overrun"
>>>    rules:
>>> -    - if: '$XENOMAI_VERSION == "4-next"'
>>> -      when: never
>>>      - if: '$LAVA_TESTS_ENABLED != "true"'
>>>        when: never
>>>      - if: '$KERNEL_VERSION == $KERNEL_VERSION_WITH_QEMU'
>>> diff --git a/ci/xenomai_4_next.yml b/ci/xenomai_4_next.yml
>>> index 30ca9b1..03dc233 100644
>>> --- a/ci/xenomai_4_next.yml
>>> +++ b/ci/xenomai_4_next.yml
>>> @@ -20,3 +20,4 @@ variables:
>>>    KERNEL_VERSION_WITH_QEMU: "6.12"
>>>    BUILD_IDENTIFIER: "evl-${XENOMAI_VERSION}_kernel-${KERNEL_VERSION}"
>>>    CACHE_KERNEL: evl
>>> +  TEST_COMMAND: "evl test -k $(evl test -l | grep -Ev \"${EVL_TESTS_SKIP_PATTERN}\")"
>> 
>> Thanks, applied.
>> 
>
> Seems there is an issue with ptrace right now:
>
> https://gitlab.com/Xenomai/xenomai-images/-/pipelines/2278891139
> ("** ptrace-sync: BROKEN" on all archs, 6.1 and 6.12)
>

This is a new unit test recently added to check the newly revamped
synchronous ptracing support available with x4, there was no such test
prior to libevl r56. Since I cannot reproduce this issue on any of my
targets here, I suspect some pattern matching issue against the gdb
output in the CI environment, or even a more basic problem forking off
gdb.

Running this test manually with verbosity turned on (-v) may help
pinning down the problem, e.g.:

$ evl test ptrace-sync -- -v

-- 
Philippe.
