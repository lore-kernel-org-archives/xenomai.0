Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CE534BA59
	for <xenomai@lists.linux.dev>; Thu,  9 Oct 2025 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760036734; cv=pass; b=SHxdHouzvS50h+q+HWz7UH7mCUWhY/N51HAuSL3EEVn9rxhLnIMBnSXwQyGJVJJCCD3wKvoEpbNssAoocqO8iYUTbZiXIei9Gr+SAeTNWA977lS73dJSttKgzUqCr1ahdRU8/h2gRABdejYrXwAx68LR+K6TEbV4GubzogXfIVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760036734; c=relaxed/simple;
	bh=MHPAIlMcZMKrKDh2wIPwKX17AqK1NjNvF19pEnNeHdQ=;
	h=From:Subject:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=L2IPJgZ4Whj1IWCxM+Wfjv3+necUkx56ebtI7iE89E00VWXb2Uib77QxoVyD5JIwFwwhKC5b2QH+34V4Tb+3lhEG20XgPzxAB3YlMxLh83Kaj9ZEJ/51GLzssHse+VsuChruejE8J48evzX6XOldhdy55A88+BV5gMa4B+4m9O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io; spf=pass smtp.mailfrom=bela.io; dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b=usb96FEu; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bela.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bela.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bela.io header.i=@bela.io header.b="usb96FEu"
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8BDA22E3568;
	Thu, 09 Oct 2025 19:05:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a226.dreamhost.com (100-114-102-221.trex-nlb.outbound.svc.cluster.local [100.114.102.221])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 335D22E32DB;
	Thu, 09 Oct 2025 19:05:30 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1760036730; a=rsa-sha256;
	cv=none;
	b=kGP0cLlrM98SHnjq5pjlnT0a8x4gclvXGQjXeLecN+QCREUY/PGKYzHVmukbONBTIYDhbY
	XbIJm8TQphtGdcjLqw90FtJxlUz+Z35NCUEI9uj3zTpWLi6OZjtt7UE1okolWMoqn6BmXJ
	O3OwLiuOPstD87aO6zpsLjk3jRfkUrrB34PcjY/Zc/PYPYA5vmYDWkKoUVXi/AWPXVtFYb
	hSI72SgK8pnyAF7nEHrgMt1ampN2VX7kWtlVaSJcWkwwO+T7LGhi+xXVoPvqIH7WiZUt2j
	YvFEDVfPA0buc59/M4r0hV2xH+WWxA+8OdeF63osRgRYBzCz2WL7AGcZPcsqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1760036730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Ob15YKjtWtwE17JnpyElcERcuJEdc/N9IBhEHI2nVzw=;
	b=49aY7byzNGJXk2qZcRDYktDN0uthMKoQGgB8z47yrBGfTpB3TVE/aL4vyHNfz8s/w2HM7i
	MRFd+JGHRHPRNryGR4PA7HunH7Swcko+TtPYQF8aBTUa5F+E/ZsDiCZ1hgkrAgSMM2Tusu
	U/hzAB0W8LYHGwoZpBN3kEc58ULK3XF+Ok0odVAptz9pfBJGYOp8gaCMMz5c9LeXlejhln
	YFyImyqcbky5yBLLYJ9thMSC9cKfOcgPUzcHweu7ms6WpDCE6xk4N5e42enoHDPSQ0rGVW
	IhIzZ7A4jJHBpIRPm9lbAFkiXyLCrV9H12k7JqhXYwCXrjFiGHUVfYjOdHt1cQ==
ARC-Authentication-Results: i=1;
	rspamd-777888ddf6-6cwqz;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=giulio@bela.io
X-Sender-Id: dreamhost|x-authsender|giulio@bela.io
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|giulio@bela.io
X-MailChannels-Auth-Id: dreamhost
X-Arithmetic-Army: 4bd84e0b5e92764a_1760036730397_3101459982
X-MC-Loop-Signature: 1760036730397:2975229927
X-MC-Ingress-Time: 1760036730397
Received: from pdx1-sub0-mail-a226.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.114.102.221 (trex/7.1.3);
	Thu, 09 Oct 2025 19:05:30 +0000
