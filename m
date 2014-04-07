Message-ID: <53428371.9060309@xenomai.org>
Date: Mon, 07 Apr 2014 12:52:33 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAKJ14NdsfwK4Vj=UpYb6p9bvFE=1ZoQb6ss--9f-WqXOXGDn2g@mail.gmail.com>
 <52CAEA4D.1020505@xenomai.org>
 <6FD43B5D-6C35-48E7-BC3C-1414A0B809C9@gmail.com>
 <533E8D1F.7040405@xenomai.org>
 <F7F39021-A6D9-433D-B8F9-917C44A4B6B8@gmail.com> <53416845.70109@xenomai.org>
 <FE59AAA1-DE81-4E92-87FB-6DC3FE49C065@gmail.com>
 <534172B2.8080401@xenomai.org>
 <642D9597-0847-4E99-9BC2-725A943E5CC2@gmail.com>
 <5341C176.1070404@xenomai.org>
 <BE141CF2-C640-4760-85A2-F1B9AA8A4E36@gmail.com>
In-Reply-To: <BE141CF2-C640-4760-85A2-F1B9AA8A4E36@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Command line freeze during xeno-regression-test on
 omap4460
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Glatz <andi.glatz@gmail.com>
Cc: xenomai@xenomai.org

On 04/07/2014 12:18 PM, Andreas Glatz wrote:
> 
> On 6 Apr 2014, at 22:04, Gilles Chanteperdrix wrote:
> 
>> On 04/06/2014 10:57 PM, Andreas Glatz wrote:
>>>
>>> On 6 Apr 2014, at 16:28, Gilles Chanteperdrix wrote:
>>>
>>>> On 04/06/2014 05:22 PM, Andreas Glatz wrote:
>>>>>
>>>>> On 6 Apr 2014, at 15:44, Gilles Chanteperdrix wrote:
>>>>>
>>>>>> On 04/06/2014 01:21 PM, Andreas Glatz wrote:
>>>>>>>
>>>>>>> On 4 Apr 2014, at 11:44, Gilles Chanteperdrix wrote:
>>>>>>>
>>>>>>>> On 04/04/2014 12:27 PM, Andreas Glatz wrote:
>>>>>>>>> Hi Gilles,
>>>>>>>>>
>>>>>>>>> I'm finally back to my original problem below:
>>>>>>>>>
>>>>>>>>> On 6 Jan 2014, at 17:39, Gilles Chanteperdrix wrote:
>>>>>>>>>
>>>>>>>>>> On 01/06/2014 04:30 PM, Andreas Glatz wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> I managed to produce a kernel (v3.8.13) with xenomai 2.6.3
>>>>>>>>>>> ipipe
>>>>>>>>>>> patch and
>>>>>>>>>>> rootfs (debian wheezy) with xenomai 2.6.3 libraries for my
>>>>>>>>>>> Pandaboard ES
>>>>>>>>>>> (omap4460). The simple regression test, which only calls dd
>>>>>>>>>>> during
>>>>>>>>>>> the
>>>>>>>>>>> switchtest, works fine. However the regression test with the
>>>>>>>>>>> linux
>>>>>>>>>>> test
>>>>>>>>>>> project (ltp-full-20130904) scripts causes some sort of  
>>>>>>>>>>> system
>>>>>>>>>>> lock
>>>>>>>>>>> up.
>>>>>>>>>>> After that I only can ctrl-c xeno-regression-test (i.e.
>>>>>>>>>>> switchtest), which,
>>>>>>>>>>> however, doesn't help to regain console access (neigher over
>>>>>>>>>>> ethernet nor
>>>>>>>>>>> serial).
>>>>>>>>>>>
>>>>>>>>>>> Here's what I did:
>>>>>>>>>>>
>>>>>>>>>>> -- Building --
>>>>>>>>>>> As recomended in the Xenomai 2.6 readme I followed the
>>>>>>>>>>> instructions
>>>>>>>>>>> in [1]
>>>>>>>>>>> to produce a kernel and filesystem. To get a xenomai kernel I
>>>>>>>>>>> had
>>>>>>>>>>> to do
>>>>>>>>>>> three things differently:
>>>>>>>>>>>
>>>>>>>>>>> *) I used: git checkout origin/v3.8.x -b tmp
>>>>>>>>>>> *) I applied ipipe-core-3.8.13-arm-3.patch from the  
>>>>>>>>>>> xenomai-2.6
>>>>>>>>>>> git
>>>>>>>>>>> tree as
>>>>>>>>>>> described in the Xenomai 2.6 readme
>>>>>>>>>>> *) I disabled KGDB and TIDSPBRIDGE since those produced  
>>>>>>>>>>> compile
>>>>>>>>>>> errors (see
>>>>>>>>>>> config [2])
>>>>>>>>>>>
>>>>>>>>>>> After a while I obtained the following messages from dmesg  
>>>>>>>>>>> [3]
>>>>>>>>>>> and
>>>>>>>>>>> from the
>>>>>>>>>>> command prompt:
>>>>>>>>>>>
>>>>>>>>>>> root@arm:~# cat /proc/version
>>>>>>>>>>> Linux version 3.8.13-x3.6 (aglatz@linuxvbox) (gcc version  
>>>>>>>>>>> 4.7.3
>>>>>>>>>>> 20130328
>>>>>>>>>>> (prerelease) (crosstool-NG  
>>>>>>>>>>> linaro-1.13.1-4.7-2013.04-20130415 -
>>>>>>>>>>> Linaro GCC
>>>>>>>>>>> 2013.04) ) #4 SMP Sat Jan 4 15:54:20 GMT 2014
>>>>>>>>>>>
>>>>>>>>>>> -- Testing Linux --
>>>>>>>>>>> To see if everything works I downloaded and cross-compiled
>>>>>>>>>>> ltp-full-20130904 [4] with the same toolchain and flags (-
>>>>>>>>>>> march=armv7-a
>>>>>>>>>>> -mfpu=vfp3) as the xenomai libs and runtime. I started ltp  
>>>>>>>>>>> with
>>>>>>>>>>> "./
>>>>>>>>>>> runltp
>>>>>>>>>>> -p -l dohell-2014-01-06-1.log -S xenomai.skiplist" and  
>>>>>>>>>>> after a
>>>>>>>>>>> while it
>>>>>>>>>>> finished with a few failed tests [5]. The console access,
>>>>>>>>>>> however,
>>>>>>>>>>> worked
>>>>>>>>>>> fine.
>>>>>>>>>>>
>>>>>>>>>>> -- Testing Xenomai --
>>>>>>>>>>> First I sucessfully could run the simple xenomai regression
>>>>>>>>>>> test:
>>>>>>>>>>> xeno-regression-test -l "/usr/lib/xenomai/testsuite/dohell - 
>>>>>>>>>>> m /
>>>>>>>>>>> tmp
>>>>>>>>>>> 100" -t
>>>>>>>>>>> 2 which produced the output in [6] and the following  
>>>>>>>>>>> additional
>>>>>>>>>>> messages
>>>>>>>>>>> with dmesg:
>>>>>>>>>>>
>>>>>>>>>>> [  476.215057] Xenomai: RTDM: closing file descriptor 1.
>>>>>>>>>>> [  477.434936] Xenomai: Posix: destroying semaphore f0069c00.
>>>>>>>>>>> [  477.440887] Xenomai: Posix: destroying mutex f0069a00.
>>>>>>>>>>> [  477.475372] xnheap: destroying shared heap 'rt_heap: heap'
>>>>>>>>>>> with
>>>>>>>>>>> 16384
>>>>>>>>>>> bytes still in use.
>>>>>>>>>>> [  479.008453] Xenomai: Switching rt_task to secondary mode
>>>>>>>>>>> after
>>>>>>>>>>> exception
>>>>>>>>>>> #0 from user-space at 0x9620 (pid 2145)
>>>>>>>>>>> [  480.574462] Xenomai: watchdog triggered -- signaling  
>>>>>>>>>>> runaway
>>>>>>>>>>> thread
>>>>>>>>>>> 'rt_task'
>>>>>>>>>>> [  480.582061] [sched_delayed] sched: RT throttling activated
>>>>>>>>>>> [  557.336425] Xenomai: Posix: closing message queue  
>>>>>>>>>>> descriptor
>>>>>>>>>>> 3.
>>>>>>>>>>>
>>>>>>>>>>> and  "cat /proc/xenomai/*" produced [7].
>>>>>>>>>>>
>>>>>>>>>>> When I started the realistic xenomai regression test: xeno-
>>>>>>>>>>> regression-test
>>>>>>>>>>> -l "/usr/lib/xenomai/testsuite/dohell -m /tmp -l /opt/ltp" - 
>>>>>>>>>>> t 2
>>>>>>>>>>> everything
>>>>>>>>>>> seemed fine at first - I could logon and start top to inspect
>>>>>>>>>>> the
>>>>>>>>>>> running
>>>>>>>>>>> processes. However, the command line (over serial and  
>>>>>>>>>>> ethernet)
>>>>>>>>>>> consistently freezes after a while (at different ltp tests
>>>>>>>>>>> though).
>>>>>>>>>>> First I
>>>>>>>>>>> thought it's the massive system load which doesn't leave CPU
>>>>>>>>>>> for
>>>>>>>>>>> the
>>>>>>>>>>> console... however ctrl-c of xeno-regression-test does not  
>>>>>>>>>>> help
>>>>>>>>>>> to
>>>>>>>>>>> regain
>>>>>>>>>>> console access...
>>>>>>>>>>
>>>>>>>>>> That is because kill xeno-regression-test does not kill all  
>>>>>>>>>> the
>>>>>>>>>> script children. So, basically, the load tasks are still
>>>>>>>>>> running.
>>>>>>>>>> Also, what filesystem is /tmp? dohell is using dd to
>>>>>>>>>> alternatively
>>>>>>>>>> write to /tmp, then erase the file. If /tmp is some flash, it
>>>>>>>>>> will
>>>>>>>>>> become slow after a while. If it is a tmpfs, it will eat RAM.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> The described problem is _very_ reproducible on my PandaBoard  
>>>>>>>>> ES
>>>>>>>>> (omap4460), where I boot from an SD card partition and the  
>>>>>>>>> rootfs
>>>>>>>>> is
>>>>>>>>> also on the SD card partition. I tried it with several kernel
>>>>>>>>> versions
>>>>>>>>> (3.8.13, 3.10.18, and 3.10.34) with the latest ipipe and  
>>>>>>>>> xenomai
>>>>>>>>> from
>>>>>>>>> git the git repos. Everytime I start the regression test (see
>>>>>>>>> command
>>>>>>>>> above) the following happens: Everything works fine until the
>>>>>>>>> switch/
>>>>>>>>> latency tests start. Then I see that there is heavy access to  
>>>>>>>>> the
>>>>>>>>> SD
>>>>>>>>> card, which is expected, as the status LED 2 is blinking. After
>>>>>>>>> ~5mins
>>>>>>>>> this status LED is constantly on. That's when I know that
>>>>>>>>> everything
>>>>>>>>> is over. On the console I can only execute commands that are
>>>>>>>>> already
>>>>>>>>> in RAM, such as the bash things like ps, mount, ... However,  
>>>>>>>>> if I
>>>>>>>>> try
>>>>>>>>> a simple 'touch new' it blocks forever and I know that it
>>>>>>>>> blocks in
>>>>>>>>> the syscall where the file should be created, because I  
>>>>>>>>> looked at
>>>>>>>>> it
>>>>>>>>> with strace. I tried several things: I turned off CONFIG_PM
>>>>>>>>> (which
>>>>>>>>> was
>>>>>>>>> on by default), turned on the MMC debugging, put extra  
>>>>>>>>> prink's in
>>>>>>>>> the
>>>>>>>>> omap_hsmmc.c ISR. However, everything seems to work on this
>>>>>>>>> level:
>>>>>>>>> DMA
>>>>>>>>> requests are started and do finish, the ISR is called regularly
>>>>>>>>> (bc
>>>>>>>>> first I though that Xenomai would starve it).
>>>>>>>>>
>>>>>>>>> Have you every run Xenonmai on this _specific_ board (since
>>>>>>>>> everything
>>>>>>>>> is running smoothly on the omap5 board)?
>>>>>>>>> Any more ideas how to debug it?
>>>>>>>>>
>>>>>>>>> Currently, I'm compiling the ipipe trace in hope that it would
>>>>>>>>> tell
>>>>>>>>> me
>>>>>>>>> something useful...
>>>>>>>>>
>>>>>>>>> Oh yes, the best bit is that the regression test works  
>>>>>>>>> perfectly
>>>>>>>>> fine
>>>>>>>>> if I boot from an external USB HD _AND_ unmount (!) all MMC
>>>>>>>>> partitions.
>>>>>>>>
>>>>>>>> So, the MMC driver has a problem. Have you tried:
>>>>>>>> - running the exact same kernel configuration only with
>>>>>>>> CONFIG_XENOMAI
>>>>>>>> disabled (and stress with dohell)
>>>>>>>> - then with CONFIG_XENOMAI and CONFIG_IPIPE disabled.
>>>>>>>>
>>>>>>>> Also, do you have this patch in the tree you tried?
>>>>>>>> http://git.xenomai.org/ipipe.git/commit/?h=stable/ipipe-3.10.18&id=c26e7ad5679f9391cd8ea1db001bf301d2f6bc88
>>>>>>>>
>>>>>>>
>>>>>>> First i mounted tmpfs on /tmp so I don't wear out the SD card too
>>>>>>> much:
>>>>>>> mount -t tmpfs -osize=192M tmpfs /tmp
>>>>>>>
>>>>>>> Then I used the following line to start the test (substitute  
>>>>>>> MYTEST
>>>>>>> below with the following line):
>>>>>>> /usr/lib/xenomai/testsuite/dohell -m /tmp -l /opt/ltp
>>>>>>>
>>>>>>> Note: I always monitored the test over wifi with 'top' so I also
>>>>>>> had
>>>>>>> some network load...
>>>>>>>
>>>>>>> I got the following results with the 3.10.34 kernel, which  
>>>>>>> includes
>>>>>>> everything up to the current ipipe-3.10 tag (it also included the
>>>>>>> patch you mentioned):
>>>>>>>
>>>>>>> - xeno-regression-test "MYTEST" -> FAIL if booted from SD card  
>>>>>>> (see
>>>>>>> description above); OK if booted from ext USB HD _AND_ no mmc
>>>>>>> partitions mounted
>>>>>>> - CONFIG_IPIPE && CONFIG_XENOMAI && MYTEST -> FAIL (got status
>>>>>>> LED 2
>>>>>>> constantly on as described above)
>>>>>>> - CONFIG_IPIPE && MYTEST -> OK (see attached config file and ltp
>>>>>>> test
>>>>>>> log)
>>>>>>>
>>>>>>> Anything else I should try?
>>>>>>
>>>>>> Is the current LTP test when the failure happens always the same?
>>>>>>
>>>>>>
>>>>>
>>>>> I went through all the logfiles on my pandaboard and and identified
>>>>> the last tests that ltp logged before the error occurred (I'm
>>>>> assuming
>>>>> that ltp writes to the file in /opt/ltp/results after completing  
>>>>> the
>>>>> test since there is the PASS/FAIL note as well, which logically
>>>>> should
>>>>> only be available after completing the test):
>>>>>
>>>>> test                               count
>>>>> ========================
>>>>> rt_sigqueueinfo01    1
>>>>> clock_nanosleep01 10
>>>>> munmap02                1
>>>>> semget06                   1
>>>>> epoll_create1_01     5
>>>>> splice01                      1
>>>>> clock_getres01          1
>>>>> rename13                   1
>>>>> BindMounts                1
>>>>> utimes01                     1
>>>>>
>>>>> So it seems that the test after 'clock_nanosleep01', which is
>>>>> 'clone01' according to the LTP log file I sent you, seems to be the
>>>>> prime hotspot of failure followed by 'epoll01', which comes after
>>>>> 'epoll_create1_01'.
>>>>>
>>>>> I'm using the standard LTP version 'ltp-full-20130904', which I
>>>>> downloaded and compiled on the target with gcc 4.6.3 (default  
>>>>> debian
>>>>> wheezy).
>>>>
>>>> Ok. I am not sure it is meaningful. Anyway, the only difference
>>>> between
>>>> CONFIG_XENOMAI + CONFIG_IPIPE and CONFIG_IPIPE alone, provided that
>>>> you
>>>> are not running any program using Xenomai, is the host tick  
>>>> emulation.
>>>>
>>>> So, could you please try to turn off
>>>> CONFIG_NO_HZ_IDLE
>>>> CONFIG_NO_HZ
>>>> CONFIG_HIGH_RES_TIMERS
>>>>
>>>> And see if it works better?
>>>>
>>>
>>> As I wrote before, I recompiled the Kernel with your timer options  
>>> and
>>> CONFIG_XENOMAI, installed it, synced it and rebooted after cutting  
>>> the
>>> power to the board for ~10secs.
>>>
>>> It seems with those options it got much further with the tests.
>>> However, eventually all ssh connections broke up and the last  
>>> messages
>>> on the console, where I started do hell were:
>>>
>>> [...]
>>> 102400000 bytes (102 MB) copied, 2.97674 s, 34.4 MB/s
>>> 100+0 records in
>>> 100+0 records out
>>> 102400000 bytes (102 MB) copied, 1.97433 s, 51.9 MB/s
>>> 100+0 records in
>>> 100+0 records out
>>> 102400000 bytes (102 MB) copied, 2.68371 s, 38.2 MB/s
>>> 100+0 records in
>>> 100+0 records out
>>> 102400000 bytes (102 MB) copied, 2.57073 s, 39.8 MB/s
>>> dd: writing `/tmp/bigfile': No space left on device
>>> 7+0 records in
>>> 6+0 records out
>>> 6164480 bytes (6.2 MB) copied, 0.189001 s, 32.6 MB/s
>>> /usr/lib/xenomai/testsuite/dohell: 62: /usr/lib/xenomai/testsuite/
>>> dohell: Cannot fork
>>
>> This may simply be due to some LTP test which forks a lot and prevent
>> the system from being able to fork. This should be a temporary  
>> solution.
>>
>>> Write failed: Host is down
>>>
>>> ... and as usuall status LED 2 is permanently on.
>>>
>>> As u suspect there's something wrong with the timer subsystem I  
>>> looked
>>> around a bit what extra patches went into the 3.10.14 kernel of
>>> RobertCNelson, which I used as a base to merge the ipipe git tree.
>>> Here is the list:
>>>
>>> 0001-panda-fix-wl12xx-regulator.patch
>>> 0002-ti-st-st-kim-fixing-firmware-path.patch
>>> 0003-Panda-expansion-add-spidev.patch
>>> 0004-HACK-PandaES-disable-cpufreq-so-board-will-boot.patch
>>> 0005-HACK-panda-enable-OMAP4_ERRATA_I688.patch
>>> 0006-ARM-hw_breakpoint-Enable-debug-powerdown-only-if-sys.patch
>>> 0007-Revert-regulator-twl-Remove-TWL6030_FIXED_RESOURCE.patch
>>> 0008-Revert-regulator-twl-Remove-another-unused-variable-.patch
>>> 0009-Revert-regulator-twl-Remove-references-to-the-twl403.patch
>>> 0010-Revert-regulator-twl-Remove-references-to-32kHz-cloc.patch
>>> 0011-panda-spidev-setup-pinmux.patch
>>>
>>> Do you think those may have something to do with it?
>>
>> I do not think so. When the LED is still on, can you use the serial
>> console to run cat /proc/interrupts to see if the timer is still  
>> ticking?
>>
> 
> I ran the test again with the same kernel and traced the messages from  
> the serial console with minicom. Again, the test ran for quite some  
> time until I got stacktraces similar to [1] (which might be just  
> related to the ltp memcg test).
> 
> However, after these stacktraces I got the following message on the  
> serial console (LED2 also went on and stayed on):
> 
> [...]
> [ 6674.540000] omap_hsmmc omap_hsmmc.0: MMC start dma failure
> [ 6674.540000] mmcblk0: unknown error -22 sending read/write command,  
> card status 0x900
> [ 6674.550000] end_request: I/O error, dev mmcblk0, sector 12751744
> [ 6674.560000] EXT4-fs warning (device mmcblk0p2):  
> __ext4_read_dirblock:908: error reading directory block (ino 397703,  
> block 0)
> [...]
> [ 6932.610000] omap_hsmmc omap_hsmmc.0: MMC start dma failure
> [ 6932.610000] mmcblk0: unknown error -22 sending read/write command,  
> card status 0x900
> [ 6932.620000] end_request: I/O error, dev mmcblk0, sector 21142904
> [ 6932.630000] EXT4-fs warning (device mmcblk0p2):  
> __ext4_read_dirblock:908: error reading directory block (ino 657554,  
> block 0)
> [...]
> 
> Although dd is still running on minicom, I lost the ssh connection  
> over Ethernet (and I couldn't get it back even after unconnecting and  
> reconnecting the cable, which didn't cause any PHY interrupt in dmesg  
> as well) and I cannot Ctrl-C or do anything on the serial console... I  
> just see dd, which was started by dohell, getting invoked.

What I meant is to use minicom as a console, already logged in, doing
nothing, ready to be used when the bug happens.

Anyway, I think there is no way around understanding the MMC driver now.

The bug when starting DMA may simply be due to the fact that all
previous DMAs stalled.

Will look at this if I can reproduce it on my panda (it is currently
testing the I-pipe for 3.14, but when it is finished, I will try and
reproduce the bug).


-- 
                                                                Gilles.

