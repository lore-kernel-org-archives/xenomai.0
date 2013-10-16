Message-ID: <525EC963.2000005@xenomai.org>
Date: Wed, 16 Oct 2013 19:14:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAEk6gTAj51aYJiCLVx+4-O_tnxfyyPvtLZO-hFVZvS+WjBpDtg@mail.gmail.com>
In-Reply-To: <CAEk6gTAj51aYJiCLVx+4-O_tnxfyyPvtLZO-hFVZvS+WjBpDtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hardware I/O from Userspace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Drasko DRASKOVIC <drasko.draskovic@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10/16/2013 06:06 PM, Drasko DRASKOVIC wrote:
> Hi all,
> I would like to access to various peripheral and CPU regs of my FPGA
> from userspace.
> 
> Is mmap of /dev/mem best way to it, or I should do it from kernelspace
> via kernel module?

Hi,

The RTDM kernel module is the recommended way, among other things, it may
be used to prevent several applications to access the registers at the
same time.

> 
> I am looking at  examples/common/hw_direct_io.c of Xenomai examples.
> Can somebody explain me how Xenomai is used in this case, as I see
> only standard pthread interface. Was this patched by Xenomai patches?
> I do not see calls to RT tasks or some other Xenomai-related API.
> 
> I can see:
> struct sched_param param;
> 
> printf("%s: %s %s\n", __FUNCTION__, __DATE__, __TIME__ );
> param.__sched_priority = 99;
> res = pthread_setschedparam(pthread_self(),  SCHED_FIFO, &param);
> 
> How these lines affect Xenomai?

Xenomai has more skins than just the native skin, it has notably a 
POSIX skin which attempts to implement the POSIX API. How 
pthread_setschedparam is hijacked by Xenomai is explained here:

https://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Compilation_flags

Regards.


-- 
					    Gilles.

