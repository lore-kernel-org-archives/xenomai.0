Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A813E8AB
	for <xenomai@lists.linux.dev>; Mon,  8 Apr 2024 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592416; cv=none; b=JFROQ3zCZYjgGJECI3NrTPFrDc6NoL5wN46dt3mOzetmPT7dEVH6JpR/axaiczxNU4FtGEZTus0bYKlxW7S8SnHEw8j2jjJcedM17ch657im+eOR3wdLNb/BwF16S+YKAqbbF4Bp1oiQdIBArFKrKdwU2zmtSTQvGApiUeFbB/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592416; c=relaxed/simple;
	bh=sOyqIQ5A/okG/tzoSzl8JBxcsnQkuNiL3tZ8R3JXIJM=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=YIcXgLoVbYQ/dNLCQHaz0Y/LkEW/yraIBiWQ/fcBhoo+WaY/PiemmeARP97z+/oGK+2DsFExkfo14emGfuS1rLcAUDidoe1x7Keefti6XKLq61WGqORR2xhhcAx3f4ncJyIN3sjiGN1ie/JaHQ5nECaqCR3kmDK2Gr/4bkks+l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=Jb513ojR; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="Jb513ojR"
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024040815563372954ec447b2fc0883
        for <xenomai@lists.linux.dev>;
        Mon, 08 Apr 2024 17:56:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Cc;
 bh=2BdU9psYnsqUjNDTVkfS13bSQ6cF5f8bwWzjHmddtYY=;
 b=Jb513ojR3nZzkAapNpim2+HG1ELcvm1xW8ey0/CMwfch34HDYfWAgZyzdl2pstTGBQ1eZt
 OB2M3WYTNR7K/shklYTX7YQE5Oa/Dt/PZ+wvx/56I6khjvvvYWm34DvDmuYUKjgcgCFv0i7L
 oJ5UCEVMTkSa96Ffno2Z1bG/B6hOk=;
Message-ID: <97d031173f62c694001f166abbd756d4b1cb6390.camel@siemens.com>
Subject: RFC: Improve tooling support, move away from function wrapping
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: xenomai@lists.linux.dev
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Clara Kowalsky
	 <clara.kowalsky@siemens.com>
