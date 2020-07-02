Subject: Re: Receiving "Operation Not Permitted" when setting
 RTCAN_RTIOC_RCV_TIMEOUT and reading from CAN over cobalt pthread
References: <MN2PR19MB39672146FC17172A042EECFED56C0@MN2PR19MB3967.namprd19.prod.outlook.com>
 <BYAPR11MB3765B4BBCD3D3DC9AFC9D7C1EE6D0@BYAPR11MB3765.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <80cc1802-0c93-05b9-534e-39c2f432db72@siemens.com>
Date: Thu, 2 Jul 2020 06:49:44 +0200
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB3765B4BBCD3D3DC9AFC9D7C1EE6D0@BYAPR11MB3765.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Meng, Fino" <fino.meng@intel.com>, Josh Karch <jkarch@FirstMode.com>
Cc: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 02.07.20 04:40, Meng, Fino via Xenomai wrote:
> Maybe it's due to RT group scheduling, would u try this:
> 
> sysctl -w kernel.sched_rt_runtime_us=-1
> //or
> echo $$ > /sys/fs/cgroup/cpu/cgroup.procs
> 

That is actually not evaluated by Xenomai for its own threads.

Jan

> https://github.com/systemd/systemd/blob/master/README
>         We recommend to turn off Real-Time group scheduling in the
>         kernel when using systemd. RT group scheduling effectively
>         makes RT scheduling unavailable for most userspace, since it
>         requires explicit assignment of RT budgets to each unit whose
>         processes making use of RT. As there's no sensible way to
>         assign these budgets automatically this cannot really be
>         fixed, and it's best to disable group scheduling hence.
>            CONFIG_RT_GROUP_SCHED=n
> 
> 
> BR / Fino (孟祥夫)
> Intel – IOTG Developer Enabling
> 
>> Sent: Wednesday, July 1, 2020 10:56 PM
>> pthread
>>
>> Hello,
>>
>> So a quick update, I was able to get the CAN drivers working, the issue as was suggested is that Linux did not register the
>> interrupts for the Zynq, and I had to make a fake "generic-uio" module in the device tree to receive a valid IRQ number, and
>> now the CAN core registers properly.
>>
>> Now, I'm trying to create an application using the POSIX skin, based on the rtcanrecv.c example.  Rather than using
>> rt_task_shadow, I'm using pthread_create.  My Makefile uses xeno-config with --skin=posix and sets --cflags and --ldflags, while
>> wrap-link uses the POSIX ldflags. We are using libcobalt.
>>
>> When I don't set the timeout IOCTL, my application runs, but it blocks indefinitely until messages are received, however when I
>> set the IOCTL (0.1 sec) ret = ioctl(can_fd, RTCAN_RTIOC_RCV_TIMEOUT, &timeout); then make the read in my pthread
>>
>> ret = recvfrom(can_fd, (void *)&can_msg_frame, sizeof(can_frame_t), 0,
>>                                  (struct sockaddr *)&can_address, &address_length);
>>
>> I receive -EPERM rather than -ETIMEDOUT as a return.  The application is run as root, and works normally unless the TIMEOUT
>> ioctl above is triggered;  thoughts on where to look?
>>
>> Here are the lines of interest for the Makefile:
>> CFLAGS := $(shell $(DESTDIR)$(XENO_DIR)/$(XENO_CONFIG) --skin=posix --cflags) LDFLAGS := $(shell
>> $(DESTDIR)$(XENO_DIR)/$(XENO_CONFIG) --skin=posix --ldflags)
>>
>> $(PROGNAME):
>> $(CC) -c  $(PROGNAME).c $(CFLAGS)
>> $(DESTDIR)$(XENO_DIR)/$(WRAP_LINK) -v $(CC) -o $(PROGNAME) $(PROGNAME).o $(LDFLAGS)
>>
>> My guess is if I make the application run as an rt_task it would work.
>> Are there any special parameters needed to be set for pthread_create in order to run in RT mode?
>>
>>
>> Best,
>>
>> Josh Karch
> 


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

