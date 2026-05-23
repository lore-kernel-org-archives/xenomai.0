Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B853451AF
	for <xenomai@lists.linux.dev>; Sat, 23 May 2026 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779535748; cv=none; b=KzykBDycrLn0kuH//x004j6RFc3e9JOMHv28RMkF/q5xUO0gpRMi4a0qR82i4v30Q546BiyaJDTIx8iVFVL7RA/p68rRIEm/KJQiqMESvz7sSsX6344LIbjPrkcAVgIQYMjXUeUHCnb5nxseVBZXdlz2ey/jk29n78PpwHuk4cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779535748; c=relaxed/simple;
	bh=TFbxvAOZFD41CYYulQLu9FHje954d5r2U8bHCLcn9eE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ci+hx4yv/8BHfQLu58VZvEjcDgecLr6es0ZVWY2vMBnl7jPhVEooV/mihXMk3yHlH8v8WVYzTArUaoEL8WrvG1hhc9FDDXfxKPVl1QFdHW9hzaXdna5O8bYDYshB4z7T7Cb7xmVGgUPl+vY+ZmlUis0+SynOSaWV4pLcFwOHhHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=BRrN2Zr4; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="BRrN2Zr4"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8A6883E972;
	Sat, 23 May 2026 11:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1779535737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ip7fEYeyjPiI/cs+QXwPMD9wIpQzG/e60buZ6khMBSQ=;
	b=BRrN2Zr45Hswg5Eq9DkxPezKqAlM3b8IeAmruzFxCHnxylK4qKyk8QikimM+vwruW90Pyo
	gN67vMFUPGtGAdNG25Qotx+TyB7qAG56OjG1VgrP3cVx6FMd+1EAddMuJ+xDZrqNx0CEiu
	u+Dfy9SEJR8JSknPwC6IFf4FH8sXsAjWOB2TF8BeO1ggefJa0eKesCF4ijjAbAt6UjbWhc
	dH1XzrYHs/3CN3y/poJ8Ak8TBDjcj7irZPJUu6UXmVA1gRS8o8czCHqMDiUlRKlVDwoMW9
	NVcmCYYkX9wIpElLhZNK7eO2juyCC0Iq37hPdwrMhmG0UWD72cropCa6TEvksw==
