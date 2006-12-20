Message-ID: <b647ffbd0612201121l2562ce4bq430d1db5166a5903@domain.hid>
Date: Wed, 20 Dec 2006 20:21:18 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] install an interrupt-handler from a kernel module
In-Reply-To: <45894FA5.1070709@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <458915DB.80909@domain.hid>
	<b647ffbd0612200340had5a21ajd1bcb7cd871d06fb@domain.hid>
	<45894FA5.1070709@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Markus.Franke@domain.hid
Cc: Xenomai help <xenomai@xenomai.org>

On 20/12/06, Markus Franke <Markus.Franke@domain.hid> wrote:


Then I misundertood you. See below.


> My code for the kernel module looks something like that:
>
> ---snip---
> int myisr(xnintr_t* cookie)
> {
>         printk("interrupt fired")
> }
>
> module_init()
> {
>         rt_intr_create(...,my_isr,...);
>         rt_intr_enable(...);
>         register_chrdev(...);
> }
> ---snap---

that's ok.


>
> What about if I write something like that:
>
> ---snip---
> int myroutine()
> {
>         rt_intr_create(...,my_isr,...);
>         rt_intr_enable(...);
>         register_chrdev(...);
> }
>
> module_init()
> {
>         rt_task_create(...);
>         rt_task_start(...,myroutine,...);
> }
> ---snap---
>
> I can't see any difference whether to start a realtime task explicitly
> vi "rt_task_create" or not.

In this example, the "myroutine" task is used only to setup an ISR and
register a character device and then it _exits_. It's absolutely not
necessary and your first example is ok.

Look at docs for rt_intr_create()

 * This service can be called from:
 *
 * - Kernel module initialization/cleanup code
 * - Kernel-based task

The way how it's registered has no effect on deterministic behavior
wrt irq latencies.


-- 
Best regards,
Dmitry Adamushko

