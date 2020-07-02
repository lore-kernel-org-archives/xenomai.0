Subject: Re: Receiving "Operation Not Permitted" when setting
 RTCAN_RTIOC_RCV_TIMEOUT and reading from CAN over cobalt pthread
References: <MN2PR19MB39672146FC17172A042EECFED56C0@MN2PR19MB3967.namprd19.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <e4369869-59d5-742b-ff4b-a89d4f9f5328@siemens.com>
Date: Thu, 2 Jul 2020 06:43:09 +0200
MIME-Version: 1.0
In-Reply-To: <MN2PR19MB39672146FC17172A042EECFED56C0@MN2PR19MB3967.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Josh Karch <jkarch@FirstMode.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01.07.20 16:55, Josh Karch via Xenomai wrote:
> Hello,
> 
> So a quick update, I was able to get the CAN drivers working, the issue as was suggested is that Linux did not register the interrupts for the Zynq, and I had to make a fake "generic-uio" module in the device tree to receive a valid IRQ number, and now the CAN core registers properly.
> 
> Now, I'm trying to create an application using the POSIX skin, based on the rtcanrecv.c example.  Rather than using rt_task_shadow, I'm using pthread_create.  My Makefile uses xeno-config with --skin=posix and sets --cflags and --ldflags, while wrap-link uses the POSIX ldflags. We are using libcobalt.
> 
> When I don't set the timeout IOCTL, my application runs, but it blocks indefinitely until messages are received, however when I set the IOCTL (0.1 sec)
> ret = ioctl(can_fd, RTCAN_RTIOC_RCV_TIMEOUT, &timeout);
> then make the read in my pthread
> 
> ret = recvfrom(can_fd, (void *)&can_msg_frame, sizeof(can_frame_t), 0,
>                                   (struct sockaddr *)&can_address, &address_length);
> 
> I receive -EPERM rather than -ETIMEDOUT as a return.  The application is run as root, and works normally unless the TIMEOUT ioctl above is triggered;  thoughts on where to look?
> 
> Here are the lines of interest for the Makefile:
> CFLAGS := $(shell $(DESTDIR)$(XENO_DIR)/$(XENO_CONFIG) --skin=posix --cflags)
> LDFLAGS := $(shell $(DESTDIR)$(XENO_DIR)/$(XENO_CONFIG) --skin=posix --ldflags)
> 
> $(PROGNAME):
> $(CC) -c  $(PROGNAME).c $(CFLAGS)
> $(DESTDIR)$(XENO_DIR)/$(WRAP_LINK) -v $(CC) -o $(PROGNAME) $(PROGNAME).o $(LDFLAGS)
> 
> My guess is if I make the application run as an rt_task it would work.
> Are there any special parameters needed to be set for pthread_create in order to run in RT mode?
> 

If wrapping is worked fine (check the symbols that your application is
actually calling: __wrap_ioctl? Also __wrap_socket?), you do not need
special parameters to the thread creation, also SCHED_OTHER threads will
be able to RTDM drivers then.

Besides that offline check, you can also look if that thread shows up
/proc/xenomai/sched/threads while it is existing.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

