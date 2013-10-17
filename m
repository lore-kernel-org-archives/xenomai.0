MIME-Version: 1.0
In-Reply-To: <525EC963.2000005@xenomai.org>
References: <CAEk6gTAj51aYJiCLVx+4-O_tnxfyyPvtLZO-hFVZvS+WjBpDtg@mail.gmail.com>
	<525EC963.2000005@xenomai.org>
Date: Thu, 17 Oct 2013 16:57:43 +0200
Message-ID: <CAEk6gTC7=6NJVJJTATHApcf8G13bX=68ZOAR4XdEmhiAgf3ZoQ@mail.gmail.com>
From: Drasko DRASKOVIC <drasko.draskovic@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] Hardware I/O from Userspace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Gilles,

On Wed, Oct 16, 2013 at 7:14 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 10/16/2013 06:06 PM, Drasko DRASKOVIC wrote:
>> Hi all,
>> I would like to access to various peripheral and CPU regs of my FPGA
>> from userspace.
>>
>> Is mmap of /dev/mem best way to it, or I should do it from kernelspace
>> via kernel module?
>
> Hi,
>
> The RTDM kernel module is the recommended way, among other things, it may
> be used to prevent several applications to access the registers at the
> same time.

I will most probably have only one application who access these regs.

Is not putting this application into the user-space safer - if it
breaks it will not block system?
Did i misunderstand something, or RTDM kernel module is like standard
kernel module - if it has a bug it can break the whole kernel.

>
>>
>> I am looking at  examples/common/hw_direct_io.c of Xenomai examples.
>> Can somebody explain me how Xenomai is used in this case, as I see
>> only standard pthread interface. Was this patched by Xenomai patches?
>> I do not see calls to RT tasks or some other Xenomai-related API.
>>
>> I can see:
>> struct sched_param param;
>>
>> printf("%s: %s %s\n", __FUNCTION__, __DATE__, __TIME__ );
>> param.__sched_priority = 99;
>> res = pthread_setschedparam(pthread_self(),  SCHED_FIFO, &param);
>>
>> How these lines affect Xenomai?
>
> Xenomai has more skins than just the native skin, it has notably a
> POSIX skin which attempts to implement the POSIX API. How
> pthread_setschedparam is hijacked by Xenomai is explained here:
>
> https://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Compilation_flags

Usage of the compilation flags is pretty-much clear. What I was asing
is can anybody elaborate of how Posix calls became Xenomai ones in
this example (if they did).

BR,
Drasko

