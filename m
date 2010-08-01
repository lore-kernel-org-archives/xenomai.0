MIME-Version: 1.0
In-Reply-To: <1280655383.6700.11.camel@domain.hid>
References: <AANLkTimuiAP=dGQSKG2PYJUnGw--1iXBzPJ1325czz-_@domain.hid>
	<1280655383.6700.11.camel@domain.hid>
Date: Sun, 1 Aug 2010 15:10:27 +0200
Message-ID: <AANLkTiktAuNZQP0hqXoHBZMayaywfkZ9By6_ug5B8YM_@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai-help] Problems with user_irq.c Native example
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: murilomarinho@domain.hid, xenomai@xenomai.org

If you really want to use the rt_intr_xxx interface, you might want to
pass the RT_INTR_NOENABLE mode-flag to rt_intr_create and call
rt_intr_enable after you have acknowledged your interrupt source (or
just before you wait for the interrupt) in your interrupt handler.

But as Philippe mentioned it is cleaner to use the rtdm driver approach.

Henri.

On Sun, Aug 1, 2010 at 11:36 AM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Sun, 2010-08-01 at 04:03 -0300, Murilo Marinho wrote:
>> I tried running the user_irq.c example as described in the section
>> 7.14 in the native PDF, which is written in the end of this mail.
>> At first, it froze my system every time I tried running it. I did some
>> changes in the code, trying to find out what was wrong with it.
>>
>> >From what I understood this should work (I'm new to xenomai
>> programming), the rt_intr_wait function should pause the running task
>> until the interrupt comes, but after inserting some flow controls, I
>> found it to be freezing due to excessive processing of the irq_server,
>> which at first seemed to be receiving endless interruption signals.
>>
>> In the next step, I added error handling, but the return value of the
>> function was -38, which didn't mean it worked ( as it wasn't a
>> positive
>> value), nor it was any of the errors described in the function documentation.
>>
>> I also tried changing from TM_INFINITE to many numerical values to no
>> avail, got the same return value.
>>
>> Have I misunderstood the way this function works? Does this error
>> means something?
>>
>
> CONFIG_XENO_OPT_NATIVE_INTR is disabled in your kernel configuration,
> which causes -ENOSYS to be returned. You have to switch this on to
> enable userland interrupt support.
>
> Also note that such support may introduce serious issues down the road,
> like not being able to use gdb over your application; using it in new
> apps is a bad idea in the first place, because interrupt handling is
> fundamentally a kernel thing, and should remain so.
>
> Providing this interface was a mistake, it is now deprecated, and
> scheduled for removal in 3.x. The right approach is to process
> (real-time) interrupts in kernel space from a RTDM driver, waking up a
> userland thread as needed. That thread may wait for events via blocking
> ioctl()/read() requests directed at the driver, thus following the
> standard programming model.
>
>> I'm using ubuntu 9.10, xenomai 2.5.3 and kernel 2.6.34
>>
>> 7.14 user_irq.c
>> #include <sys/mman.h>
>> #include <native/task.h>
>> #include <native/intr.h>
>> #define IRQ_NUMBER 7 /* Intercept interrupt #7 */
>> #define TASK_PRIO 99 /* Highest RT priority */
>> #define TASK_MODE 0 /* No flags */
>> #define TASK_STKSZ 0 /* Stack size (use default one) */
>> RT_INTR intr_desc;
>> RT_TASK server_desc;
>> void irq_server (void *cookie)
>> {
>> for (;;) {
>> /* Wait for the next interrupt on channel #7. */
>> err = rt_intr_wait(&intr_desc,TM_INFINITE);
>> if (!err) {
>> /* Process interrupt. */
>> }
>> }
>> }
>> int main (int argc, char *argv[])
>> {
>> int err;
>> mlockall(MCL_CURRENT|MCL_FUTURE);
>> /* ... */
>> err = rt_intr_create(&intr_desc,"MyIrq",IRQ_NUMBER,0);
>> /* ... */
>> err = rt_task_create(&server_desc,
>> "MyIrqServer",
>> TASK_STKSZ,
>> TASK_PRIO,
>> TASK_MODE);
>> if (!err)
>> rt_task_start(&server_desc,&irq_server,NULL);
>> /* ... */
>> }
>> void cleanup (void)
>> {
>> rt_intr_delete(&intr_desc);
>> rt_task_delete(&server_desc);
>> }
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>
> --
> Philippe.
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

