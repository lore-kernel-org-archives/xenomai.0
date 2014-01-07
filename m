MIME-Version: 1.0
In-Reply-To: <CAKJ14NdEUTDywB=TY+azn+HE=nqcpNmL7f3cOD7E8p2JT3TUMg@mail.gmail.com>
References: <CAKJ14NdsfwK4Vj=UpYb6p9bvFE=1ZoQb6ss--9f-WqXOXGDn2g@mail.gmail.com>
 <52CAEA4D.1020505@xenomai.org>
 <CAKJ14NdEUTDywB=TY+azn+HE=nqcpNmL7f3cOD7E8p2JT3TUMg@mail.gmail.com>
Date: Tue, 7 Jan 2014 08:10:04 +0000
Message-ID: <CAKJ14Ndj_eWoGd89afA_5meif6x+bjBnJ0jDrBheR-xv3p1pVA@mail.gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

 Hi Gilles,


On Tue, Jan 7, 2014 at 7:23 AM, Andreas Glatz <andi.glatz@gmail.com> wrote:

> Hi Gilles,
>
> At first /tmp was tmpfs since I didn't want to wear out my flash with the
> testing. Now I connected an external usb harddrive to the panda and mounted
> one of the harddrive partions as /tmp. Additionally, I did not load
> xeno_klat and xeno_rtdmtest, which were both in before. I started
> xeno-regression-test -l "/usr/lib/xenomai/testsuite/dohell -m /tmp -l
> /opt/ltp" -t 2 again (btw I modified dohell to call runltp instead of
> runallscripts.sh since the latter is deprecated). And the good news was
> that it ran nearly all the tests (everything up to cgroup*) and 'top' was
> working all the way. However this morning I noticed that it's still at the
> first test of the cgroup* and didn't go any further. 'top' stopped working
> and i cannot open additional consoles. On the consoles that are still open
> (3 of them) I can execute simple commands like ps, grep, df, ... but
> nothing like reboot, top, shutdown, ... Suprisingly, cat /var/log/messages
> also gets blocked:
>
> Console 1:
> root@arm:~# cat /var/log/messages
> ^C # <-- notice: I tried to kill it here but no response
>
> Console 2:
> root@arm:/opt/ltp/results# ps ax
>   PID TTY      STAT   TIME COMMAND
> ...
> 15149 pts/2    D+     0:00 cat /var/log/messages
> ...
>
> Nothing else is running though (neither on linux nor xenomai) :
> root@arm:/opt/ltp/results# cat /proc/xenomai/stat
> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>   0  0      0          986564     0     00500080  100.0  ROOT/0
>   1  0      0          992712     0     00500080  100.0  ROOT/1
>   1  0      0          309543     0     00000000    0.0  IRQ29: [timer]
>
> To me this looks like a problem with the filesystem (maybe my sd flash
> card where the rootfs resides). I will try and install the rootfs on the
> external harddrive and repreat everything... maybe this might solve the
> problem.
>


Firstly sorry for the toppost :)

Secondly, I also noticed that the status led on the panda, which is
triggered by mmc0, is constantly on after failure, whereas it turns only on
when accessing the flash partition after a reboot. So I guest that's a good
indication that mmc0 might have something to do with it?

A.




