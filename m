Date: Fri, 5 Aug 2011 15:30:06 +0200
From: Richard Cochran <richardcochran@domain.hid>
Message-ID: <20110805133006.GA2945@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-help] Using plain old POSIX shm_open with real time threads
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Dear xenomai people,

I would like to have a shared ram fifo between a normal Linux program
and a xenomai program that uses the POSIX skin. Can I simply use
__raw_shm_open and __raw_mmap in the xenomai thread, or would there be
some penalty or bad side affect on the RT thread?

I see that the documented way for RT/non-RT IPC is the message
pipe. Perhaps you could comment on the pros/cons of using it, compared
with my shared memory idea.

Thanks,

Richard

