MIME-Version: 1.0
Date: Wed, 16 Oct 2013 18:06:01 +0200
Message-ID: <CAEk6gTAj51aYJiCLVx+4-O_tnxfyyPvtLZO-hFVZvS+WjBpDtg@mail.gmail.com>
From: Drasko DRASKOVIC <drasko.draskovic@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Hardware I/O from Userspace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,
I would like to access to various peripheral and CPU regs of my FPGA
from userspace.

Is mmap of /dev/mem best way to it, or I should do it from kernelspace
via kernel module?

I am looking at  examples/common/hw_direct_io.c of Xenomai examples.
Can somebody explain me how Xenomai is used in this case, as I see
only standard pthread interface. Was this patched by Xenomai patches?
I do not see calls to RT tasks or some other Xenomai-related API.

I can see:
struct sched_param param;

printf("%s: %s %s\n", __FUNCTION__, __DATE__, __TIME__ );
param.__sched_priority = 99;
res = pthread_setschedparam(pthread_self(),  SCHED_FIFO, &param);

How these lines affect Xenomai?

Thanks and best regards,
Drasko

