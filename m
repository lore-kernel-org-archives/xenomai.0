Date: Mon, 09 Apr 2018 11:59:19 +0200
Message-ID: <20180409115919.Horde.F6jK7go7kRv9owEvxxe7yxw@webmail.uam.es>
From: rodrigo.amaducci@uam.es
References: <1c628d16-62c7-bcb5-fe41-2cc9c0a5ebf6@xenomai.org>
 <6m2m4tbt7p9f2b8p30a2ptbt.1523206626964@embeddedgreg.com>
In-Reply-To: <6m2m4tbt7p9f2b8p30a2ptbt.1523206626964@embeddedgreg.com>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Subject: Re: [Xenomai] Context switching with POSIX skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Greg Gallagher <greg@embeddedgreg.com>, rpm@xenomai.org
Cc: xenomai@xenomai.org

Quoting Greg Gallagher <greg@embeddedgreg.com>:

> Tested on zynq zybo and microzed, the demo works. I built it from  
> stable using the 4.14 ipipe-arm repo and modprobed the module at  
> boot. Are you using a module or building it into the kernel?
>
> -Greg

I'm building it into the kernel. Since I'm new to all these I just took an
already working Ubuntu 16.04 with Xenomai 3.0.5 and added to its .config file
the RTIPC option with gconfig. The resulting .config has the following lines:

#
# Real-time IPC drivers
#
CONFIG_XENO_DRIVERS_RTIPC=m
CONFIG_XENO_DRIVERS_RTIPC_XDDP=y
CONFIG_XENO_DRIVERS_RTIPC_IDDP=y
CONFIG_XENO_OPT_IDDP_NRPORT=32
CONFIG_XENO_DRIVERS_RTIPC_BUFP=y
CONFIG_XENO_OPT_BUFP_NRPORT=32

After compiling the new kernel and installing it, if I do modprobe -n -v
xeno_rtipc I get:

insmod /lib/modules/4.9.90/kernel/drivers/xenomai/ipc/xeno_rtipc.ko

So since it seems to be correctly installed I guess it may a problem with
my Makefile, I'm using:

target = xddp-echo
skin = posix
CC := $(shell /usr/xenomai/bin/xeno-config --cc)
CFLAGS := $(shell /usr/xenomai/bin/xeno-config --skin=$(skin) --cflags)
LDFLAGS := $(shell /usr/xenomai/bin/xeno-config --skin=$(skin) --ldflags)
$(target): $(target).c
	$(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
clean:
	@rm $(target)

Am I missing something?

- Rodrigo




