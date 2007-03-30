Message-ID: <460CB1BD.60602@domain.hid>
Date: Fri, 30 Mar 2007 08:44:13 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <460C60E9.6010307@domain.hid>
In-Reply-To: <460C60E9.6010307@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
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
> Hi Wolfgang,
> 
> it's late, so I may have misread somecode, but don't you "update" the
> iovec descriptors a user passes on send/recvmsg on return (namely
> iovec_len)? I received some complaints about this /wrt to in-kernel CAN
> stack usage.

It's done here:

http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rtcan_raw.c?v=SVN-trunk#881
http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rtcan_raw.c?v=SVN-trunk#734

I may have missed something. What are the real complaints? Is there a 
test program?

> I always considered the same well-know behaviour of RTnet a bug, but now
> I found your code is doing this systematically, also for user space
> callers. Is this behaviour undefined or even required according POSIX or
> whatever?

I don't know, it's Sebastian's Kode.

Wolfgang.


