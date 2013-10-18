MIME-Version: 1.0
In-Reply-To: <52602ECC.7060800@xenomai.org>
References: <CAEk6gTAj51aYJiCLVx+4-O_tnxfyyPvtLZO-hFVZvS+WjBpDtg@mail.gmail.com>
	<525EC963.2000005@xenomai.org>
	<CAEk6gTC7=6NJVJJTATHApcf8G13bX=68ZOAR4XdEmhiAgf3ZoQ@mail.gmail.com>
	<52602ECC.7060800@xenomai.org>
Date: Fri, 18 Oct 2013 18:30:44 +0200
Message-ID: <CAEk6gTCfAF5DXEDH-T=G2bBCR4Kk68uX4opUYQCYuJz-GZUwkw@mail.gmail.com>
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

On Thu, Oct 17, 2013 at 8:39 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 10/17/2013 04:57 PM, Drasko DRASKOVIC wrote:
>> Hi Gilles,
>>
>> On Wed, Oct 16, 2013 at 7:14 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> On 10/16/2013 06:06 PM, Drasko DRASKOVIC wrote:
>>>> Hi all,
>>>> I would like to access to various peripheral and CPU regs of my FPGA
>>>> from userspace.
>>>>
>>>> Is mmap of /dev/mem best way to it, or I should do it from kernelspace
>>>> via kernel module?
>>>
>>> Hi,
>>>
>>> The RTDM kernel module is the recommended way, among other things, it may
>>> be used to prevent several applications to access the registers at the
>>> same time.
>>
>> I will most probably have only one application who access these regs.
>>
>> Is not putting this application into the user-space safer - if it
>> breaks it will not block system?
>> Did i misunderstand something, or RTDM kernel module is like standard
>> kernel module - if it has a bug it can break the whole kernel.
>
> Yes, but having to separate application from driver is a future proof
> pattern: the same driver can be used with different applications, and
> changing hardware does not break the application, you only have to write
> a driver for the new hardware.
>

Here is my scenario: I have to access HW regs to set up and initialize
peripherals and FPGA. There is a lot of initialization, and currently
I am doing this from userspace via /dev/mem.

You are suggesting to move this as RTDM into the kernel space.

But I also have some code that is executed in this application that
might use floating point calculation, etc, i.e. pure data processing,
no HW access - but it has to be executed with high priority and in RT.

What would be the best  scenario in that case:
a) keep all as userspace
b) move all to kernelspace
c) divide this somehow into kernel-spce part of HW access and small
userspace app (of data processing) and make them communicate somehow
(how?). Would this affect responsiveness?


Best regards,
Drasko

