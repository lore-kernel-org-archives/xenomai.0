Subject: Re: migrating to xenomai 3
References: <269aa40f-de14-b7a5-0486-98df418befbf@compador.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <048dfe58-6214-1beb-18cf-c954057f4abc@siemens.com>
Date: Tue, 7 Jan 2020 13:50:50 +0100
MIME-Version: 1.0
In-Reply-To: <269aa40f-de14-b7a5-0486-98df418befbf@compador.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
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
To: Johannes Holtz <johannes.holtz@compador.de>, xenomai@xenomai.org

On 07.01.20 11:42, Johannes Holtz via Xenomai wrote:
> Hi,
> 
> after a long and exhausting year I finally found time to experiment on 
> migrating our application from Xenomai 2.6.4 to Xenomai 3.
> 
> So I downloaded the latest stable release 3.0.10 and somehow found out I 
> can't use the 4.19 ipipe kernel but the 4.14 so i also got that. 
> patched, build, installed and tested the kernel an the binaries and now 
> I was going to see what I have to do to build my application.
> 
> I used to build my app with these flags:
> 
> XENO_CONFIG    = /opt/xenomai/bin/xeno-config
> XENO_CFLAGS    = $(shell $(XENO_CONFIG) --skin=rtdm  --cflags 2>/dev/null)
> XENO_LDFLAGS    = $(shell $(XENO_CONFIG) --skin=rtdm --ldflags 
> 2>/dev/null) -lnative
> 
> If you ask why I use rtdm and native. I need -lnative else I get this:
> 
> rt_x_threads.c:(.text+0x3e9): undefined reference to `rt_timer_read'
> rt_x_threads.c:(.text+0x3fd): undefined reference to `rt_task_join'
> rt_x_threads.c:(.text+0x40b): undefined reference to `rt_task_delete'
> rt_x_threads.c:(.text+0x429): undefined reference to `rt_timer_read'
> 
> And I need -lrtdm else I get this:
> 
> rt_x_ipc.c:(.text+0x4a): undefined reference to `rt_dev_socket'
> rt_x_ipc.c:(.text+0x9e): undefined reference to `rt_dev_ioctl'
> rt_x_ipc.c:(.text+0xde): undefined reference to `rt_dev_ioctl'
> rt_x_ipc.c:(.text+0x112): undefined reference to `rt_dev_ioctl'
> rt_x_ipc.c:(.text+0x16c): undefined reference to `rt_dev_ioctl'
> rt_x_ipc.c:(.text+0x17f): undefined reference to `rt_dev_close'
> rt_x_ipc.c:(.text+0x1ac): undefined reference to `rt_dev_close'
> rt_x_ipc.c:(.text+0x206): undefined reference to `rt_dev_close'
> rt_x_ipc.c:(.text+0x219): undefined reference to `rt_dev_close'
> 
> I wanted to used the native interface so I can distinguish rt syscalls 
> from standard posix calls.
> 
> 
> FFD to my migration. I build Xenomai in cobalt skin and not mercury. I 
> added the --compat switch to xeno-config but -lnative and -lrtdm are 
> both not found anymore. Meaning there is a ton of undefined references.
> 
> What would be the best strategy to solve this? Do I have to migrate all 
> my native calls to posix calls or is there maybe a wrapper?
> 

Try --skin=native instead - there is "rtdm" skin anymore.

And for the rt_dev_* symbols: Those should magically be resolved as well 
because they are static-inline wrappers in lib/trank.

I bet this is somewhere documented as well in 
https://gitlab.denx.de/Xenomai/xenomai/-/wikis/Migrating_From_Xenomai_2_To_3.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