>
> I still have all three consoles open, where just one is still repsonsive.
> Any further suggestions?
>
> Thanks for any help,
>
> A.
>
>
>
>
>
> On Mon, Jan 6, 2014 at 5:39 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
>
>> On 01/06/2014 04:30 PM, Andreas Glatz wrote:
>>
>>> Hi,
>>>
>>> I managed to produce a kernel (v3.8.13) with xenomai 2.6.3 ipipe patch
>>> and
>>> rootfs (debian wheezy) with xenomai 2.6.3 libraries for my Pandaboard ES
>>> (omap4460). The simple regression test, which only calls dd during the
>>> switchtest, works fine. However the regression test with the linux test
>>> project (ltp-full-20130904) scripts causes some sort of system lock up.
>>> After that I only can ctrl-c xeno-regression-test (i.e. switchtest),
>>> which,
>>> however, doesn't help to regain console access (neigher over ethernet nor
>>> serial).
>>>
>>> Here's what I did:
>>>
>>> -- Building --
>>> As recomended in the Xenomai 2.6 readme I followed the instructions in
>>> [1]
>>> to produce a kernel and filesystem. To get a xenomai kernel I had to do
>>> three things differently:
>>>
>>> *) I used: git checkout origin/v3.8.x -b tmp
>>> *) I applied ipipe-core-3.8.13-arm-3.patch from the xenomai-2.6 git tree
>>> as
>>> described in the Xenomai 2.6 readme
>>> *) I disabled KGDB and TIDSPBRIDGE since those produced compile errors
>>> (see
>>> config [2])
>>>
>>> After a while I obtained the following messages from dmesg [3] and from
>>> the
>>> command prompt:
>>>
>>> root@arm:~# cat /proc/version
>>> Linux version 3.8.13-x3.6 (aglatz@linuxvbox) (gcc version 4.7.3 20130328
>>> (prerelease) (crosstool-NG linaro-1.13.1-4.7-2013.04-20130415 - Linaro
>>> GCC
>>> 2013.04) ) #4 SMP Sat Jan 4 15:54:20 GMT 2014
>>>
>>> -- Testing Linux --
>>> To see if everything works I downloaded and cross-compiled
>>> ltp-full-20130904 [4] with the same toolchain and flags (-march=armv7-a
>>> -mfpu=vfp3) as the xenomai libs and runtime. I started ltp with "./runltp
>>> -p -l dohell-2014-01-06-1.log -S xenomai.skiplist" and after a while it
>>> finished with a few failed tests [5]. The console access, however, worked
>>> fine.
>>>
>>> -- Testing Xenomai --
>>> First I sucessfully could run the simple xenomai regression test:
>>> xeno-regression-test -l "/usr/lib/xenomai/testsuite/dohell -m /tmp 100"
>>> -t
>>> 2 which produced the output in [6] and the following additional messages
>>> with dmesg:
>>>
>>> [  476.215057] Xenomai: RTDM: closing file descriptor 1.
>>> [  477.434936] Xenomai: Posix: destroying semaphore f0069c00.
>>> [  477.440887] Xenomai: Posix: destroying mutex f0069a00.
>>> [  477.475372] xnheap: destroying shared heap 'rt_heap: heap' with 16384
>>> bytes still in use.
>>> [  479.008453] Xenomai: Switching rt_task to secondary mode after
>>> exception
>>> #0 from user-space at 0x9620 (pid 2145)
>>> [  480.574462] Xenomai: watchdog triggered -- signaling runaway thread
>>> 'rt_task'
>>> [  480.582061] [sched_delayed] sched: RT throttling activated
>>> [  557.336425] Xenomai: Posix: closing message queue descriptor 3.
>>>
>>> and  "cat /proc/xenomai/*" produced [7].
>>>
>>> When I started the realistic xenomai regression test:
>>> xeno-regression-test
>>> -l "/usr/lib/xenomai/testsuite/dohell -m /tmp -l /opt/ltp" -t 2
>>> everything
>>> seemed fine at first - I could logon and start top to inspect the running
>>> processes. However, the command line (over serial and ethernet)
>>> consistently freezes after a while (at different ltp tests though).
>>> First I
>>> thought it's the massive system load which doesn't leave CPU for the
>>> console... however ctrl-c of xeno-regression-test does not help to regain
>>> console access...
>>>
>>
>> That is because kill xeno-regression-test does not kill all the script
>> children. So, basically, the load tasks are still running. Also, what
>> filesystem is /tmp? dohell is using dd to alternatively write to /tmp, then
>> erase the file. If /tmp is some flash, it will become slow after a while.
>> If it is a tmpfs, it will eat RAM.
>>
>> --
>>                                             Gilles.
>>
>
>