Date: Mon, 08 Apr 2024 17:56:32 +0200
Autocrypt: =?US-ASCII?Q?addr=3Dflorian.bezdeka@siemen?=
 =?US-ASCII?Q?s.com;_prefer-encrypt=3Dmutual?=
 =?US-ASCII?Q?;_keydata=3DmQENBFwsf8QBCAC2f4AQWu92LZC4bKyUYRxWIpWqGz790s?=
 =?US-ASCII?Q?pcYkXO7M8kfea4iC8qMxv2hT4HT0LTncRP6WiovVN2PeoOBfN5BSa5z?=
 =?US-ASCII?Q?LIrZGVXh7KmbdKhwhVU+ynoTq9G5uaO2Kos7Vv7nNCuatIq8tSNILuoB?=
 =?US-ASCII?Q?DFTAZnJW3y1V7YOwhDCPl5gbLSYqUY3OE0yksbtCcVI5istT4ED6mjQ?=
 =?US-ASCII?Q?9W+3uH1LrgFeEF0oxTjrEPxO5ZYATz0f/TYC8WiM0sMrV+n0eMDntlzA?=
 =?US-ASCII?Q?63D6lcRi5mNp2jPsJkq3tbWqyCrAe1sKPVJB44ekFwCk0kDIuhR13Q3R?=
 =?US-ASCII?Q?HE4Or/9sznhMUQjYueWXvTZfzH/VsQJHABEBAAG0LUZsb3JpYW4gQmV6?=
 =?US-ASCII?Q?ZGVrYSA8Zmxvcmlhbi5iZXpkZWthQHNpZW1lbnMuY29tPokBVAQTAQg?=
 =?US-ASCII?Q?APhYhBAzL4P3jiTHdthsq4cj0O1fnOEBVBQJcLH/FAhsDBQkB4TOABQs?=
 =?US-ASCII?Q?JCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEMj0O1fnOEBVc6YIAJ8oO4x?=
 =?US-ASCII?Q?TjOCpjxaS8XQE6VW50HE9I6ShbQVWUEGhF4qzJaACTQDjdg/aio7qNRa?=
 =?US-ASCII?Q?mnAy83Hy9sAxKVhXs+1R1fstN+JO8zgD3tJspucUkCiXlYu+Qcv2d6C?=
 =?US-ASCII?Q?ostv+h4nv8fkSoeLfsQu3GJt6W0RN7t+8H/9fUMXyuB8GWo4bhaZcti6?=
 =?US-ASCII?Q?78CotGLs6UGZpYEGiAMto8+9zVO/tdY1BkREM6bCVeQ9FnnpTRQy/tU5?=
 =?US-ASCII?Q?xemMWJI64UUP92TUIbQ3TZKAz4iG/Mle+YjiHBGrJM7TxjE3sDg5J2Fa?=
 =?US-ASCII?Q?HX4wmZPKGdB6wANKupf6HMMt2y7gduVmMKzgb8PDMLPZwWBSvjELQqz?=
 =?US-ASCII?Q?hiZAQ0EYLSqZwEIAIR4HMTQC4F4YxatIl6MIDY03zD4M3ZQpgyQ6QFL9?=
 =?US-ASCII?Q?Dq0I+PGc7A6z5rsGl76+D8pDFSN2BBJiLLlQadxKc3ZyTTlRp4bc=09bf?=
 =?US-ASCII?Q?FZRmsAXwVfLtBauXxGo9pkyhk8Vcjb2EJm6XR8PH99buGOXlFfTLsmeA?=
 =?US-ASCII?Q?ji/F4jU3qlUnwZMBvHZwRSFqOGdwKPMvW3FppfmREQ0o4xJ4b/bxGXx?=
 =?US-ASCII?Q?ko21uyR/S5rEJx6X8Ukw95h3JinXHx/g2cjbKHrWBDKoqtX9IZCamDny?=
 =?US-ASCII?Q?R+sfLWQbOKOrLNYLwLAQwOTVlZWTgue10G1q6Zi0r8RQ2T1Uy+ZLYagv?=
 =?US-ASCII?Q?Cbzp/lT7p3mv3ba68llX896c0AEQEAAbQ/QmV6ZGVrYSwgRmxvcmlhbj?=
 =?US-ASCII?Q?sgQmV6ZGVrYSBGbG9yaWFuIDxmbG9yaWFuLmJlemRla2FAc2llbWVuc?=
 =?US-ASCII?Q?y5jb20+iQEcBBABCAAGBQJgtKpnAAoJEEoHyE9rG1dPpJYH+gPnqpu7h?=
 =?US-ASCII?Q?4fsWOxco38e74MsazoUdfndTYP5tgaYTVE51ZhOZBl+4jYaywsmmFm9g?=
 =?US-ASCII?Q?6N4Tw3GiMEDB4YU1X7gQZ60fDKpYL5SnCu5qZirJ4RCV4LDA0789ir+6?=
 =?US-ASCII?Q?8/zfwXBTV5QoMH0+MkXB4BL+Km3f7X/GdN5oRoItAyKDBcEfGJo6afT?=
 =?US-ASCII?Q?PtcUdI9n7ExCSfJwb0SBvvkvUsdNppFDGOOHSioINbEHBs2VUvE43toM?=
 =?US-ASCII?Q?4mPLfhFIAtDcn5Byt80/kotU8v3Iyf86NYCa+0h77xTsKHcCUqe8Rvow?=
 =?US-ASCII?Q?bCIbig9GGbbd54TasfqQQOiAkn/WeGl33+UIVX1Q8zo7eyMJHzLJQ3I=3D?=
Content-Type: multipart/mixed; boundary="=-8xTbI4y6PyKT80GYEJsS"
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

--=-8xTbI4y6PyKT80GYEJsS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

as mentioned in one of the community talks I'm currently looking into
increasing the tooling support of Xenomai. We had that on our internal
wish list for some time now. It's time to look at that.

The initial feature request was talking about valgrind support, so I
started with that but stopped further investigations because a lot of
code annotations were necessary. Main pain point was that all memory
writes done on the kernel side were not properly detected out of the
box and had to be annotated manually to avoid "invalid read" reports.

In addition I did not like that we would have to build two versions of
each library. One with the annotations inside - useful for debugging -
and the prod version, without annotations because of possible side
effects or performance issues. (I did never actually measure it...)

So I moved on and looked into using the gcc sanitizers.

