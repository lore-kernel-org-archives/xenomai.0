From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200702212030.41554.paul_c@domain.hid>
References: <200702212030.41554.paul_c@domain.hid>
Content-Type: text/plain
Date: Thu, 22 Feb 2007 01:42:01 +0100
Message-Id: <1172104922.3551.122.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: [Xenomai-core] Re: [Adeos-main] x86_64 ipipe on 2.6.19
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: adeos-main <adeos-main@gna.org>, xenomai@xenomai.org

On Wed, 2007-02-21 at 20:30 +0000, Paul wrote:
> Hi Philippe
> 
>  After compiling the current git sources for x86_64 on 2.6.19 and failing 
> miserably to boot under qemu, I finally tried on a live box - An AMD64 X2.

I can also boot it under qemu (0.8.2) here, actually this is how I wrote
the basic Adeos support before switching to real hw. Could you send me
some boot log and .config? Maybe a bug is sleeping that triggers with
your configuration and that doesn't with mine.

> This booted fine and appeared to be stable enough for the short time I had it 
> running, so the next stage would be to run some tests with Xenomai..
> 

The current status (as of today's SVN head) for Xenomai/x86_64 is:
- user-space tasking is fragile and barely usable yet.
- kernel-space tasking is ok.
- kernel level interrupt handling though the pipeline is ok.
- switchtest is broken, with funky results regarding the FPU management
in real-time mode.
- I-pipe-wise, there also remains a random bug to fix in the syscall
interception which affects non real-time stuff when the box undergoes
real-time operations.
- the I-pipe tracer works nicely enough to have saved my day a couple of
times already when hunting double fault bugs, at least when the machine
recovered from such bugs by being able to kill the offending Linux task
and gave me access to the frozen trace log. (Memo: tell Jan about his
recently adopted status of Benefactor of the Hacking Humanity for having
written this piece of code).

>  Just wondering if it would make more sense to switch to 2.6.20 or continue 
> with the current branch.
> 

I'll probably stick to 2.6.19 because the effort to make this running
over 2.6.20, waiting for 2.6.21 to be out shortly after, would be
overkill, particularly in the context of stabilizing the initial
I-pipe/x86_64 port. By the time the latter is ready for production use,
2.6.21 will soon be available I guess, and the effort to port from
2.6.20 to 2.6.21 would likely be much greater than upgrading from 2.6.19
to 2.6.20 anyway, given the number and the nature of the changed
announced to the LKML.

> 
> Regards, Paul.
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main
-- 
Philippe.



