Message-ID: <5581BE6F.4030607@siemens.com>
Date: Wed, 17 Jun 2015 20:37:35 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <7B9254AC-C035-4D61-884E-8C9B3706A22B@gmail.com>
In-Reply-To: <7B9254AC-C035-4D61-884E-8C9B3706A22B@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM-native brushup
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <haberlerm@gmail.com>, xenomai <xenomai@xenomai.org>

On 2015-06-15 16:39, Michael Haberler wrote:
> ok, so tried to just get RTDM support and rtdmtest build as module and loadable without error, and that works
> 
> I did not bother fixing the sk_alloc() etc proto related changes for now
> Kernel was 3.2.0-4-rt-686-pae #1 SMP PREEMPT RT Debian 3.2.68-1+deb7u1 i686 GNU/Linux (RT-PREEMPT kernel in debian wheezy)
> 
> 
> this is where I am:  https://github.com/mhaberler/rtdm-native/commits/try1
> 
> do not expect my API transmogrifications to be correct, those were based on "maximum likelihood" guesstimates
> 
> 
> modprobe rtdm
> [31537.309416] starting RTDM services.
> 
> modprobe rtdmtest
> [31540.595708] __rtdmtest_init: registering device rttest0, err=251
> 
> mah@nwheezy:~/rtdm-native/ksrc/drivers/testing$ grep rttes /proc/devices 
> 251 rttest0
> 
> rmmod rtdmtest
> [31551.675050] rtdm_task_destroy: not allowed on user threads
> [31551.675053] rtdm_task_join_nrt: not allowed on user threads
> [31551.675056] __rtdmtest_exit: unregistering device rttest0
> 
> rmmod rtdm
> [31557.916463] stopping RTDM services.
> 
> the rtdm_task_destroy ff warning re user threads I cant make much sense of, I guess some underlying change

I would start checking if rtdm_task_has_magic(task) returns false, and
why. But I would also check the current kernel API /wrt kthread
management. There were some changes since then, and likely better
mappings are available now.

> 
> examples/rtdm-native/rtdmtest fails since /dev/rttest0 doesnt show up, I guess hotplug/udev update required - not sure how to force creation of the /dev entry otherwise

mknod?

> 
> I am unsure where to go from here - I looked over the xenomai-3 rtdm changes and I dont feel I'm qualified to track those

I suppose you have a use case / driver in mind. So it would probably be
best for you to fix / revise the native layer along that usage profile,
starting with init/cleanup functions, then extending to runtime services.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

