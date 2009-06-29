Message-ID: <4A48E37C.6090106@domain.hid>
Date: Mon, 29 Jun 2009 17:53:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A48D9A1.40509@domain.hid> <1246289947.4040.20.camel@domain.hid>
In-Reply-To: <1246289947.4040.20.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] DYNAMIC_FTRACE vs. I-pipe tracer
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

Philippe Gerum wrote:
> On Mon, 2009-06-29 at 17:11 +0200, Jan Kiszka wrote:
>> Hi Philippe,
>>
>> I saw this for 2.6.30, but it obviously also made it into 2.6.29:
>>
>> http://git.denx.de/?p=ipipe-2.6.git;a=commitdiff;h=d302f7638b9b52ea90e3c042edd940449cedb7a1
>>
>> What precise problem does it try to solve? Is it a 2.6.30-only problem?
>> The point is that, last time I checked, the dynamic ftrace approach was
>> by far not I-pipe compatible. So I suspect we rather need a fix for the
>> core issue, but keep DYNAMIC_FTRACE off.
> 
> There are compatible for basic usage at least, but the way the tracer
> forced activation of the ftrace layer in 2.6.29+ was wrong in the first
> place, and this basically wrecked the ppc64 boot sequence.

That was a different issue, unrelated to this one.

> But now that
> it is right (at least non-x86s are happy with this now), we need
> DYNAMIC_FTRACE to enable the tracepoints; otherwise we would only get a
> few xenomai symbols in the trace log (seen on x86*/ppc*). As it is, we
> do get meaningful traces via /proc/ipipe/trace, but I would not assume
> that we could not break the kernel when fiddling with ftrace's debugfs
> interface.

Look at x86's entry_64.S: Enabling DYNAMIC_FTRACE cannot be correct as
it disables direct invocation of a callback handler in favor of runtime
patching (around ftrace_stub). And runtime patching goes through int3
IIRC. That will break sooner or later.

ppc64 looks similar on first sight.

> 
> Quite frankly, moving the tracer over ftrace brought quite a lot of
> issues to the non-x86 ports unfortunately (including significant
> overhead issues on ppc64); the fact that ftrace is a moving target did
> not help either. This integration probably requires more work.

Yes, that's unfortunate. It was actually aiming at reducing the
maintenance, reducing it to the no-arch part. I'll try to find some time
to look into the details again. Maybe we need to rethink the approach,
maybe patch ftrace instead (hopefully in the generic part).

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

