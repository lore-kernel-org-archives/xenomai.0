From: Sebastian Smolorz <ssm@domain.hid>
Date: Fri, 30 Mar 2007 15:06:47 +0200
References: <460C60E9.6010307@domain.hid> <E1HXG3e-0006Jz-Rb@domain.hid>
	<460D0246.5030108@domain.hid>
In-Reply-To: <460D0246.5030108@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HXGoZ-000163-Vn@domain.hid>
Subject: [Xenomai-core] Re: iovec overwriting by CAN stack
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Sebastian Smolorz wrote:
> > Jan Kiszka wrote:
> >> Wolfgang Grandegger wrote:
> >>> Jan Kiszka wrote:
> >>>> Hi Wolfgang,
> >>>>
> >>>> it's late, so I may have misread somecode, but don't you "update" the
> >>>> iovec descriptors a user passes on send/recvmsg on return (namely
> >>>> iovec_len)? I received some complaints about this /wrt to in-kernel
> >>>> CAN stack usage.
> >>>
> >>> It's done here:
> >>>
> >>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rtca
> >>>n_ raw.c?v=SVN-trunk#881
> >>>
> >>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rtca
> >>>n_ raw.c?v=SVN-trunk#734
> >>>
> >>>
> >>> I may have missed something. What are the real complaints? Is there a
> >>> test program?
> >>
> >> Not yet (will commit the related patch to our RACK likely later today).
> >> It's simply sending frames while re-using the msg+iovec structs in a
> >> loop.
> >>
> >>>> I always considered the same well-know behaviour of RTnet a bug, but
> >>>> now I found your code is doing this systematically, also for user
> >>>> space callers. Is this behaviour undefined or even required according
> >>>> POSIX or whatever?
> >>>
> >>> I don't know, it's Sebastian's Kode.
> >>
> >> Hmm, hope he will not say that he imitated RTnet...
> >
> > Rather an imitation of the Linux kernel's behaviour. The memcpy_toiovec()
> > and memcpy_fromiovec() functions [1] also modify the original iovec.
> >
> >
> > [1] http://lxr.free-electrons.com/source/net/core/iovec.c
>
> But that's the kernel's private (and user-safe) copy. I failed to find
> it writing that back to user space.

Hm. Ad hoc, I don't recall why the userspace's iovec is also updated. Perhaps 
my intention was to make the use of rtcan_raw_sendmsg consistent for kernel 
and userspace RT-Tasks so that both can rely on finding modified iovecs after 
calling sendmsg/recvmsg. But I'm not absolutely sure if there isn't a better 
explanation for this. I will try to find the reason in my backup memory. ;-)

-- 
Sebastian

