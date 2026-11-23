Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466039;
	b=4ExItaLHdbwH93zryfgbYQkP+9io9WiEGw5NWxXKvgKOiyQmVqMkp1/wzlOIdb3UUzHW
	 25cYQJZxVXV/lkA9w9AD72G49VtIOBNQaAbrG8tBS/X88Eg3UDpII+Azj6KUqC+SRTUk3
	 p5fryrSUZ4aZ3L8XbITSp6/r7VVgVZe1XH81KyJtPOrvxextWh4uR+X567brCfCChAKzT
	 KTdZNCWkKPj/iClD+ur2JOMVuqcUPzgRga49v5oteKX1arHy/qeaa0l/AfpyD8v/6YVLr
	 rUJ7YrLJhV6vGNCTwWpGjZazTt4MMVikaAIIIoel4pHAgYZJpQMP8Bvd5BaED5k9Clg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466039;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Subject:User-Agent:Date:
	 Message-ID:MIME-Version:Content-Type:X-GND-Sasl:X-GND-Score:
	 X-GND-Cause:X-GND-State;
	bh=ZWicu2wMnhtBfb2T79qO8P9V3a1hibnfCdJJHWMyjBk=;
	b=guk1uP4b5TlplTpHPQyO9O7e9IVj9k5AKpNTVRA0vxNbSanJDQBbgTUOG4onfe/ZRbmj
	 Ix/h5m8daGpWvLLpwkoDubEAjSxpYKSdm1Uf2Gmm8vbI4EDuNLQTLzlzQmAO36fYeR/v1
	 xGNrezIAV3PxmhRbE6oQmRKRjBjjl+Uzq/nb9D5YrC5NfeMrlE8vcy+6wzxUdzyLBvmhE
	 TXtbvNbHPcFTF7X5OG6lmXUbCHy1SiHYs9M0Ycwv0bhQvDFqby7Hw//O5rnmKvrgWKt8a
	 CTrI07hn1MJbYJsHTJdOfV0WtJCfBa5YbjC1HX7YbNg4mtenUSEJCXJ7Sqw3qPcMoUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xenomai.org;
	spf=pass smtp.mailfrom=xenomai.org;
	dkim=pass header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=ohvlp7hu;
	arc=none smtp.remote-ip=217.70.183.198
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10359606A31E
	for <xenomai@lists.linux.dev>; Mon, 23 Nov 2026 20:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10359606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xenomai.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xenomai.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xenomai.org header.i=@xenomai.org header.a=rsa-sha256 header.s=gm1 header.b=ohvlp7hu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 384A43E806
	for <xenomai@lists.linux.dev>; Mon, 23 Nov 2026 20:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1795466030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=ZWicu2wMnhtBfb2T79qO8P9V3a1hibnfCdJJHWMyjBk=;
	b=ohvlp7huoHyHQvXkc/GWDq69jcKzB/MAcqxaR/wv/BCq+CL34h/p32yJXo0gJ4Vqvfxi3B
	yVSNrlSlwWZujeNqW02ybbjHaHchQ63VUXBc66K/65+F3ZjMRla4E1AGfI3k0fLrqDZFSa
	AYLI5GiczfXBrgS2U7CcS/nqGr9/bmJHwGvGN8CokrmoEUTa+qUD26OtAC8g9yA1lqQRQh
	NhNGyewGJUPJMT/LbgWhZEODwxw3TaUuQOkWZ2aCaYh0qN6HDqVprAEA6xaWULvpBia9Lk
	1I1jOyMxBNLhTyzcvAg+7ig8ee6JFyvZA5MMO/85kz+RjJBqRlA9064/gUs3ow==