Received: from giulios-MacBook-Pro.local (unknown [191.98.11.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: giulio@bela.io)
	by pdx1-sub0-mail-a226.dreamhost.com (Postfix) with ESMTPSA id 4cjK8930Jsz3f;
	Thu,  9 Oct 2025 12:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bela.io;
	s=dreamhost; t=1760036729;
	bh=Ob15YKjtWtwE17JnpyElcERcuJEdc/N9IBhEHI2nVzw=;
	h=From:Subject:To:Cc:Date:Content-Type:Content-Transfer-Encoding;
	b=usb96FEu+tTcj9hItoZeM0r5PO4AKonp6ByTfbvUmGKAxVR2n7ujplXRp4cKfRXzc
	 ocRABcDlx4lfWNM1kQWNs3YOGeapZNktAjZlmHVKQyE3lsIvx1RViorqavALxX2/SY
	 S42lyGe+NG3AOSU8/1n1ubwHRYPeIU8R2pSXNiYcWfJS1Qk9bZpJLJ30NXXY6qeivi
	 dcmenwKTawL50lZNx7JNm5RZmfrxyy0K+Vm3mDyUAk4R9LYSVigOH71I7Gpp5Cg2DR
	 Z7nisI4LztWmeY/h7FOL5Lp4xFBEVQtUP2SekiCOdliMQfrNc/gPXhg96Sc2Owvfmb
	 ORmwaA1ccvDUg==
From: Giulio Moro <giulio@bela.io>
Subject: Re: Unexpected switches to in-band
To: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@nabladev.com>
Cc: Xenomai <xenomai@lists.linux.dev>
References: <d3f7d465-e914-bf4d-be69-7e42fe288064@bela.io>
 <20251009151737.0d03b211@wsk>
Message-ID: <20676160-4572-d92d-4b33-ff4255946345@bela.io>
Date: Thu, 9 Oct 2025 14:05:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 14.3; rv:128.0)
 Gecko/20100101 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251009151737.0d03b211@wsk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> It seems like latmus is trying at some point access some evicted from
> cache memory page...

> In my case I do use two simple test programs to allocate C++ <vector> -

Thanks, that put me on a path to reliably reproduce this.

Swap is disabled. I, then set up the system so that the oom-killer has is easy: it kills the allocating process. This is much faster at executing than going through the list of programs and picking the one with the worst score.

echo 2 | sudo tee /proc/sys/vm/overcommit_memory
echo 0 | sudo tee /proc/sys/vm/overcommit_ratio
echo 1 | sudo tee /proc/sys/vm/oom_kill_allocating_task

I then have a C++ program allocating 50MiB, and I run 4 or more instances of it, one per core:
  
while sleep 0.1; do ./alloc& ./alloc& ./alloc& ./alloc; done

Furthermore, I have four instance of dd in the background:

dd if=/dev/zero of=/dev/null

With that, I can trigger latmus's inband switch pretty reliably within seconds (e.g.: latmus -m -K -p 360). If instead of latmus I run our application, it seems to be even faster and more reliable at triggering an in-band switch (once I set T_WOSS | T_WOLI | T_WOSX | T_HMSIG for the thread), and sigdebug_marked() confirms it is marked as sigdebug. While running it inside gdb I can inspect the backtrace upon receving the signal and it seems to be happening in seemingly harmless places. Most of the time it happens at some depth inside evl_usleep(), sometimes it happens inside libc's sinf(), sometimes somewhere else in our rt thread. I'd guess I just see it happen at random places, so the fact that it happens more often in evl_usleep() it's just because the thread spends 85% of the time in it. Note that our application never uses raw_copy_from_user(): the only call into the kernel from the real-time thread is via evl_usleep()

It may be of interest that if I disabled (T_WOSS | T_WOLI | T_WOSX | T_HMSIG) in our application and thus it's free to keep running when receiving an ISW, I can see the number of ISW grows quickly in the first few seconds of execution to something like 20 but then remains constant . Similarly, latmus with -K seems to accumulate several (5 to 10) ISW at the beginning and then proceed without any further ISW for several minutes. They eventually occasionally occur again, but much more sparingly than in the first few seconds.

For completeness, here's the C++ program I use for testing. I attempt to allocate memory in smaller chunks and get close as close as I can to filling up system memory across the four processes before the oom kills one of them.

#include <vector>

int main()
{
	std::vector<std::vector<char>> all;
	for(unsigned int n = 0; n < 5; ++n)
	{
		all.emplace_back();
		all.back().resize(10 * 1024 * 1024);
	}
	return 0;
}
