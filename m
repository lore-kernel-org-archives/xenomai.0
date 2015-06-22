Message-ID: <55882ED8.7040304@siemens.com>
Date: Mon, 22 Jun 2015 17:50:48 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <7B9254AC-C035-4D61-884E-8C9B3706A22B@gmail.com>
 <5581BE6F.4030607@siemens.com>
 <624126A3-294C-48BF-A099-2AA8E000FE11@gmail.com>
 <5584079E.2090000@siemens.com>
 <316F216B-1C02-4EE7-92B8-10FC6DCF6761@gmail.com>
 <55841ABE.9090809@siemens.com>
 <9BD99D42-5187-413A-986F-A04189721344@gmail.com>
 <D5554168-F567-47B1-838D-51DBC3B59703@gmail.com>
In-Reply-To: <D5554168-F567-47B1-838D-51DBC3B59703@gmail.com>
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

On 2015-06-22 17:34, Michael Haberler wrote:
> I now get all tests to pass (as far as I can tell), see below

Nice!

> 
> Has anybody ever gone beyond running rtdmtest with this, like building an actual driver? 
> 
> before I spend time on it - did the can and serial drivers actually work?

Did you search the archive / announcements in this regard? Also adding
Wolfgang once again.

Jan

> 
> - Michael
> 
> ---
> 
> Fixed by changing  add_wait_queue_exclusive_locked() to __add_wait_queue_tail_excl()  and
> remove_wait_queue_locked() to  __remove_wait_queue() as outlined here: http://permalink.gmane.org/gmane.linux.file-systems/40051
> 
> the error message I reported earlier on is simply an result of the rtdmtest driver calling rtdm_task_destroy(&task)  and rtdm_task_join_nrt(&task, 100) on module exit without having actually created an rtdm task, so  pretty sure this already existed
> 
> [  154.523718] rtdm_task_destroy: not allowed on user threads
> [  154.529468] rtdm_task_join_nrt: not allowed on user threads
> 
> status: https://github.com/mhaberler/rtdm-native/commit/2de7f03fa2682af63f2d6e1ea321761f7277d64f
> 
> execution logs:
> 
> root@j1900:/home/mah/rtdm-native/examples/rtdm-native# ./rtdmtest
> Events 0/0 Sems 0/0 Mutex 0
> Events 483/483 Sems 0/0 Mutex 0
> Events 966/966 Sems 0/0 Mutex 0
> Events 1448/1448 Sems 0/0 Mutex 0
> Events 1932/1932 Sems 0/0 Mutex 0
> Events 2423/2423 Sems 0/0 Mutex 0
> Events 2914/2914 Sems 0/0 Mutex 0
> Events 3400/3400 Sems 0/0 Mutex 0
> Events 3884/3884 Sems 0/0 Mutex 0
> Events 4367/4367 Sems 0/0 Mutex 0
> Events 4854/4854 Sems 0/0 Mutex 0
> Events 5345/5345 Sems 0/0 Mutex 0
> Events 5832/5832 Sems 0/0 Mutex 0
> Events 6321/6321 Sems 0/0 Mutex 0
> Events 6812/6812 Sems 0/0 Mutex 0
> Events 7303/7303 Sems 0/0 Mutex 0
> Events 7793/7793 Sems 0/0 Mutex 0
> Events 8284/8284 Sems 0/0 Mutex 0
> Events 8775/8775 Sems 0/0 Mutex 0
> Events 9266/9266 Sems 0/0 Mutex 0
> ^Csighand: signal=2
> Exiting event_signal_thread
> Exiting event_wait_thread
> Events 9347/9347[94398.084126] rtdmtest_close state=0x0
>  Sems 0/0 Mutex 0
> Canceling threads
> Join wait thread
> Join signal thread
> Exit...
> 
> 
> root@j1900:/home/mah/rtdm-native/examples/rtdm-native# ./rtdmtest -m -c 10
> Events 0/0 Sems 0/0 Mutex 0
> Events 0/0 Sems 0/0 Mutex 492
> Events 0/0 Sems 0/0 Mutex 985
> Events 0/0 Sems 0/0 Mutex 1477
> Events 0/0 Sems 0/0 Mutex 1970
> Events 0/0 Sems 0/0 Mutex 2462
> Events 0/0 Sems 0/0 Mutex 2955
> Events 0/0 Sems 0/0 Mutex 3447
> Events 0/0 Sems 0/0 Mutex 3940
> Events 0/0 Sems 0/0 Mutex 4433
> Events 0/0 Sems 0/0 Mutex 4925
> Events 0/0 Sems 0/0 Mutex 5418
> Events 0/0 Sems 0/0 Mutex 5910
> Events 0/0 Sems 0/0 Mutex 6403
> Events 0/0 Sems 0/0 Mutex 6896
> ^Csighand: signal=2
> ioctl MUTEX_TEST: Identifier removed
> [94428.098513] RTTST_RTIOC_RTDMTEST_MUTEX_GETSTAT
> Events 0/0 Sems [94428.103216] rtdmtest_close state=0x0
> 0/0 Mutex 7083
> Mutex lock count: 7083 (7083)
> Canceling threads
> Join wait thread
> Join signal thread
> Exit...
> 
> 
> root@j1900:/home/mah/rtdm-native/examples/rtdm-native# dmesg 
> [94398.084126] rtdmtest_close state=0x0
> [94428.098513] RTTST_RTIOC_RTDMTEST_MUTEX_GETSTAT
> [94428.103216] rtdmtest_close state=0x0
> root@j1900:/home/mah/rtdm-native/examples/rtdm-native# ./rtdmtest -e -c 10
> ioctl EVENT_WAIT: Identifier removed
> Exiting event_wait_thread
> Exiting event_signal_thread
> [94466.305761] rtdmtest_close state=0x4
> Events 10/10 Sems 0/0 Mutex 0
> Canceling threads
> Join wait thread
> Join signal thread
> Exit...
> 
> 
> root@j1900:/home/mah/rtdm-native/examples/rtdm-native# ./rtdmtest -s -c 10
> ioctl SEM_DOWN: [94547.555904] rtdm_nrtsig_handler called
> Identifier removed
> [94548.546266] rtdmtest_close state=0x0
> Events 0/0 Sems 10/10 Mutex 0
> Canceling threads
> Join wait thread
> Join signal thread
> Exit...
> 
> 
> dmesg after above runs:
> 
> root@j1900:~# dmesg 
> [   89.364268] starting RTDM services.
> [   93.597113] __rtdmtest_init: registering device rttest0, err=250
> [  177.201902] rtdmtest_close state=0x0
> [  190.092607] RTTST_RTIOC_RTDMTEST_MUTEX_GETSTAT
> [  190.097406] rtdmtest_close state=0x0
> [  199.686598] rtdmtest_close state=0x4
> [  207.570485] rtdm_nrtsig_handler called
> [  208.561437] rtdmtest_close state=0x0
> 

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

