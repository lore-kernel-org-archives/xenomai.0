Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C527B241CB0
	for <xenomai@lists.linux.dev>; Thu,  3 Apr 2025 08:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743668731; cv=none; b=UjE9bwNk1/ikY1NAUjpKoDMMhyNYjJquCBj+WMOkj9m3ii4a7feg1dPwV3Uzj//d+Y0KQzP8Wo8+uYa7X4AcQ4CwrW6vE/fY1RNXs7dmWYDHzC0QdzqRxe9jjXQ6m9EwDBvISzlG5ff8NcW3yQKSCDeO9du9LWoWnNy7VZqTu2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743668731; c=relaxed/simple;
	bh=9dZqxe9xwR2FAGl3HqxQ7ICEkohWfLx5r3fIlF12lCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pMzZt3joqz4zQ2ez4MVObs35NzsCR5uFkPaOubcfxUWsW41YzZFKtJQDLPsGqy1BQEDOz7+ObDFJXPOKS6cSGASpCNKTELTefKk16kRPAD+drHMvNVdpxmBb1ZY4ZXQ1XlbmE9a54XWlWixYYjR2TIHR1SEwiheUvGS/fmX5HzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org; spf=pass smtp.mailfrom=xenomai.org; dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b=AC0UUbLq; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenomai.org header.i=@xenomai.org header.b="AC0UUbLq"
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2C3342FF4;
	Thu,  3 Apr 2025 08:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1743668720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sNFfwjPa16bzmqoC/fT+f8ynz2RL4SkW/1Sty3dCI9Y=;
	b=AC0UUbLqFjj3NZTg5GrpQogHYEHfnGw8NkvPqVT/hveJApGkp6slR9/Dfw2R94QITklb5v
	aaK0Iu99X7EOPssbd3wOc54zcl5bNy3ckVwyd4XhDcK43nXXXCWxd0MXw1vpZVd0KfElOi
	Pjf1RuJrSc2+iptQyqClzlSNYtJcqE2HfS4RLn412tSXnP6E56JYvrL91THjw8pFhLvVMC
	oGc/HFlJwbk7I278ms2Ix4FNfPotM+XYg8iD6J7ckV4dUP1lQFeFm+Ylqb91kcaRp3GBB1
	yV263/WNjPdGOmF99+kfCxiQYQRZ/bqYIrUnHN3mvmcqsIsAk7xBgzdxUFghcg==
