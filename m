MIME-Version: 1.0
Sender: had2006@gmail.com
In-Reply-To: <CAKk99t0ndeNODKHf3mmL4GTg9wrOnOcsgf_okqx_-dmNitWkXA@mail.gmail.com>
References: <CAKk99t1N5b0_iQerSxPyKmMTLC8PePTJCO9zzFLdkmt_mDiiVg@mail.gmail.com>
 <54F716CC.1010600@xenomai.org>
 <CAKk99t14auR=Ez-9k6bSxDQt5iNbTjvYtxeaAyGzMPuwQi_nnQ@mail.gmail.com>
 <54F73E7A.2070100@xenomai.org>
 <CAKk99t0z4Tq==LTzFK_9cmbrDTZ+RFt2vo=ur56VbVG3sso_iQ@mail.gmail.com>
 <5505B14F.4060107@xenomai.org>
 <CAKk99t3Gv-3Nz=drk-bOvbYo7EU3F-DSsGA35Z6D6GdF_z00Zg@mail.gmail.com>
 <55072D34.1070405@xenomai.org>
 <CAKk99t2ZsNmY4myJAF+H3hWNpHN4bVm255QEsU6Nu+ytG-B0dA@mail.gmail.com>
 <550837E2.9050701@xenomai.org>
 <CAKk99t2eGYME0BsLCjJV7VMm8VU_2okmpd8sYfMb_02sTvOfLQ@mail.gmail.com>
 <55083DA4.3080201@xenomai.org>
 <CAKk99t0pG6HWOucFXDw1-_5-=EGQ7faqA22yVog6Ye6TcGjevA@mail.gmail.com>
 <550850D5.9060207@xenomai.org>
 <CAKk99t0q3iNcah1Us79hJUjjHQCr2rEPu9gukSNjO2a6+Gk3sg@mail.gmail.com>
 <CAKk99t3wP-WLemoO_bbsvE4uwh-Sh-5eGPJrM=6cAc5edyQW5Q@mail.gmail.com>
 <5508600D.4020500@xenomai.org>
 <CAKk99t3xFzLuydH3HoPzWBzjd5DNtC_4Kf3YQuodHDpXTLdsUg@mail.gmail.com>
 <550B0626.5090801@xenomai.org> <550B1584.8040309@xenomai.org>
 <CAKk99t0ndeNODKHf3mmL4GTg9wrOnOcsgf_okqx_-dmNitWkXA@mail.gmail.com>
Date: Mon, 23 Mar 2015 11:01:32 +0000
Message-ID: <CAKk99t0qBOG5Y9e8eJ5S3Ae4MhPrJqOM+6p06G-c3KojO2fSgQ@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai/cobalt: low_init(): binding failed: Function
 not implemented error issued when trting to run latency app on xeno 3.x-rc3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

PS: Version that I am using now

xenomai-3-655dda153fbaba31246963f3011fff194fbecaa8.tar.bz2
<http://git.xenomai.org/xenomai-3.git/snapshot/xenomai-3-655dda153fbaba31246963f3011fff194fbecaa8.tar.bz2>

PS: Version that compiled ok:

xenomai-3-9b8fa963ae6c4751602c00f6be81861b620822af.tar.bz2
<http://git.xenomai.org/xenomai-3.git/snapshot/xenomai-3-9b8fa963ae6c4751602c00f6be81861b620822af.tar.bz2>


On 23 March 2015 at 10:59, Helder Daniel <hdaniel@ualg.pt> wrote:

> Ok,
>
> but now I am compiling a module to write for an I/O port (code below)
> With the previous version of next branch I can compile it without any
> error, insert it check that it is working fine by reading te I/O port from
> an user space app, but with this new version, when compiling the module, I
> get:
>
>  CC [M]  /mnt/hgfs/apps-3.x/10-portAccessSyncKernel/writeportK.o
> In file included from include/xenomai/rtdm/driver.h:43:0,
>                  from
> /mnt/hgfs/apps-3.x/10-portAccessSyncKernel/writeportK.c:8:
> include/xenomai/cobalt/kernel/init.h:24:33: fatal error:
> cobalt/uapi/corectl.h: No such file or directory
>  #include <cobalt/uapi/corectl.h>
>                                  ^
> compilation terminated.
>
> The makefile is just:
>
> obj-m += writeportK.o
>
> $(eval EXTRA_CFLAGS := $(shell xeno-config --kcflags))
>
> all:
> make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
>
>
> And the code of the module:
>
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <rtdm/driver.h>   //defines: rtdm_task_t, rtdm_sem_t, ... (also
> includes rtdm.h)
>
> #define TASK_PRIO  20 //99 is Highest RT priority, 0 is Lowest
>
> #define us 1000 //1000 ns = 1 us (micro sec)
> #define ms 1000000ll //1000000 ns = 1 ms
> #define TASK_PERIOD 500*ms //0.5 secs period
>
> #define COUNT 0x80
> #define DATA  0x81
>
> rtdm_task_t td_pw;  //RTDM task descriptor
> rtdm_sem_t  semA;   //RTDM semaphore descriptor
>
> void writeport (void *arg) {
> static unsigned char count=0;
> int err;
>
> for (;;) {
> err = rtdm_task_wait_period(); //deschedule until next period
> if (err<0) {
> rtdm_printk("writeportK: rtdm_task_wait_period, error %d\n", err);
> break; //avoid kernel corruption when removing module
> //trying to execute code of killed thread
> }
> outb (count, COUNT); //outb takes aprox. 1 Micro sec.
> outb (count%4, DATA); //outb takes aprox. 1 Micro sec.
> rtdm_printk("writeportK: count = %d\n", count); //check with dmesg
> if (++count == 100) count=0;
> }
> }
>
>
> int init_module(void) {
> int err;
>
> err = rtdm_task_init (&td_pw, "writeportK", writeport, NULL, TASK_PRIO,
> TASK_PERIOD);
> if (err < 0) rtdm_printk("writeportK: rtdm_task_init, error %d\n", err);
> else {
> err = rtdm_task_set_period(&td_pw, TASK_PERIOD); //set period
> if (err < 0) rtdm_printk("writeportK: rtdm_task_set_period %d\n", err);
> else rtdm_printk("writeportK successfully loaded\n");
> }
> return err;
> }
>
> void cleanup_module(void) {
> rtdm_task_destroy(&td_pw);
> rtdm_printk("writeportK unloaded\n");
> }
>
> MODULE_LICENSE("GPL");  //To have access to Xenomai symbols
>
>
>
>
>
>
> On 19 March 2015 at 18:29, Philippe Gerum <rpm@xenomai.org> wrote:
>
>> On 03/19/2015 06:23 PM, Philippe Gerum wrote:
>> > On 03/17/2015 06:19 PM, Helder Daniel wrote:
>> >> ok
>> >>
>> >> On 17 March 2015 at 17:10, Philippe Gerum <rpm@xenomai.org
>> >> <mailto:rpm@xenomai.org>> wrote:
>> >>
>> >>     On 03/17/2015 06:06 PM, Helder Daniel wrote:
>> >>     > I am sorry I just found now.
>> >>     > It still happens with Mercury (with the configuration described
>> in the
>> >>     > previous email)
>> >>     >
>> >>     > When I compiled another app and try to run it I got the same
>> error:
>> >>     >
>> >>     > root@debian:~/09-portAccessSyncTwoAppsC++# ./writeport
>> >>     > sysregd:
>> create_directory_recursive("/var/run/xenomai/anon/system"):
>> >>     > Transport endpoint is not connected
>> >>     > sysregd:
>> create_directory_recursive("/var/run/xenomai/anon/system"):
>> >>     > Transport endpoint is not connected
>> >>     > sysregd:
>> create_directory_recursive("/var/run/xenomai/anon/system"):
>> >>     > Transport endpoint is not connected
>> >>     >    3"012.188| WARNING: [main] cannot connect to registry daemon
>> >>     >    3"012.188| BUG: [main] initialization failed, EAGAIN
>> >>
>> >>     Ok. This one is different from the ENOMEM issue, which is
>> >>     Cobalt-specific. The problem with mounting the anon/system root is
>> a
>> >>     FUSE issue, which still needs a work around it seems.
>> >>
>> >
>> > The ENOMEM issue is now fixed in -next. I'll tackle the C++ parsing
>> > problem with libtrank next.
>> >
>>
>> This commit in -next fixes the link stage for the readport/writeport test.
>>
>>
>> http://git.xenomai.org/xenomai-3.git/commit/?h=next&id=f537649c1b69a4f7b6d8f22ef344faf3414fe079
>>
>> --
>> Philippe.
>>
>
>
>
> --
> Helder Daniel
> UALG - FCT
> DEEI
>
> http://w3.ualg.pt/~hdaniel
>



-- 
Helder Daniel
UALG - FCT
DEEI

http://w3.ualg.pt/~hdaniel