From: Philippe Gerum <rpm@xenomai.org>
To: "Xenomai" <xenomai@lists.linux.dev>,
Subject: [RFC] symbol wrapping for libcobalt
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Mon, 23 Nov 2026 21:33:49 +0100
Message-ID: <877bi3thhu.fsf@xenomai.org>
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Post: <mailto:xenomai@lists.linux.dev>
List-Help: <mailto:xenomai+help@lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
List-Owner: <mailto:xenomai+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: rpm@xenomai.org
X-GND-Score: 0
X-GND-Cause: dmFkZTGRGXYHpQbfTayHNz5/HRv1IZP/q+ceBccBD/yonegSTtxzzyJVJJmVXfWHHLCU+saAILV3Cj91gdActgj/Tvrzb3Yz8Wj2zxqdfm54bXX/MlMrcd81Fn9DvRzwbGNaJ3Pd8Pjs9iR8dnx/0vol83SjwmrMvSykkqTk9hXgvmgPKZi+287Poz/0USqlRvcwQSeFpeCSKN3gb0jTKT/e3ynbAf3gJMNIJNxT+WWGEnWdm7MZc/dnE0Oh0TNn44wUlQ2NkwWZlYy10hq4cXKR290oVty0+wxXFU4c9HHVCbZpUub8+I+qJ5P4bzId2YkzzUxkqW2D3SOEqjezryV8QrhJqezmF/o/o+ArldmzoE09+zQcwYw7rRawRrY6Um5lrcCpNFOOLwdoNmgXN6RpUnUoVSI/NxRWfe8Jn2p7w44dYxIE91LjJ+pxb8sTdamBRDNmZBOwkcRDt85dEu0dNqjcMaqVqLKNumIDUKhTFGpQOssT8eqLYKAYZx+fHQoOrKRMk66I0AMlqfzTiZ/1uXDu8bBh0I526zZgsBRlc43FwDelon0cefwWSr6SfRgg+WWSmjMPuAALdmkZanqAHjbbDqYqDQlVeyrsFusrDsGQwSBi4DVH9xiaykrRRCmKOHhcmY0WEDApR+RH0c45GZbUuS2I24YPbQWJWU+wQK/zqQ
X-GND-State: clean


Since its very inception, the POSIX API in xenomai3 enables automatic
wrapping of POSIX calls to their libcobalt counterpart using a linker
trick (-Wl,--wrap), so that applications can use the pristine POSIX
routine names to invoke Xenomai services. For instance, the following
snippet:

      ret = pthread_create(&tid, &attr, foo_routine, NULL);

would translate internally to:

      ret = __wrap_pthread_create(&tid, &attr, foo_routine, NULL);

which is a weak symbol alias to:

      ret = __cobalt_pthread_create(&tid, &attr, foo_routine, NULL);

The significant part of this wrapping is that we go from symbol_x in the
source code to __cobalt_symbol_x at link time, with libcobalt
implementing the latter.

Over the years, we noticed several issues with this scheme:

- because turning on wrapping only happens at link time, there is no
  indication whatsoever that some object file does expect wrapping to be
  applied by the linker when producing the executable. For instance,
  compiling such object file with build flags obtained from `xeno-config
  --cobalt --cflags` then linking with `xeno-config --posix --ldflags`
  would successfully create an executable, which would send all POSIX
  calls to the underlying *libc, which may or may not be the intent,
  depending on which xeno-config call was wrong. When building an
  application from multiple parts which are not necessarily maintained
  and built in the same team/organization which uses them (e.g. 3rd
  party libs), this issue is a source of headaches. At the very least,
  we need some guardrails to prevent this from going unnoticed.

- symbols in static archives are always wrapped although we may not want
  this. Likewise, symbols in shared libs are not wrapped although we may
  want the opposite. We have to resort to wrap-link.sh to accommodate
  complex library dependencies, which makes the process quite brittle
  since correctness here depends on the order of appearance of each
  object and dependency in the link args. A badly ordered link sequence
  successfully produces an executable, but the latter behaves
  incorrectly.

  For instance, say we have lib3dparty.a which is a mere in-band library
  that does not know about Xenomai, but is used by a Xenomai application
  for non-rt business by threads it starts using some mundane library
  service (e.g. libstdc++, via std::thread). Some foo() service
  lib3dparty.a provides serializes callers using a pthread_mutex_t lock.

  We then link our rt app using wrap-link.sh, with lib3dparty.a
  appearing before libcobalt because this seems to be the most natural
  order to most users at first glance. Which would give this under the
  hood:

        g++ -static -pthread -o app main.o -Wl,@cobalt.wrappers -lthirdparty -lcobalt -lpthread
        # stage 1: g++ -o app.tmp -r -nostdlib -static -pthread main.o -Wl,@cobalt.wrappers -lthirdparty
        # stage 2: g++ -o app app.tmp -static -pthread -lcobalt -lpthread

    Because lib3dparty.a comes before -lcobalt, the library goes into
    the --wrap stage, and its lock is set up as a Cobalt mutex by some
    init call in that library. Statically linking against libstdc++.a
    does not help, because this dependency is injected on stage 2 when
    wrapping is no more enabled in the link args. Mere dynamic linking
    against libstdc++.so would not help either, since symbols defined in
    a DSO escape wrapping entirely.

    And now the fireworks are set off: when the std::thread workers
    attempt to lock the mutex using the plain glibc service, they
    fail. At best by crashing, at worse with EPERM. Not everyone checks
    pthread_mutex_lock() return codes, right?  So now we have multiple
    workers stepping on each others toes when accessing a shared
    resource. Zero indication of this happening except maybe weird
    application output or crash. Perfect day.

  We could use C11 thrd_create() the same way to create workers and get
  into the exact same pitfalls without involving libstdc++ at all.
  
