Message-ID: <5322D3B7.6000408@xenomai.org>
Date: Fri, 14 Mar 2014 11:02:31 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAC-NLwzBXJ6BkmR+L-WnmJ04PnTba+7pbW2Y3nr7D30bozJzTA@mail.gmail.com>
In-Reply-To: <CAC-NLwzBXJ6BkmR+L-WnmJ04PnTba+7pbW2Y3nr7D30bozJzTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Transfer data from a kernel module to user
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: ashwin damle <ashwindamle@gmail.com>
Cc: xenomai@xenomai.org

On 03/14/2014 10:52 AM, ashwin damle wrote:
> Hello Developers,
> 
> I am trying to pass data from the Xenomai kernel module, using RTDM driver,
> to a user program. I am using the default examples-tut01-skeleton-drv.c and
> tut01-skeleton-app.c. The examples are working nicely  and I could get the
> right expected results. I am using Linux raspberrypi 3.5.7-xenomai #4
> PREEMPT Tue Mar 11 16:49:44 IST 2014 armv6l GNU/Linux, Xenomai used for
> during compilation was xenomai-2.6.2.1. The target is RaspberryPi.
> 
> The intention is to transfer a integer variable from the kernel to user. I
> tried changing the default example program only to reeive the error message
> ""ERROR : can't copy data from driver". I am unable to figure-out the
> problem. Attach is the program which I edited. I have written a comment
> wherever I define my variable, which is freq. Below is a snap
> 
> "
> static ssize_t simple_rtdm_read_nrt(struct rtdm_dev_context *context,
>                     rtdm_user_info_t * user_info, void *buf,
>                     size_t nbyte)
> {
>     buffer_t * buffer = (buffer_t *) context->dev_private;
>     int size = (buffer->size > nbyte) ? nbyte : buffer->size;
> 
>     buffer->size = sizeof(buffer->freq);
>     buffer->freq = 50;            //my variable, this is printed correctly
> as seen in dmesg
> 
>     if (rtdm_safe_copy_to_user(user_info, buf, &buffer->freq,
> sizeof(buffer->freq)))
>         rtdm_printk("ERROR : can't copy data from driver\n");
> 
>     return size;
> }
> "
> Attached is the user program, too.
> 
> Also, I wanted to know whether it is explicitly required to write to the
> device before reading it? I only want to read the device.( My application
> is noting the time of GPIO interrupts. )
> 
> Could you please help me with this? Request you to help me solve the
> problem.

copy_to_user operates on addresses, so you should pass &freq instead of
(void *)freq to rt_dev_read, otherwise the current value of freq, which
is a random value, is used by copy_to_user as an address which causes a
fault.


-- 
                                                                Gilles.

