References: <55DF2471.6030006@cern.ch> <55DF2868.2070804@xenomai.org>
From: Konstantinos Chalas <konstantinos.chalas@cern.ch>
Message-ID: <55DF32E3.1010706@cern.ch>
Date: Thu, 27 Aug 2015 17:55:15 +0200
MIME-Version: 1.0
In-Reply-To: <55DF2868.2070804@xenomai.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Cyclictest in Xenomai-3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

The build command for cyclictest was

gcc -Wall -Wno-nonnull -I/usr/xenomai/include/cobalt 
-I/usr/xenomai/include -march=armv7-a -mfpu=vfp3 -D_GNU_SOURCE 
-D_REENTRANT -D__COBALT__ -O2 -Wl,@/usr/xenomai/lib/cobalt.wrappers 
/usr/xenomai/lib/xenomai/bootstrap.o -Wl,--wrap=main 
-Wl,--dynamic-list=/usr/xenomai/lib/dynlist.ld -L/usr/xenomai/lib 
-lcobalt -lpthread -lrt -march=armv7-a -mfpu=vfp3   -o cyclictest 
cyclictest.o -lrt -lpthread -lrttest -L

Also the clock calibration is (i already run the autotune utility),

root@beaglebone:~# cat /proc/xenomai/clock/coreclk
gravity: irq=499 kernel=1999 user=4999
devices: timer=timer2, clock=ipipe_tsc
  status: on
   setup: 999
   ticks: 350959191461

and finally i run cyclictest with Thanks for the interest!

cyclictest -n -p 99 -D 1000 -i 250 -m Thanks for the interest!**
On 08/27/2015 05:10 PM, Philippe Gerum wrote:
> On 08/27/2015 04:53 PM, Konstantinos Chalas wrote:
>> Hello everyone,
>>
>> Is there any plans to port cyclictest over at xenomai-3 for the Cobalt
>> kernel? I compiled the original source file from the rt-tests repo my
>> self for xenomai-3,. For reference i used to get around 70 us worst case
>> with the Beaglebone black using Xenomai-2, but it goes up to 200 us
>> immediatly with the one i compiled. By the way, i followed the
>> xeno-config procedure. Is there anyone who cares to provide an explanation?
>>
> Any information about the exact build command used, the clock
> calibration from /proc/xenomai/clock/coreclk, and the options passed to
> cyclictest?
>
> Btw, the vanilla cyclictest code had to be adapted for running over
> Xenomai 2.
>