From: Philippe Gerum <rpm@xenomai.org>
To: Hannes Diethelm <hannes.diethelm@gmail.com>
Cc: xenomai@lists.linux.dev
Subject: Re: [EVL] Client UDP not receiving data
In-Reply-To: <c8a23c39-b13b-4f89-9967-35d8195d4e2d@gmail.com> (Hannes
	Diethelm's message of "Sat, 23 May 2026 12:00:43 +0200")
References: <6f9e6ff2-95a7-402c-90d6-19f0f89bbc80@gmail.com>
	<87v7chf5xm.fsf@xenomai.org>
	<327a363e-6b79-45b2-a5b0-6b9f8a82d756@gmail.com>
	<87y0hbe9kw.fsf@xenomai.org>
	<19e440ba-bb7a-47ba-a1a9-bb72eb83badd@gmail.com>
	<87tsryo6sv.fsf@xenomai.org>
	<c8a23c39-b13b-4f89-9967-35d8195d4e2d@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Sat, 23 May 2026 13:28:56 +0200
Message-ID: <87o6i6nz47.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Cause: dmFkZTEN24UW7QYPbBgOJB2gn50jV5FRvBAiGLBPxUgH45pQuOKm9EoHdd88zInM3BClVOVp0U9DAUpglQn7YobsonmoYTLFCIrpLeqANiTknd5TjPVMHN5CfDgRSAR0t3qShU0ElSN9//rhJoHHtxZcN1BRrSxlK/pgEBMQ7j1NL0AhznU9GKzahH0/h9SSGuOIMJ34KT6woYBU1ERWnHIkvIE0puz6qqcMgH//VYt9rLcK0tgKY+SMWZn1RaNfkcNkYtj+CKNzJIqglqcCxL/baYl1ZuoBoX0IUnZ7qGx9J81UbGVuOAs6WoDJhqKozKtiM3OftHwZfheVq1T1oUrgnHAPeVHzoMIl3lsfWrYrPUCwylJhWOCQ64bK3miDh8GPaWlEBM6JZKZEWpQddL77e+1d5Vs5jV8z8Otl5J25iCznQpD2zRsGcPJpt6LETnqyQhiL94qFp3a33S7lpa9qKEPrXQ7s9fAlHhaUIcMwP8U5axZHKOBRnQr5CT/XWasyynmohGPshrxhhVaAkeeY8cGzXsJ6Kf/ZO14JcVEqCOeuI+Nb5CKY5xJPkvjen5SR+Qp6nbd/prS+cfXeE01YK0loY/V6gLsANqA08p6ZT7f03xtng7xttd3o6OVNNffTUOCqEl9spEXQ6Zx8fhJGx8aZxoTeqyY22OSOIQFBOhIWHA
X-GND-State: clean
X-GND-Score: -100

Hannes Diethelm <hannes.diethelm@gmail.com> writes:

> Am 23.05.26 um 10:42 schrieb Philippe Gerum:
>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>> 
>>> Am 22.05.26 um 17:40 schrieb Philippe Gerum:
>>>> Hannes Diethelm <hannes.diethelm@gmail.com> writes:
>>>>
>>>>>
>>>>> Thanks for the detailed answer. I might have been not precise enough.
>>>>>
>>>>> The -S and the -R mode work as designed. To show the issue with connect() in evl, I changed
>>>>> the -S mode to:
>>>>> connect()
>>>>> while{
>>>>>     oob_sendmsg()
>>>>>     oob_recvmsg()
>>>>> }
>>>>>
>>>>> This is the classical UDP client pattern. It works with vanilla linux (net-udp.c)
>>>>> but not with evl (oob-net-udp.c), I do not receive any data.
>>>>>
>>>>> By just sending the modified code, it is easy to explain and hopefully for you to
>>>>> reproduce. This is also why I attached the files instead of sending a patch.
>>>>> Be aware that this is just to demonstrate what is not working, not intended as a patch.
>>>>>
>>>>> I run Xenomai4 in a VM and communicate with the host for debugging
>>>>> but I have also a real PC as the final target where I have the same issues.
>>>>>
>>>>> First start on the host:
>>>>> echo Hello | nc -u -l 5201
>>>>>
>>>>> Then in the VM:
>>>>> sudo evl net -ei enp7s0
>>>>> sudo oob-net-udp -d -i enp7s0 -a 192.168.122.1 -p 5201 -S
>>>>>
>>>>> On the host:
>>>>> Mellow sword!
>>>>>
>>>>> In the VM:
>>>>> == bound to enp7s0
>>>>> == sender mode (=> 192.168.122.1:5201)
>>>>> --------tx--------
>>>>> IP-Adresse: 192.168.122.1
>>>>> Port:       5201
>>>>> Family:     512
>>>>> --------rx--------
>>>>> IP-Adresse: 192.168.122.155
>>>>> Port:       58422
>>>>> Family:     512
>>>>>
>>>>> The package is visible in wireshark but oob_recvmsg does not return:
>>>>> No "= 6 bytes received: Hello" and no second transmit.
>>>> Ok, I totally misinterpreted your previous post, sorry for
>>>> that. Brain received -ENOCOFFEE.
>>>>
>>>>>
>>>>> It looks like the auto assigned and bound port from connect() is not forwarded
>>>>> to the oob stage, so no data is received in oob_recvmsg().
>>>>>
>>>> This is exactly the point, indeed. Could you please try this branch
>>>> [1]?
>>>> The two commits on top improve the situation with your test code here.
>>> Thanks for the very fast fix. Connect works now as expected. And I was able to remove the workaround.
>>>
>>> I switched to libevl r58, r57 did not work any more. Is there any visible link libevl->kernel? I just
>>> got an operation not permitted in oob_sleep_until.
>>>
>> Recent evl ABI updates are likely causing this, r58 is required to
>> run
>> any kernel with ABI #44. Every single change affecting the ABI also used
>> to cause its revision number to be incremented, hence the seemingly high
>> value (implementing the evl core started back in 2018). The model has
>> recently switched to bulk updates instead, i.e. a series of ABI updates
>> under a single revision.
>> On the kernel side, the file include/uapi/evl/control-abi.h tracks
>> the
>> base/earliest and current ABI revisions the evl core supports, such
>> decoupling helps in providing backward compatibility from the latter to
>> the former, e.g. if EVL_ABI_BASE is 30 and EVL_ABI_LEVEL is 45, then an
>> application which was compiled against any ABI level >= 30 can use this
>> core. Looking at include/evl/version.h in libevl, you should see the
>> symbol EVL_ABI_PREREQ set to the earliest ABI revision that particular
>> version of libevl can work with, i.e. matched to EVL_ABI_BASE.
>> A recent string of ABI changes went in to support the upcoming POSIX
>> interface, they have been grouped in a single update which triggered ABI
>> #44. That one was going to break backward compat as I hinted at a couple
>> of months ago, aligning EVL_ABI_BASE on EVL_ABI_LEVEL to #44.
>> The development tip for each kernel is now hosted in some next/*
>> branch
>> in the repo, e.g. next/v6.12.y-cip-evl-rebase, which contains staging
>> code until it moves to the rebase/ branch,
>> e.g. v6.12.y-cip-evl-rebase. The next/* kernel branches match the libevl
>> -next branch ABI-wise.
>> IOW, in order to work with the bleeding-edge code implementing any
>> recently discussed changes, you may want to switch to libevl/next and
>> any next/* branch on the kernel side (v6.12.y-cip-evl, v6.18.y-evl, or
>> v7.0-evl ATM).
>> 
>
> Thanks for the details. For now, libevl r58 works well with next kernel but I will go to next on both
> repos if I see any issues and test it there also before reporting them.
> The inegrated check works if I go back to r57 with a small test program:
> evl: ABI mismatch, see -ENOEXEC at https://v4.xenomai.org/core/user-api/init/#evl_init
> ./oob-net-udp: cannot attach to the EVL core: Exec format error
>
> I think I just had so many error messages that I did not see ^ in the real application.
>
>>> But there are two new issues:
>>>
>>> -oob_sendmsg returns "Invalid argument" errno 22 exactly every second. The last number is the
>>> system time in ns.
>>> ERROR: oob_sendmsg Invalid argument 22 806999652287
>>> ERROR: oob_sendmsg Invalid argument 22 807999655503
>>> ERROR: oob_sendmsg Invalid argument 22 808999650416
>>>
>>> I have this with the exact same code as before using bind() and also with the now working connect().
>>> There are 3000 tx / 1000 rx packages/s.
>>>
>>> I tried do{oob_sendmsg}while(errno == 22) but that resulted in a full freeze of the PC.
>>>
>> Sounds like an ABI issue, I cannot reproduce this. Switching to the
>> 'next' branches on both sides may help.
>
> This was an -ENOCOFFEE on my side. I was using:
> evl_read_clock(EVL_CLOCK_MONOTONIC, &ts_timeout);
> ts_timeout.tv_nsec += 1000*1000;
> ...
> oob_sendmsg(board->sockfd, &msghdr, &ts_timeout, flags);
>
> Of course this overflows tv_nsec exactly every second. It seams you or some else verifyes this now
> and return "Invalid argument".
>
> With this, everything works now:
> evl_read_clock(EVL_CLOCK_MONOTONIC, &ts_timeout);
> ts_timeout.tv_nsec += 1000*1000;
> while(ts_timeout.tv_nsec >= 1000000000){
>     ts_timeout.tv_nsec -= 1000000000;
>     ts_timeout.tv_sec ++;
> }
> ...
> oob_sendmsg(board->sockfd, &msghdr, &ts_timeout, flags);
>
>> 
>>> -The last commit a4cc7967 on the next branch doesn't compile. Just FYI, I took one commit before, so I was able to test it.
>>>
>> My bad, fixed in the kernel next/* branch.
>> 
>>>>>
>>>> I think we need a simple agent somewhere in the evl netstack in
>>>> kernel
>>>> space answering ICMP_ECHO requests flowing in oob channels directly,
>>>> just like the in-band stack does for in-band traffic. I can look into
>>>> this.
>>> The oob-net-ping sends out pings, so basically the inverse of the existing oob-net-icmp. Now you can run
>>> oob-net-ping on one machine and oob-net-icmp on the other to ping between. For my application, I use it to ping an FPGA
>>> board to see if the connection basically works.
>>>
>> Ok, makes sense too. I'm ok with both approaches actually, it's your
>> call.
>> 
>>> ICMP_ECHO would help in some cases, but ^ works also.
>>>
>> Agreed, we need a built-in ICMP_ECHO responder in the core, which we
>> could disable programmatically as well, so that a ping service
>> implemented in userland which would use the raw packet interface may
>> switch it off for receiving ICMP requests.
>> 
> Ok, I will send a patch as soon as it is ready. Can take some time, depending on what is going on otherwhise.

Nice, thanks. I believe that since we may have in-kernel ICMP_ECHO reply
and oob-net-ping at about the same time, we should make the latter a
general utility (libevl/utils) instead of a tidbit/example,
e.g. evl-ping. This way, we would have a standard command for pinging a
remote oob-enabled machine, that would also work with oob-net-icmp when
disabling the in-kernel ICMP handling.

e.g.:

# Probing side
$ evl ping 10.10.10.10

# ICMP server side
$ oob-net-icmp -i eth0.42

-- 
Philippe.
