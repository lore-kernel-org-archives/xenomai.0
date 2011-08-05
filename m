From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20110805133006.GA2945@domain.hid>
References: <20110805133006.GA2945@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 05 Aug 2011 17:39:50 +0200
Message-ID: <1312558790.2324.42.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Using plain old POSIX shm_open with real time
 threads
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Richard Cochran <richardcochran@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2011-08-05 at 15:30 +0200, Richard Cochran wrote:
> Dear xenomai people,
> 
> I would like to have a shared ram fifo between a normal Linux program
> and a xenomai program that uses the POSIX skin. Can I simply use
> __raw_shm_open and __raw_mmap in the xenomai thread, or would there be
> some penalty or bad side affect on the RT thread?
> 
> I see that the documented way for RT/non-RT IPC is the message
> pipe. Perhaps you could comment on the pros/cons of using it, compared
> with my shared memory idea.

It really boils down to whether your use case is compatible with copying
data between peers (amount, frequency etc.) to gain convenient
synchronization and safe access mechanisms, which you would have to
implement with shared memory otherwise.

The recommended RT IPCs since Xenomai 2.5 are available from the
RTDM-based RTIPC driver, which currently provides three different IPCs
under the same umbrella.

This driver exposes a socket interface to userland, and also benefits
from the intra-kernel API of RTDM (i.e. you can send/receive data from
another driver). For more info, examples/rtdm/profiles/ipc and the
doxygen doc are also available.

> 
> Thanks,
> 
> Richard
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



