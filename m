MIME-Version: 1.0
In-Reply-To: <CALLqZ8SMzQ1ddAje--udcvWqKpUpDtJEPDEwLGWYz+JUXSXTmg@mail.gmail.com>
References: <1c628d16-62c7-bcb5-fe41-2cc9c0a5ebf6@xenomai.org>
 <6m2m4tbt7p9f2b8p30a2ptbt.1523206626964@embeddedgreg.com>
 <20180409115919.Horde.F6jK7go7kRv9owEvxxe7yxw@webmail.uam.es>
 <CALLqZ8SMzQ1ddAje--udcvWqKpUpDtJEPDEwLGWYz+JUXSXTmg@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 9 Apr 2018 23:43:51 -0400
Message-ID: <CALLqZ8TrbPvVPGd6PK7M10NNhJQ_FO_-ekhBQ6OR1KTYnOgOhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Context switching with POSIX skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: rodrigo.amaducci@uam.es
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

I was able to reproduce the issue, but it only happened if I didn't
have the driver loaded.  I would try building it as a loadable module
then load it and confirm it's running using lsmod.  Then run your test
application.

-Greg

On Mon, Apr 9, 2018 at 11:13 PM, Greg Gallagher <greg@embeddedgreg.com> wrote:
> That looks sane to me, this thread outlines a similar problem:
>
> http://xenomai.org/pipermail/xenomai/2017-December/038078.html
>
> My CFLAGS and LDFLAGS are slightly different:
>
> XENO_CONFIG := $(PATH_TO_STAGE)/usr/xenomai/bin/xeno-config
> CFLAGS := $(shell DESTDIR=$(PATH_TO_STAGE) $(XENO_CONFIG) --posix --cflags)
> LDFLAGS := $(shell DESTDIR=$(PATH_TO_STAGE) $(XENO_CONFIG) --posix --ldflags)
> CC := $(shell DESTDIR=$(PATH_TO_STAGE) $(XENO_CONFIG) --cc)
>
> PATH_TO_STAGE for my environment points to where I installed my xeno
> binaries in during the build stage.
>
> -Greg
>
> On Mon, Apr 9, 2018 at 5:59 AM,  <rodrigo.amaducci@uam.es> wrote:
>> Quoting Greg Gallagher <greg@embeddedgreg.com>:
>>
>>> Tested on zynq zybo and microzed, the demo works. I built it from stable
>>> using the 4.14 ipipe-arm repo and modprobed the module at boot. Are you
>>> using a module or building it into the kernel?
>>>
>>> -Greg
>>
>>
>> I'm building it into the kernel. Since I'm new to all these I just took an
>> already working Ubuntu 16.04 with Xenomai 3.0.5 and added to its .config
>> file
>> the RTIPC option with gconfig. The resulting .config has the following
>> lines:
>>
>> #
>> # Real-time IPC drivers
>> #
>> CONFIG_XENO_DRIVERS_RTIPC=m
>> CONFIG_XENO_DRIVERS_RTIPC_XDDP=y
>> CONFIG_XENO_DRIVERS_RTIPC_IDDP=y
>> CONFIG_XENO_OPT_IDDP_NRPORT=32
>> CONFIG_XENO_DRIVERS_RTIPC_BUFP=y
>> CONFIG_XENO_OPT_BUFP_NRPORT=32
>>
>> After compiling the new kernel and installing it, if I do modprobe -n -v
>> xeno_rtipc I get:
>>
>> insmod /lib/modules/4.9.90/kernel/drivers/xenomai/ipc/xeno_rtipc.ko
>>
>> So since it seems to be correctly installed I guess it may a problem with
>> my Makefile, I'm using:
>>
>> target = xddp-echo
>> skin = posix
>> CC := $(shell /usr/xenomai/bin/xeno-config --cc)
>> CFLAGS := $(shell /usr/xenomai/bin/xeno-config --skin=$(skin) --cflags)
>> LDFLAGS := $(shell /usr/xenomai/bin/xeno-config --skin=$(skin) --ldflags)
>> $(target): $(target).c
>>         $(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
>> clean:
>>         @rm $(target)
>>
>> Am I missing something?
>>
>> - Rodrigo
>>
>>
>>

