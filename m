Message-ID: <4800DE84.5040200@domain.hid>
Date: Sat, 12 Apr 2008 12:08:36 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
References: <47FFB7D3.3040000@domain.hid>
	<18432.49619.109362.265306@domain.hid>
In-Reply-To: <18432.49619.109362.265306@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] waiting for multiple hardware interrupts
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Hi Gilles,

thank you for the info. I have additional question: Is it possible to 
wait for multiple interrupts without specific kernel support (RTDM 
driver or kernel-space IRQ handlers or anything) ? I see that without 
kernel support, in native skin, one can in user-space wait for a 
specific hardware interrupt using "rt_intr_wait". I need to wait for 
multiple interrupts in user space. Do I have to create a dedicated 
thread to wait for each interrupt ?

Thanks,
Tomas



Gilles Chanteperdrix wrote:
> Tomas Kalibera wrote:
>  > Hi,
>  > 
>  > is it possible, in user-space, to wait for a set of hardware interrupts 
>  > ? Something like UNIX select, which allows to wait for multiple devices 
>  > to become ready...
>  > 
>  > Or do I need to spawn a dedicated thread for each interrupt to wait for ?
>
> There are two answers to this question: if you use the native skin
> services, and/or the various interrupt you want to wait for belongs to
> the same driver, you may use the native skin event flags services. Each
> interrupt handler would call rt_event_signal to signal a different bit
> in the rt_event object, and you would wait for events with the
> rt_event_wait service.
>
> But Xenomai also has a select service (for now, only the posix skin
> proposes this service), which looks more adapted if each interrupt
> handler belongs to a different driver. If you want to use it, you will
> have to implement a select_bind callback for each RTDM driver you want
> to select from. For instance, if an RTDM driver looks like:
>
> typedef struct mydriver_context {
>     /* ... */
>     rtdm_sem_t pending_sem;
>     /* ... */
> } mydriver_context_t;
>
> int mydriver_irq_handler(rtdm_irq_t *irq)
> {
>     mydriver_context_t *context = /* ... */
>
>     rtdm_sem_up(&context->pending_sem);
>
>     /* ... */
> }
>
> ssize_t mydriver_read(struct rtdm_dev_context *context,
>                       rtdm_user_info_t *user_info,
>                       void *buf, size_t nbyte)
> {
>     /* ... */
>     mydriver_context_t *mydriver_context =
>         (mydriver_context_t *)&context->dev_private;
>     int err;
>      
>     /* ... */
>
>     err = rtdm_sem_down(&mydriver_context->pending_sem);
>    
>     /* ... */
> }
>
> static struct rtdm_device mydriver_device {
>     /* ... */
>
>     .ops = {
>          /* ... */
>          .read_rt = mydriver_read;
>
>     /* ...*/
> };
>
> static int __init mydriver_init(void) 
> {
>      int err = rtdm_dev_register(&mydriver_device);
>      /* ... */
> }
>
> All you have to do is to write:
> int mydriver_select_bind(struct rtdm_dev_context *context,
>                          struct xnselector *selector,
>                          unsigned type,
>                          unsigned index)
> {
>     mydriver_context_t *mydriver_context =
>         (mydriver_context_t *)&context->dev_private;
>     int err;
>
>     if (type == RTDM_SELECTTYPE_READ)
>         err = rtdm_sem_select_bind(&mydriver_context->pending_sem, 
>                                    selector, type, index);
>     else
>         err = -EBADF;
>
>     return err;
> }
>
> And add in mydriver_device declaration:
>
> static struct rtdm_device mydriver_device {
>     /* ... */
>
>     .ops = {
>          /* ... */
>          .select_bind = mydriver_select_bind;
>
>     /* ...*/
> };
>
> You do not have to worry very much about the performance of the
> mydriver_select_bind callback: contrarily to what happens with a Linux
> driver, it will be called only the first time mydriver's file descriptor
> is passed to select, after that, select does all the housekeeping (the
> select block gets updated by each call to rtdm_sem_up and rtdm_sem_down).
>
> I took rtdm_sem_t as an example, but rtdm_event_t also has builtin
> support for (there is an rtdm_event_select_bind service that can be
> called in the implementation of a driver's select_bind callback).
>
> Also note this scheme works well if a driver signals a semaphore (or
> event) whether there is a pending reader or not, as showed in the
> example. For instance, adapting Xenomai serial driver to select would be
> a bit more complicated, because the driver only signals an event if
> there is a pending reader, whereas we want the select block to be
> updated even when there is no thread blocked in the select service.
>
>   


