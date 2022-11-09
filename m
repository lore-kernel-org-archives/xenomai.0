Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C93EC08
	for <xenomai@lists.linux.dev>; Wed,  9 Nov 2022 18:21:32 +0000 (UTC)
Received: (Authenticated sender: philippe.gerum@sourcetrek.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 8C2F2240003;
	Wed,  9 Nov 2022 18:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1668018090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5KHvjxX09LTjY+QvnLPP6/Kcrb8SfcIv4gKbsKAd1c=;
	b=DO4biEHftkzr8BjfIavx2042VhihECMXiwTqT4bNEFmd+I1c/6Cc2NKIXgdTLQxKo7Dlhr
	G/glrsVedXblA9WKMcqmY7f+Gk2IyhsoyNF4cMEBNDE4YiwHdxHLapu6D8oJk3yd57RQO2
	WmE+4uQFN9UJX74yE4kDMMhwOfKsApf/vEzdsqTZes+4U+5aGNjYdHL+55ynEzA1k+buRx
	ih4atLxi6vWuk7cmqrq42P3K04JNkmwziggMsF5J6L78pR6CccGfOBf5pzUjbC/HRvtcsk
	H5/paone/Z50LTsvFT9y3NcUK7Zo5pGEYLucWor49BvBco1Uv9ogKgFA6Fe1IA==
References: <PH1P110MB1050AD875FCD924D827A0A54E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB10508DD9688B7D0E82AB30CDE23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
 <PH1P110MB1050307D7FC58A2B99A40094E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.6.6; emacs 28.1
From: Philippe Gerum <rpm@xenomai.org>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Bryan Butler
 <Bryan.Butler@kratosdefense.com>, Shawn McManus
 <shawn.mcmanus@kratosdefense.com>
Subject: Re: EVL Memory
Date: Wed, 09 Nov 2022 18:20:40 +0100
In-reply-to: <PH1P110MB1050307D7FC58A2B99A40094E23E9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <877d04dm52.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> Hello,
>
>=20=20
>
> We have been running into some memory issues with our realtime EVL applic=
ation. Recently, we are seeing a core dump write immediately on
> startup, and when running in the debugger,  the call stack just doesn=E2=
=80=99t make any sense =E2=80=93 it almost seems random. I have the latest =
EVL
> kernel built with all the EVL debug on including the EVL_DEBUG_MEM option=
, and I also turned on KASAN. I see no output at all from the
> kernel when this core dump happens except for a couple basic lines:
>
>=20=20
>
> EVL: RxMain switching in-band [pid=3D4327, excpt=3D14, user_pc=3D0x0]
>
> RxMain[4327]: segfault at 0 ip 0000000000000000 sp 00007f7ab5305468 error=
 14 in realtime_sfhm[400000+161000]
>
> Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.
>
>=20=20
>
> I wouldn=E2=80=99t say those lines are very helpful. I know that exceptio=
n 14 on x86 is a page fault and that a pc value of 0 does not seem good
> (memory corruption?).=20
>

Yes, this very much looks like a stack overwrite, since you are running
x86, return addresses may be popped from the stack, so this could lead
to that funky user_pc=3D0x0 if the IP register is reloaded with a random
value.

>=20=20
>
> I wanted to get your opinion on our overall memory setup and see if there=
 are obvious issues or if you had any recommendations of things to
> try.

Checking and controlling the thread stack consumption comes to mind,
looking for unconstrained writes to stack-based variables too.

> So we set up 1 EVL heap on startup of the application, and this heap is u=
sed for all dynamic allocations throughout the entire app as we
> also overrode global new/delete to use the EVL heap rather than malloc/fr=
ee. The reason we overrode global new/delete is that we have a lot
> of STL objects as well as third party libraries that we are using in this=
 app and it would become a very long and challenging process to actually
> go through and modify all those to use custom allocators.

Hopefully the STL won't use hidden synchronization via *libc mutexes,
otherwise this would be an issue. Re-routing new()/delete() away from
malloc()/free() to a dedicated allocator is common practice.

> So, in main(), we spawn a =E2=80=9CMain=E2=80=9D EVL thread. All other th=
reads are spawned from
> this parent EVL thread. When the EVL Main thread starts, it sets a static=
 flag that enables using the evl heap in the global news/deletes, and
> every library and process for the realtime app is created and started. We=
 also prefault the EVL heap after it is initialized/created in order to try
> to avoid page faults while running the realtime loop. However, we still s=
ee occasional page faults in our realtime EVL threads while running our
> main realtime loop. I don=E2=80=99t understand how there could be a page =
fault if the EVL heap is large enough (verified) and prefaulted.
>
>=20=20
>
> Now back to the issue mentioned at the beginning of this email =E2=80=93 =
we are unsure at this time if the page fault error seen there is cause, res=
ult,
> or primary error causing these core dumps.

This page fault is a symptom, not the issue, the kernel detects that the
app has done something weird, like jumping to 0x0. If the stack is
wrecked, then other registers than IP might be trashed on reload,
leading to other forms of bad accesses. But they would all originate
from the same stack corruption issue.

> Typically when I see the occasional page faults while running other EVL t=
hreads in the app, I do
> not see core dumps =E2=80=93 just the log from the kernel. The only reaso=
n why I figured I would at least run this past you was that I did not see a=
ny
> core dumps when disabling the flag in the global new/delete and just usin=
g malloc/free (of course I saw some in band switches, but that was
> it).

You may want to make sure to set ulimit to allow unlimited core dumps
for the process.

>
>=20=20
>
> The issue of occasional page faults, handling dynamic memory allocation (=
using global new/delete), and now these possible memory
> corruption seg faults is becoming a larger concern for us. We would like =
to make sure that we are understanding how to use memory in an
> EVL application properly, and we would be interested to know if there are=
 any recommended ways of tracking these down with an EVL
> application. I have tried to build/run with the gcc address sanitizer, bu=
t I was seeing issues attaching EVL threads when this was enabled. I
> have also tried running valgrind, but that has produced nothing useful. A=
nd, of course, I have run in gdb and the stack traces are not helpful.
> At this point, any guidance, thoughts, and/or recommendations would be gr=
eatly appreciated. I added some more clear/specific questions at
> the bottom.
>

An EVL application can run over valgrind, you may want to check if that
helps.

>=20=20
>
> A few specific questions:
>
> 1 Is this a reasonable model to use for an EVL application, or do you exp=
ect the model to revolve more around static allocation?
>

No requirement for static allocation if that fits the bill.

> 2 Are you aware of people using EVL overriding the global new/delete to u=
se the EVL heap?
>

Yes.

> 3 Do you have any tools for debugging the EVL heap or have you adapted an=
y existing tools (such as valgrind) to debug the EVL heap?
>

As mentioned earlier, valgrind works out of the box for EVL apps.

> 4 Is there any known way of protecting against a stack overflow?
>

EVL threads are merely plain threads on real-time stero=C3=AFds, so the
read-only canary area / red zone the *libc sets in order to detect
overflows is there too. So maybe the stack is not overflowing, but
trashed by some buffer overflow on some automatic variable.

> 5 PC value of 0 is never valid and we have no evidence that we have an un=
initialized pointer in our C++ code. Is there anyway to use info from
>  EVL to help track down this issue?
>

No, it's the worst case, we loose track due to the bad jump, and there
is no link register to locate the caller on this architecture.

> 6 We are allocating 2GB of EVL Heap memory and pre-faulting all of it on =
startup. We also use pthread_attr_setstacksize to pre-allocate the
>  stack for each EVL thread we have. EVL still says that we get rare page =
faults. How is this possible? Are we missing something? (I have
>  attached our heap pre-faulting logic)
>

To answer this, we'd need to find out which kind of PF is that, whether
this is a PTE miss and which code actually triggers it. This would be a
Dovetail/x86 issue if any, EVL leaves all the mm stuff to the in-band
kernel.

--=20
Philippe.