- a POSIX object such as a mutex, condvar or semaphore can be set up on
  one side and used on another, and we have no way to detect it; we
  usually receive obscure errors at runtime, in the best case the
  application crashes. Things get uglier with C++ when inline header
  code gets wrapped and out-of-line parts are not.

- the y2038 issue makes things worse: v3 needs to keep yet another
  hand-written list of wrappers for this,
  i.e. cobalt-glibc-time64.wrappers so that time64 calls in 32bit builds
  end up at the right place. The day the underlying *libc decides to
  redirect other symbols to whatever build-specific counterpart (not
  exclusively time64), we can only notice this after a runtime
  breakage.

  Also, since the glibc headers know nothing about the __real_* symbols,
  they won't redirect them to the proper 64bit implementation but keep
  branching to their legacy 32bit variant, unless they are declared with
  COBALT_DECL_TIME64. It looks like v3 may have at least fcntl, and all
  the socket *msg calls escaping redirection right now. There is another
  example, which is harmless this time fortunately, with wrapping
  pthread_yield(). A recent glibc installs a redirection for this
  routine:

  extern int __REDIRECT_NTH (pthread_yield, (void), sched_yield)

  This means that __cobalt_pthread_yield() is not called when such
  redirect is in place. The only reason that keeps it working is that
  pthread_yield() is redirected to sched_yield(), and we do intercept
  sched_yield() anyway.

- when link-time optimization is involved, any references the
  intermediate representation may add escapes wrapping. Once again, this
  is 100% opaque to us, we have no idea what happens under the hood.

- there is a cost to implicit wrapping for I/O calls such as open(),
  read(), write(), ioctl() and friends: we have to try the Xenomai side
  first, then fallback to the regular *libc side if that fails. Granted,
  this is only a problem for in-band code, but still: although
  SCHED_WEAK threads are running in-band by convention and oob by
  exception, they should not have to pay twice the price for each
  wrapped I/O system call.

- on a more general note, we times and often recommend that a clear
  real-time vs non real-time split be enforced in any application which
  runs in a dual kernel environment (I'd argue that this should be a
  rule of thumb for all rt designs, even those served by native
  preemption as well). Doing so is basic sanity, so that
  responsibilities and constraints are obvious from the get go when
  reviewing the implementation, and we don't create situations in which
  rt-unsafe code is called from a time-critical path too easily. In that
  sense, symbol wrapping blurs the boundaries between rt and non-rt,
  which contradicts this recommendation.

I believe that the last point carries a lot of weight in favor of
explicit annotation of libcobalt calls in the application code
(i.e. __COBALT(), __RT(), __EVL()). However, I'm not recommending that
link-wrapping is dropped from v4, especially since we need an easy
migration path from v3, but at the very least v4 should prevent misuses,
help in figuring out where problems lie with symbol wrapping. What I'd
like to see in v4:

- a way to somehow mark the object files that did include the libcobalt
  headers, so that linking them without -Wl,--wrap fails.

- conversely, a way to mark the object files that did _not_ include the
  libcobalt headers but the regular glibc ones, so that linking them
  _with_ -Wl,--wrap fails when the wrap list contains inconsistently
  used symbols.

This metadata could be used by a checker tool that would answer the
following question: "where the heck each call to libcobalt services
actually goes for this executable"? It could also be used to generate
the wrap list on the fly for symbols which carry the 'wrapped' marker
by inspecting the object list.

Icing on the cake, it should even be possible to use this information to
implement auto-annotation of source code by reading a wrapped binary,
i.e. patching in the __COBALT() annotations mechanically, for those who
want an easy way to depart from symbol wrapping for an existing
application.

Thoughts welcome.

-- 
Philippe.