From: Philippe Gerum <rpm@xenomai.org>
To: Markus =?utf-8?Q?Wei=C3=9F?= <mweiss@aradex.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
Subject: Re: RTAI -> Xenomai4
In-Reply-To: <PAVPR02MB9722E8F8B700A3E97C5C45D9A8AF2@PAVPR02MB9722.eurprd02.prod.outlook.com>
	("Markus =?utf-8?Q?Wei=C3=9F=22's?= message of "Wed, 2 Apr 2025 16:33:42
 +0000")
References: <PAVPR02MB9722E8F8B700A3E97C5C45D9A8AF2@PAVPR02MB9722.eurprd02.prod.outlook.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 03 Apr 2025 10:25:20 +0200
Message-ID: <87ldshhcsv.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: 0
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeektdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefrhhhilhhiphhpvgcuifgvrhhumhcuoehrphhmseigvghnohhmrghirdhorhhgqeenucggtffrrghtthgvrhhnpeelkeeuffeiffefkedvjedtteeludeigeffvedtvdejheevfeejiefhleeihedvveenucffohhmrghinhepvghvlhhprhhojhgvtghtrdhorhhgpdguvghngidruggvpdigvghnohhmrghirdhorhhgnecukfhppedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemudelsgemfegtugdtmeelkeelrgemhegtgegsmegsjehffhemsggrfhdphhgvlhhopehphihrohdpmhgrihhlfhhrohhmpehrphhmseigvghnohhmrghirdhorhhgpdhnsggprhgtphhtthhopedvpdhrtghpthhtohepgigvnhhomhgriheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehmfigvihhsshesrghrrgguvgigrdgtohhm
X-GND-Sasl: rpm@xenomai.org

Markus Wei=C3=9F <mweiss@aradex.com> writes:

> Hello Xenomai List,
>
> sorry if this is not the right place to ask these kind of questions. Mayb=
e somebody could point me in the right direction then.
>
> We are currently considering Xenomai4 as a replacement for an older RTAI =
real time project that we have to revive for a client.
> Some advisory comments to the following sections will be greatly apprecia=
ted.
>
> One of the major requirements is to switch from hard real time in kernel =
mode, we had a kernel module for that, to hard real time
> in user mode. We will now have a user mode process that shall do most of =
the work of the former kernel module. We did some
> prototyping on current RTAI versions for X86_64 and things looked nice wh=
en we found that our RTAI system can become unstable
> when put under stress even without our prototype software running at all =
on top of it. But only with RTAIs own test programs.
>
> I'm currently checking the Xenomai4 API and found that thread creation an=
d attaching to the EVL core is pretty similar to RTAI.
>
> Using the clock and timer API it should be possible to setup a one shot t=
imer which we will also need.
>
> We also used RTAIs shared memory feature for some kind of communication b=
etween kernel mode and user mode. It seems as if
> the File proxy API together with mmap() can be used to achieve what we ne=
ed.
>

Correct. Actually, you could even use plain regular posix shared memory
segments via shm_open() between processes in your case, I believe. The
mapping redirection implemented by the evl file proxy is helpful for
exporting private mappings obtained via memfd for instance, or hiding
the real source of a mapping (with some driver originally creating it
via its implementation of the ->mmap file operation) under a public
name.

> Additionally we used linux iotcl() to make calls to our kernel module to =
configure and run the application, do monitoring and what not.
>
> The prototype used RTAIs rt_rpcx(), rt_evdrpx(), rt_receivex(), rt_return=
x() and also RTAIs global heap for dynamically created
> named shared memory to implement an ioctl()-like communication between se=
veral processes and our kernel module replacement
> in user mode. Where needed communication between ioctl() threads in kerne=
l space where synchronized with the real time thread.
> So from a client perspective our ioctl() replacement does not need to com=
municate with the real time thread directly.
> This works nicely except for the missing re-entrancy of ioctl() calls int=
o a driver which could be solved by using threads at the right
> place. I looked at the Cross-buffer API but our ioctl() interface is quit=
e sophisticated and I am very unsure if the Cross-buffer APIs

Indeed, the cross-buffer API is not what you are looking for. This is
merely a data channel between real-time and non real-time peers. RTAI
would use FIFOs for this IIRC.

> intended use cases match the requirements we have in this area. Are there=
 parts in the Xenomai4 API which could be of help here?
> Maybe standard IPC mechanisms are better suited here, something like a lo=
cal socket interfaces. Though, I do not have much
> experience in the networking domain.
>
> Mit freundlichen Gr=C3=BC=C3=9Fen I With best regards I =E7=A5=9D=E5=A5=
=BD!
>
> Markus Wei=C3=9F
>
> Softwareentwicklung =E2=80=93 Software Development
>

My RTAI knowledge is a bit rusty these days, but I seem to remember that
Paolo implemented the rpc_* calls you mentioned in reminiscence of QNX's
RPC API, so unless I'm off base, this should be basically a
message-passing interface, with a synchronous mode for the sender to
wait for a reply.

There is no such interface in libevl/xenomai4, but it would be fairly
straightforward for you to implement one using its building blocks, I
believe. A common approach with xenomai4 is to leverage the
everything-is-a-file mantra (lib)evl implements, allowing multiple
processes to share evl resources/objects, such as IPCs, using the
EVL_CLONE_PUBLIC visibility attribute [1].

For the messaging system, you would need a way to organize some shared
memory as one or more message queues. For this, you could build on the
implementation of the Nikolaev ring available from libevl [2]. Combined
with a shared evl sema4 to get a blocking read side, the peer processes
could exchange datagrams living in shared memory. In fact, fixed size
envelopes referring to messages would be conveyed in those queues, the
actual message payload would live elsewhere in shared memory as well. If
that makes sense in your use case, you could even implement a zero-copy
messaging system with multicast/broadcast capabilities based on a simple
reference counting. All this could be done in userland, no additional
kernel support would be required.

Next is the issue of waiting for replies to messages. There is more than
one way to do this, depending on the application requirements. One of
them is based on the evl 'observable' element [4]. It goes like this,
based on the following set of assumptions:

- each (message) sender is a known thread attached to the evl core.
- each sender is visible from the receiver via the /dev/evl/ interface
  (i.e. has public visibility [1]). Another way would be to share every
  file descriptor obtained from evl_attach_thread() by receivers with
  the sender (using AF_UNIX socket control messages or the pidfd_getfd
  syscall) but that involves a bit more convoluted code to implement.
- each sender thread is given a global unique identity/index/number
  among all processes which belong to the application.
- each sender is also an observable element evl-wise, i.e. has
  EVL_CLONE_OBSERVABLE set in its attachment flags.

1. at init, the receiver opens the pseudo-device file under
   /dev/evl/threads/* for every possible sender to the message queues it
   monitors, to get a file descriptor referring to each of them. Each fd
   is mapped to the matching thread index/number in some table.

2. on TX, the sender queues an envelope referring to some payload to
   some message queue, with its global index/number stored in the
   envelope, posts the per-queue semaphore signaling a new message to
   the receiver thread, then waits for a reply via evl_read_observable()
   [5]. A Nikolaev ring can store those envelopes in FIFO order, this is
   a lock-free data structure.

3. on RX, the receiver waits for a new message to dequeue by waiting on
   the input semaphore associated to some queue it monitors. It then
   dequeues the next envelope from the ring, processes its message, and
   eventually posts a reply to the sender if needed. To do that, the
   receiver retrieves the (local) file descriptor mapped to the global
   thread index/number received in the envelope, for replying to the
   sender [6]. The sender will unblock from evl_read_observable() on
   receipt. The receiver can monitor multiple queues for input in
   parallel by using the evl_poll() [3] service, since semaphores are
   pollable in evl.

Since the real-time thread could poll for multiple sema4s indicating
incoming message presence from multiple queues at once [3], you may not
need any indirection/multiplexing via the former ioctl threads to feed
the real-time thread in this model actually.

Another - radically different - option would be to implement a so-called
out-of-band network protocol in a driver using the evl core/kernel
interface, which would be accessed via plain sockets from userland. IOW,
you would have PF_FOO implementing your specific message passing
protocol, creating sockets in the AF_OOB domain with protocol PF_FOO to
connect endpoints, then exchanging messages via these sockets using the
oob_sendmsg() and oob_recvmsg() calls.

Or, you could implement an ad hoc kernel driver also using the evl
kernel interface providing those messaging services, exporting a cdev
interface to applications based on (oob_)ioctl/read/write calls. This
said, going for a kernel-based option may be a bit extreme with respect
to the issue at hand, not to speak of the fact that copying memory
between kernel and userland to pass messages back and forth would be
less efficient than a zero-copy approach fully in userland.

HTH,

[1] https://evlproject.org/core/user-api/#multi-process-apps
[2] https://source.denx.de/Xenomai/xenomai4/libevl/-/blob/master/include/ev=
l/ring_ptr.h?ref_type=3Dheads
[3] https://v4.xenomai.org/core/user-api/semaphore/#sema4-poll-events
[4] https://v4.xenomai.org/core/user-api/observable/
[5] https://v4.xenomai.org/core/user-api/observable/index.html#evl_read_obs=
ervable
[6]
https://v4.xenomai.org/core/user-api/observable/index.html#evl_update_obser=
vable

--=20
Philippe.
