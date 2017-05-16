References: <DB6PR0701MB2456788DAE300E14759F9646B5E10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ee8f012f-ef3d-fdfc-96d6-8318e1f58dfd@xenomai.org>
Date: Tue, 16 May 2017 11:56:35 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB2456788DAE300E14759F9646B5E10@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_task_bind returns -EINVAL when not using
 --enable-smp
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/15/2017 12:04 PM, Giulio Moro wrote:
> Hi,
> I have a 4.4.61 kernel with Xenomai 3.0.4 on am335x (BeagleBone Black) compiled with 
> 
> CONFIG_BROKEN_ON_SMP=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_HAVE_SMP=y
> # CONFIG_SMP is not set
> (see XENO flags at the bottom of the email)
> 
> When I compile the user-space support with
>     /root/xenomai/configure --with-core=cobalt --enable-smp --enable-pshared
> my program (which uses the Alchemy API) works fine
> 
> But when I do it with
>     /root/xenomai/configure --with-core=cobalt --enable-pshared
> , then calls to rt_task_bind or rt_task_create return -EINVAL.
> 

I can't reproduce this issue. You may want to check that your
application is compatible with your kernel setup by looking at the
output of <your-app> --dump-config.

e.g.

# latency --dump-config
based on Xenomai/cobalt v3.0.4 -- #90a7ab2 (2017-05-16 11:12:57 +0200)
CONFIG_MMU=1
CONFIG_XENO_BUILD_ARGS=" '--host=arm-linux-gnueabihf' '--prefix=/usr'
'--includedir=/usr/include/xenomai' '--disable-doc-install'
'--disable-smp' '--disable-tls' '--disable-debug'
'--disable-valgrind-client' '--with-core=cobalt' '--enable-pshared'
'host_alias=arm-linux-gnueabihf'"
CONFIG_XENO_BUILD_STRING="x86_64-unknown-linux-gnu"
CONFIG_XENO_COBALT=1
...

> Given that SMP is not enabled in the kernel, I would expect the latter to be the correct one and possibly the former to fail.

Running a SMP-capable application on a UP kernel is a non-issue, this
just means that the application code is going to emit memory barriers
uselessly in some cases. The opposite configuration is a problem though,
which the cobalt core detects, i.e.

   0"000.000| BUG in __xenomai_init(): [main] running non-SMP libraries
on SMP kernel?
              build with --enable-smp or disable check with --no-sanity

> 
> Note that /usr/xenomai/bin/xeno-test and /usr/xenomai/bin/latency work ok in both cases.
>

You may want to check with demo/altency, which is the strict equivalent
of the latency test written with the legacy alchemy API.

-- 
Philippe.

