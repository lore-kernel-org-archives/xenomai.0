From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <5edd458f.55edb3f.46deba9c.9935a@domain.hid>
References: <5edd458f.55edb3f.46deba9c.9935a@domain.hid>
Content-Type: text/plain
Date: Wed, 05 Sep 2007 18:49:30 +0200
Message-Id: <1189010970.28092.307.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] communication between kernel and user space
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rtos <rtos@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-09-05 at 16:18 +0200, rtos wrote:
> Hello
> I am new in Xenomai and I can't figure out from examples what is the best way to send some data from kernel space rt_task to user space rt_task. I have created both tasks. In the kernel space task I've created rt_queue and I would like bind to it from the user space kernel task but all I've got is -EPERM?? I cannot figure out why it happens?
> best regards
> Marcin Piatek

[snip]

> */
> static int base_address_init(void) {
>     int err;
> 
>     if ((err = pci_register_driver(&pci_driver)))
>         return err;
> 
>     if ((err = rt_queue_create(&my_queue, "MyQueue", sizeof(int)*1000, 1000, Q_FIFO))) {

- if ((err = rt_queue_create(&my_queue, "MyQueue", sizeof(int)*1000, 1000, Q_FIFO)))
+ if ((err = rt_queue_create(&my_queue, "MyQueue", sizeof(int)*2000, 1000, Q_FIFO|Q_SHARED)))

You need to define a shared queue in order to share the memory pool
between kernel and userland. The pool size should also be raised a bit
since there is a minimum value in this case.

$ cat /proc/xenomai/registry/native/queues/MyQueue
to find more about the object you have just created.
In the former case, the queue type was defined as "local", which is not
what you want.

-- 
Philippe.



