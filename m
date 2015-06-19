Message-ID: <5584079E.2090000@siemens.com>
Date: Fri, 19 Jun 2015 14:14:22 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <7B9254AC-C035-4D61-884E-8C9B3706A22B@gmail.com>
 <5581BE6F.4030607@siemens.com>
 <624126A3-294C-48BF-A099-2AA8E000FE11@gmail.com>
In-Reply-To: <624126A3-294C-48BF-A099-2AA8E000FE11@gmail.com>
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
To: Michael Haberler <haberlerm@gmail.com>, Wolfgang Grandegger <wg@grandegger.com>
Cc: xenomai <xenomai@xenomai.org>

On 2015-06-19 12:14, Michael Haberler wrote:
> Jan - thanks! I made minor progress. duh on the mknod..
> 
> I switched to a more recent kernel: http://static.mah.priv.at/public/3.18.13-rt10/
> hardware=Gigabyte Technology Co., Ltd. To be filled by O.E.M./J1900N-D3V, BIOS F3 04/29/2014
> 
> mutated to the kthread API  (approximate - no idea if correct, but previous task error gone): https://github.com/mhaberler/rtdm-native/commits/try1 6e13d3
> 
> 
> some results - not sure if this is actual progress as I have a hard time telling what the expected output should be
> 
> I _think_ mutex and event tests are OK (modulo event rc, see below), sema seems to need more love:
> 
> 
> 
> insmod ./rtdm.ko
> insmod ./rtdmtest.ko
> dmesg
> ...
> [35584.519628] starting RTDM services.
> [35596.986261] __rtdmtest_init: registering device rttest0, err=250
> 
> mknod /dev/rttest0 c 250 0
> 
> 
> --- no option - seems to look good:
> 
> root@j1900:/home/mah/rtdm-native/examples/rtdm-native# ./rtdmtest
> Events 0/0 Sems 0/0 Mutex 0
> Events 488/488 Sems 0/0 Mutex 0
> Events 979/979 Sems 0/0 Mutex 0
> Events 1471/1471 Sems 0/0 Mutex 0
> Events 1962/1962 Sems 0/0 Mutex 0
> Events 2449/2449 Sems 0/0 Mutex 0
> Events 2934/2934 Sems 0/0 Mutex 0
> Events 3425/3425 Sems 0/0 Mutex 0
> Events 3916/3916 Sems 0/0 Mutex 0
> Events 4408/4408 Sems 0/0 Mutex 0
> ^Csighand: signal=2
> Exiting event_signal_thread
> Exiting event_wait_thread
> Events 4535/4535 Sems 0/0 Mutex 0
> Canceling threads
> Join wait thread
> Join signal thread
> Exit...
> 
> dmesg
> [35684.441898] rtdmtest_close state=0x0
> 
> 
> --- mutex test option, good too ?
> 
> root@j1900:/home/mah/rtdm-native/ksrc/drivers/testing# /home/mah/rtdm-native/examples/rtdm-native/rtdmtest -m -c 10
> Events 0/0 Sems 0/0 Mutex 0
> Events 0/0 Sems 0/0 Mutex 493
> Events 0/0 Sems 0/0 Mutex 986
> Events 0/0 Sems 0/0 Mutex 1479
> Events 0/0 Sems 0/0 Mutex 1972
> Events 0/0 Sems 0/0 Mutex 2465
> Events 0/0 Sems 0/0 Mutex 2958
> Events 0/0 Sems 0/0 Mutex 3451
> ^Csighand: signal=2
> ioctl MUTEX_TEST: Identifier removed
> Events 0/0 Sems 0/0 Mutex 3712
> Mutex lock count: 3712 (3712)
> Canceling threads
> Join wait thread
> Join signal thread
> Exit...
> 
> dmesg
> [  392.644744] RTTST_RTIOC_RTDMTEST_MUTEX_GETSTAT
> [  392.654617] rtdmtest_close state=0x0
> 
> 
> ---- event test, close rc looks suspicious:
> 
> root@j1900:/home/mah/rtdm-native/ksrc/drivers/testing# vi /home/mah/rtdm-native/examples/rtdm-native/rtdmtest.c
> root@j1900:/home/mah/rtdm-native/ksrc/drivers/testing# /home/mah/rtdm-native/examples/rtdm-native/rtdmtest -e -c 10
> ioctl EVENT_WAIT: Identifier removed
> Exiting event_signal_thread
> Exiting event_wait_thread
> Events 10/10 Sems 0/0 Mutex 0
> Canceling threads
> Join wait thread
> Join signal thread
> Exit...
> 
> dmesg
> [  453.515225] rtdmtest_close state=0x4           <--------- 0x4 - suspicious?
> 

Wolfgang, do you have in memory how these tests should look like when
all was fine?

> 
> ---- sema test, oopses and locks up:
> ---- screenshot  http://snag.gy/GWFDe.jpg
> 

Serial logs preferred (the top of the error message is missing)... Or
stick everything into the KVM machine and debug from there.

> 
> root@j1900:/home/mah/rtdm-native/ksrc/drivers/testing# /home/mah/rtdm-native/examples/rtdm-native/rtdmtest -s -c 10
> 
> Message from syslogd@j1900 at Jun 19 11:58:55 ...
>  kernel:[  511.115390] CPU: 0 PID: 2004 Comm: rtdmtest Tainted: G           O   3.18.13-rt10mah+ #1
> 
> Message from syslogd@j1900 at Jun 19 11:58:55 ...
>  kernel:[  511.115392] Hardware name: Gigabyte Technology Co., Ltd. To be filled by O.E.M./J1900N-D3V, BIOS F3 04/29/2014
> 
> Message from syslogd@j1900 at Jun 19 11:58:55 ...
>  kernel:[  511.115396] task: f37de600 ti: f4c8c000 task.ti: f4c8c000
> 
> Message from syslogd@j1900 at Jun 19 11:58:55 ...
>  kernel:[  511.115418] Stack:
> 
> Message from syslogd@j1900 at Jun 19 11:58:55 ...
>  kernel:[  511.115438] Call Trace:
> 
> Message from syslogd@j1900 at Jun 19 11:58:55 ...
>  kernel:[  511.115583] Code: 8b 35 74 d6 53 c1 e8 2d 0a 00 00 31 c9 89 f2 6a 01 89 d8 e8 60 24 d3 ff 5f 85 c0 0f 85 37 01 00 00 8b 43 0c 83 e0 fe 39 c6 75 02 <0f> 0b 8d be dc 04 00 00 89 f8 e8 13 0a 00 00 8b 06 89 46 04 64
> 
> Message from syslogd@j1900 at Jun 19 11:58:55 ...
>  kernel:[  511.115590] EIP: [<c13270c3>] rt_spin_lock_slowlock+0x54/0x190 SS:ESP 0068:f4c8de1c
> 
> 
> 

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