First major pain point: libasan (ther library behind the gcc address
sanitizer) intercepts posix services/functions. That does not work in
combination with the function wrapping done by libcobalt.

To make that work we would have to walk away from function wrapping and
implement an interception mechanism that works similar to the libasan
implementation. That works - at least technically inside as small test
application.

Function wrapping (in Xenomai) "defines" the following three
symbols/functions for each function that is wrapped. I'm using
pthread_create() as example here:

  __cobalt_pthread_create(): The RT/Xenomai implementation
  __real_pthread_create():   The libc implementation
  __wrap_pthread_create():   A weak alias to __cobalt_pthread_create()
                             Can be overwritten by the application.
                             Usage of __RT() and __STD() allows to call
                             the cobalt or libc implementation.

For backward compatibility we must keep the interface, especially the=20
possibility to overwrite __wrap_*().=20

The demo library/application (see attachment) shows that moving a way
from function wrapping allows to keep this "API" and allow usage of
libasan / address sanitizer. Some details:

- We could move from function wrapping to our own "interception"=20
  mechanism. Highly inspired by the libasan implementation.

- We could change the COBALT_IMPL() macro to implement such an
  mechanism.

- Overwriting of __wrap_() still works

- For each function we want to intercept we do the following:
  (see library.c)
 =20
  - Declare (not define!) a weak symbol
  - Introduce a trampoline function (__cobalt_t_*) that calls (jmp)
    the __wrap_*(), which is itself a weak alias for the __cobalt_*()
    implementation

With that, most things work already. There is one missing piece: The
__STD() macro would no longer work, as there is no __real_*() symbol
anymore.

To make that work, we have to search for the original symbol using
dlsym() in the library init phase, and remember the address of the
symbol / function.

In case libasan is active, searching for the posix service (like
pthread_create) delivers the address of the interceptor. Nice.



Before I start the real integration into Xenomai, what do you think?
Any feedback is highly appreciated.



Topics I will have to look into:

- Performance. I have some bad feelings regarding the trampoline
  function. Maybe there is a better way in libasan already.

- I'm looking for a way to get the init stuff (__cobalt_init() of
  the attached demo) automated.

- Architecture support. I don't like the ASM part of the current
  demo. But I fear there is no other way. At least arm64 and arm
  should not be a problem. Some bad feelings about i386...

- Clarification needed: Is there really an application out there
  that overwrote one of the services by implementing __wrap_*()?
  Maybe we can remove that feature?

- Other sanitizers: I only played around with -fsanitize=3Daddress
  so far.

Feedback / ideas highly appreciated.

Thanks for reading!

Florian



PS:=C2=A0
Some notes to the attachment:

If you have libasan installed you should be able to build the
application by typing "make" into your terminal.

Example output of the application follows. The memory leaks introduced
by the demo application are detected. The leaks introduced by the
library (would be libcobalt later) are not detected. Seems there is
some magic in libasan that affects some specific interceptors only.
pthread_create() is obviously one of them.


$ LD_LIBRARY_PATH=3Dout ./out/xeno-app
constructur called!
got address 0x7f456f2a82c0 for pthread_create
exe: wrapper called!
exe: now trying to call the __cobalt version
cobalt: pthread_create was called
exe: __cobalt version failed. Calling the __real version...
thread: done

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D3735623=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 4096 byte(s) in 1 object(s) allocated from:
    #0 0x7f456f4b89cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x7f456fb3d16a in leak library.c:48
    #2 0x55efa90e0222 in thread_entry exe.c:23
    #3 0x7f456f2a8133 in start_thread nptl/pthread_create.c:442

Direct leak of 4096 byte(s) in 1 object(s) allocated from:
    #0 0x7f456f4b89cf in __interceptor_malloc ../../../../src/libsanitizer/=
asan/asan_malloc_linux.cpp:69
    #1 0x55efa90e01fe in thread_entry exe.c:18
    #2 0x7f456f2a8133 in start_thread nptl/pthread_create.c:442

SUMMARY: AddressSanitizer: 8192 byte(s) leaked in 2 allocation(s).



--=-8xTbI4y6PyKT80GYEJsS
Content-Type: application/x-compressed-tar; name="demo.tar.gz"
Content-Disposition: attachment; filename="demo.tar.gz"
Content-Transfer-Encoding: base64

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
HdZhHdaft/4Fih4PAQAoAAA=

--=-8xTbI4y6PyKT80GYEJsS--
