MIME-Version: 1.0
Date: Thu, 28 Apr 2016 15:45:09 +0300
Message-ID: <CAJ2oMhLB8Mm7go7-K2D3LKA8uiuHum2GV08FNg9Bqp9WrLmFag@mail.gmail.com>
From: Ran Shalit <ranshalit@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Communication between RT-kernel to non-RT kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, Apr 28, 2016 at 1:52 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Thu, Apr 28, 2016 at 08:37:17AM +0300, Ran Shalit wrote:
>> On Thu, Apr 28, 2016 at 7:44 AM, Ran Shalit <ranshalit@gmail.com> wrote:
>> > Hello,
>> >
>> > I am new with xenomai.
>> >
>> > I've made a lot of reading in the documentation which is very helpful.
>> > But I haven't found how to communicate between rt kernel to non-rt
>> > kernel on same machine,
>> > Is there any example or documantation which explains this ?
>> >
>> > Best Regards,
>> > Ran
>>
>> I guess that there is actually no need for such example or documentation.
>> In userland 2 applications, one using xenomai kernel and the other
>> linux kernel can commuicate
>> in any method available in Linux between processes (pipes, shared
>> memeory, etc) . Right?
>
> Not quite. Accessing a pipe from a xenomai thread will cause it to
> switch to secondary mode, IOW to migrate to the Linux kernel.
>
> The IPC adapted to communicated between Xenomai threads and plain
> Linux threads is XDDP, see the API documentation here:
> https://xenomai.org/api-reference/
>

Thank you for the feedback,
I did eventually see that there is good introduction documentation for
this "A tour of the native API ".
1. In this document I see that there are others mechanism which can be used :
message Queues and shared memory.
2. Other thing I've noticed is that it seems that in xenomai 3.x pdf
folder this document is missing. Is the native api not relevant with
xenomai 3.x anymore ?
3. We do a kind of simple "Linux RT POC project", in order to
understand how xenomai is RT (so that we can later choose between
vxWorks or Linux according to the results),
all we need to do is something simple as following:
  3.1 application running on Zynq will get periodic interrupt from fpga.
  3.2 on receiving interrupt it shall do some known mathematic
calculation and continue to wait for next interrupt
  3.3 we need to measure the time of received interrupt in application
and to measure jitter if exist.
  3.4 we also need to write simple standard Linux application which
shall read the statistics from the RT application.
4. Can rtdm_clock_read  be used for reading time of interrupt ?
5. If a userspace wait for interrupt on rt_intr_wait, which is
synchronizaed on clock, is it better to CONFIG_HZ a larger number in
order to get smaller lateny ?

any feedback or suggestions is appreciated,

Regards,
Ran

