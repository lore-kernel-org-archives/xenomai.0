References: <CAJ2oMhJMf+Tm2UnUW+Ac_OU5duU3Xe9NyXuYS=+jvPNeFjQO_A@mail.gmail.com>
 <CAJ2oMh+YY_cWXdCvp=jEpANX2AmSsC=wOoVFEtZh9XCr9VxQTQ@mail.gmail.com>
From: Marc Le Douarain <marc.le-douarain@laposte.net>
Message-ID: <5dfafb49-9472-81e2-aef3-47276e3326b8@laposte.net>
Date: Mon, 6 Feb 2017 21:39:21 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ2oMh+YY_cWXdCvp=jEpANX2AmSsC=wOoVFEtZh9XCr9VxQTQ@mail.gmail.com>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Build simple application with Xenomai 3.x
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello Ran,

If you modified something in Makefile, others starter people would=20
thanks you to know.

Else, if interested, here you will find a little simple example of a=20
periodic task,
working both with Xenomai 2 and 3, using Posix API (and not native one).
So that the same source code can also be compiled for 'standard' Linux,=20
really usefull !
https://sites.google.com/site/mavati56/others-softwares/xenomai

Best regards.
Marc.

Le 06/02/2017 =E0 11:25, Ran Shalit a =E9crit :
> It seems to be OK now.
> I  had error in Makefile & xenomai configuration.
>
> Thank you,
> Ran
>
> On Mon, Feb 6, 2017 at 12:02 PM, Ran Shalit <ranshalit@gmail.com> wrote:
>> Hello,
>> I have installed xenomai 3.3 with kernel 4.1 ,ubuntu 14.04  and it all
>> seems to work very well, resulting in good performace ~20u  ,tested
>> with cyclictest and latency. (I just has some issue with install,
>> "debuild -uc -us" , seems not to created /usr/xenomai/demo, so I
>> installed again  with "make install")
>>
>> Now, I then tried to build a very simlpe application.
>> Is there a simple code sample with Makefile for xenomai 3 demonstration ?
>>
>> I did find the following link with example:
>> http://www.acadis.org/pages/captain.at/timer-task
>>
>> So I tried it but it gives errors:
>> 1. it first gave the following errors:
>> "...fatal error: native/task.h: No such file or directory"
>> so I changed from:
>> #include <native/task.h>
>> to:
>> #include <trank/native/task.h>
>> Is it correct ? Or should I use  <alchemy/task.h> instead ?
>> 2. I also had to remove <trank/native/intr.h> bevause there is no such f=
ile.
>> 3. Then I got link errors:
>>
>> user@user-desktop:~/rt/xen/myapp$ make
>> gcc -o test test.c -I/usr/xenomai/include/mercury
>> -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__MERCURY__
>> -I/usr/xenomai/include/vxworks -lvxworks  -lcopperplate
>> /usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=3Dmain
>> -Wl,--dynamic-list=3D/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib
>> -lmercury -lpthread -lrt
>> /tmp/cc3dm9ne.o: In function `testtask':
>> test.c:(.text+0x1e): undefined reference to `rt_timer_ns2ticks'
>> test.c:(.text+0x30): undefined reference to `rt_task_set_periodic'
>> test.c:(.text+0x5d): undefined reference to `rt_task_wait_period'
>> /tmp/cc3dm9ne.o: In function `clean_exit':
>> test.c:(.text+0xd3): undefined reference to `rt_task_delete'
>> /tmp/cc3dm9ne.o: In function `main':
>> test.c:(.text+0x14d): undefined reference to `rt_task_spawn'
>> collect2: error: ld returned 1 exit status
>> make: *** [test] Error 1
>> user@user-desktop:~/rt/xen/myapp$
>>
>> The make options seems to include the required library , so I am not
>> sure why I get these link errors.
>>
>>
>> This is the makefile:
>> =3D=3D=3D=3D=3D=3D=3D
>> XENO_CONFIG :=3D /usr/xenomai/bin/xeno-config
>> CFLAGS :=3D $(shell $(XENO_CONFIG) --vxworks --cflags)
>> LDFLAGS :=3D $(shell $(XENO_CONFIG) --vxworks --ldflags)
>> CC :=3D $(shell $(XENO_CONFIG) --cc)
>>
>> EXECUTABLE :=3D test
>>
>> all: $(EXECUTABLE)
>>
>> %: %.c
>>      $(CC) -o $@ $< $(CFLAGS) $(LDFLAGS)
>> =3D=3D=3D=3D=3D=3D
>>
>> Regards,
>> Ran
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai
>


