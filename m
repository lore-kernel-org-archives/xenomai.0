MIME-Version: 1.0
Date: Mon, 26 Sep 2011 23:28:16 +0200
Message-ID: <CAMJ=MEeevXWzJg8O9jz5JxutNCj=EOHU=Xc93+NzjSFya4O5uA@mail.gmail.com>
From: Ronny Meeus <ronny.meeus@domain.hid>
Content-Type: multipart/mixed; boundary=0016364ed8344c9f4504added6ce
Subject: [Xenomai-help] Xenomai-forge: tm_evafter without tm_cancel causes
	memory leaks.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

--0016364ed8344c9f4504added6ce
Content-Type: text/plain; charset=ISO-8859-1

Hello

As for as I know it is not mandatory call tm_cancel on a one-shot
timer to cleanup the resources in the OS.
This means that if the timer expires, the event is sent and all
resources are released by pSOS at that time.

Since I did not see a test for this in the testsuite, I created one
myself (in fact 2, see attachments).
This time it is a small piece of code :-).
In this test I create a task that starts 100 events timers
(tm_evafter) but does not stop them (no tm_cancel is called).

In the first test (tm-10.c) I create a task that starts 100 timers,
sleeps some time and deletes itself.
This sleeping allows the timers to expire. This is the result if I run valgrind:

meeusr@domain.hid$ sudo
LD_LIBRARY_PATH=/home/meeusr/repo/xenomai-forge-install/lib/ valgrind
--leak-check=full ./tm-10
==2399== Memcheck, a memory error detector
==2399== Copyright (C) 2002-2009, and GNU GPL'd, by Julian Seward et al.
==2399== Using Valgrind-3.6.0.SVN-Debian and LibVEX; rerun with -h for
copyright info
==2399== Command: ./tm-10
==2399==
^C==2399==
==2399== HEAP SUMMARY:
==2399==     in use at exit: 11,090 bytes in 203 blocks
==2399==   total heap usage: 311 allocs, 108 frees, 13,646 bytes allocated
==2399==
==2399== 136 bytes in 1 blocks are possibly lost in loss record 2 of 5
==2399==    at 0x402425F: calloc (vg_replace_malloc.c:467)
==2399==    by 0x4010CDB: _dl_allocate_tls (dl-tls.c:300)
==2399==    by 0x405C2E2: pthread_create@domain.hid (allocatestack.c:561)
==2399==    by 0x402F9F1: t_create (task.c:307)
==2399==    by 0x80486F0: main (tm-10.c:27)
==2399==
==2399== 136 bytes in 1 blocks are possibly lost in loss record 3 of 5
==2399==    at 0x402425F: calloc (vg_replace_malloc.c:467)
==2399==    by 0x4010CDB: _dl_allocate_tls (dl-tls.c:300)
==2399==    by 0x405C2E2: pthread_create@domain.hid (allocatestack.c:561)
==2399==    by 0x4074201: __start_helper_thread (timer_routines.c:184)
==2399==    by 0x406142F: pthread_once (pthread_once.S:122)
==2399==    by 0x403EBFA: timerobj_init (timerobj-mercury.c:69)
==2399==    by 0x403056F: start_evtimer (tm.c:101)
==2399==    by 0x4030623: tm_evafter (tm.c:126)
==2399==    by 0x804865D: task (tm-10.c:13)
==2399==    by 0x402F559: task_trampoline (task.c:193)
==2399==    by 0x405B96D: start_thread (pthread_create.c:300)
==2399==    by 0x4145A4D: clone (clone.S:130)
==2399==
==2399== 5,200 bytes in 100 blocks are possibly lost in loss record 4 of 5
==2399==    at 0x4024F20: malloc (vg_replace_malloc.c:236)
==2399==    by 0x403FFB8: pvmalloc (heapobj-malloc.c:75)
==2399==    by 0x40304B8: start_evtimer (tm.c:81)
==2399==    by 0x4030623: tm_evafter (tm.c:126)
==2399==    by 0x804865D: task (tm-10.c:13)
==2399==    by 0x402F559: task_trampoline (task.c:193)
==2399==    by 0x405B96D: start_thread (pthread_create.c:300)
==2399==    by 0x4145A4D: clone (clone.S:130)
==2399==
==2399== LEAK SUMMARY:
==2399==    definitely lost: 0 bytes in 0 blocks
==2399==    indirectly lost: 0 bytes in 0 blocks
==2399==      possibly lost: 5,472 bytes in 102 blocks
==2399==    still reachable: 5,618 bytes in 101 blocks
==2399==         suppressed: 0 bytes in 0 blocks
==2399== Reachable blocks (those to which a pointer was found) are not shown.
==2399== To see them, rerun with: --leak-check=full --show-reachable=yes
==2399==
==2399== For counts of detected and suppressed errors, rerun with: -v
==2399== ERROR SUMMARY: 3 errors from 3 contexts (suppressed: 21 from 8)
Killed

So it looks like the contexts allocated in start_evtimer are at least
lost, but valgrind mentions another 100 blocks that are still
reachable but I think these are in fact also lost since these are
referenced by the timer contexs.


I also have created a similar test application (tm-11), but in this
code the sleep is not there. This means the timers are still running
while killing the task. When running this test, I see an invalid read:

meeusr@domain.hid$ sudo
LD_LIBRARY_PATH=/home/meeusr/repo/xenomai-forge-install/lib/ valgrind
--leak-check=full ./tm-11
==2521== Memcheck, a memory error detector
==2521== Copyright (C) 2002-2009, and GNU GPL'd, by Julian Seward et al.
==2521== Using Valgrind-3.6.0.SVN-Debian and LibVEX; rerun with -h for
copyright info
==2521== Command: ./tm-11
==2521==
==2521== Thread 2:
==2521== Invalid read of size 4
==2521==    at 0x402F0A1: threadobj_get_magic (threadobj.h:226)
==2521==    by 0x402F1C7: find_psos_task (task.c:55)
==2521==    by 0x402F279: get_psos_task (task.c:94)
==2521==    by 0x403021C: ev_send (task.c:631)
==2521==    by 0x4030494: postman_handler (tm.c:71)
==2521==    by 0x403EB13: timerobj_handler (timerobj-mercury.c:39)
==2521==    by 0x4074432: timer_sigev_thread (timer_routines.c:65)
==2521==    by 0x405B96D: start_thread (pthread_create.c:300)
==2521==    by 0x4145A4D: clone (clone.S:130)
==2521==  Address 0x41d4190 is 136 bytes inside a block of size 584 free'd
==2521==    at 0x4024B3A: free (vg_replace_malloc.c:366)
==2521==    by 0x403FFDB: pvfree (heapobj-malloc.c:80)
==2521==    by 0x402EF1F: xnfree (heapobj.h:262)
==2521==    by 0x402F42F: task_finalizer (task.c:163)
==2521==    by 0x403DD8F: threadobj_finalize (threadobj.c:751)
==2521==    by 0x405B3EE: __nptl_deallocate_tsd (pthread_create.c:155)
==2521==    by 0x405B97B: start_thread (pthread_create.c:307)
==2521==    by 0x4145A4D: clone (clone.S:130)
==2521==



^C==2521==
==2521== HEAP SUMMARY:
==2521==     in use at exit: 11,090 bytes in 203 blocks
==2521==   total heap usage: 311 allocs, 108 frees, 13,646 bytes allocated
==2521==
==2521== Thread 1:
==2521== 136 bytes in 1 blocks are possibly lost in loss record 2 of 5
==2521==    at 0x402425F: calloc (vg_replace_malloc.c:467)
==2521==    by 0x4010CDB: _dl_allocate_tls (dl-tls.c:300)
==2521==    by 0x405C2E2: pthread_create@domain.hid (allocatestack.c:561)
==2521==    by 0x402F9F1: t_create (task.c:307)
==2521==    by 0x80486E4: main (tm-11.c:26)
==2521==
==2521== 136 bytes in 1 blocks are possibly lost in loss record 3 of 5
==2521==    at 0x402425F: calloc (vg_replace_malloc.c:467)
==2521==    by 0x4010CDB: _dl_allocate_tls (dl-tls.c:300)
==2521==    by 0x405C2E2: pthread_create@domain.hid (allocatestack.c:561)
==2521==    by 0x4074201: __start_helper_thread (timer_routines.c:184)
==2521==    by 0x406142F: pthread_once (pthread_once.S:122)
==2521==    by 0x403EBFA: timerobj_init (timerobj-mercury.c:69)
==2521==    by 0x403056F: start_evtimer (tm.c:101)
==2521==    by 0x4030623: tm_evafter (tm.c:126)
==2521==    by 0x804865D: task (tm-11.c:13)
==2521==    by 0x402F559: task_trampoline (task.c:193)
==2521==    by 0x405B96D: start_thread (pthread_create.c:300)
==2521==    by 0x4145A4D: clone (clone.S:130)
==2521==
==2521== 5,200 bytes in 100 blocks are possibly lost in loss record 4 of 5
==2521==    at 0x4024F20: malloc (vg_replace_malloc.c:236)
==2521==    by 0x403FFB8: pvmalloc (heapobj-malloc.c:75)
==2521==    by 0x40304B8: start_evtimer (tm.c:81)
==2521==    by 0x4030623: tm_evafter (tm.c:126)
==2521==    by 0x804865D: task (tm-11.c:13)
==2521==    by 0x402F559: task_trampoline (task.c:193)
==2521==    by 0x405B96D: start_thread (pthread_create.c:300)
==2521==    by 0x4145A4D: clone (clone.S:130)
==2521==
==2521== LEAK SUMMARY:
==2521==    definitely lost: 0 bytes in 0 blocks
==2521==    indirectly lost: 0 bytes in 0 blocks
==2521==      possibly lost: 5,472 bytes in 102 blocks
==2521==    still reachable: 5,618 bytes in 101 blocks
==2521==         suppressed: 0 bytes in 0 blocks
==2521== Reachable blocks (those to which a pointer was found) are not shown.
==2521== To see them, rerun with: --leak-check=full --show-reachable=yes
==2521==
==2521== For counts of detected and suppressed errors, rerun with: -v
==2521== ERROR SUMMARY: 103 errors from 4 contexts (suppressed: 21 from 8)
Killed
meeusr@domain.hid$

regards,
Ronny

--0016364ed8344c9f4504added6ce
Content-Type: text/x-csrc; charset=US-ASCII; name="tm-10.c"
Content-Disposition: attachment; filename="tm-10.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gsvrlrsk1

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPGNvcHBlcnBs
YXRlL2luaXQuaD4KI2luY2x1ZGUgPGNvcHBlcnBsYXRlL3RyYWNlb2JqLmg+CiNpbmNsdWRlIDxw
c29zL3Bzb3MuaD4KCnN0YXRpYyB2b2lkIHRhc2sodV9sb25nIGEwLCB1X2xvbmcgYTEsIHVfbG9u
ZyBhMiwgdV9sb25nIGEzKQp7CglpbnQgaTsKCXVuc2lnbmVkIGxvbmcgdGltZXJfaWQ7CgoJZm9y
IChpPTA7aTwxMDA7aSsrKSB7CgkgIHRtX2V2YWZ0ZXIoMjAsIDB4MSwgJnRpbWVyX2lkKTsKCX0K
CXRtX3drYWZ0ZXIoMTAwKTsKCXRfZGVsZXRlKDApOwp9CgppbnQgbWFpbihpbnQgYXJnYywgY2hh
ciAqYXJndltdKQp7Cgl1X2xvbmcgYXJnc1tdID0geyAxLCAyLCAzLCA0IH07CglpbnQgcmV0OwoJ
dW5zaWduZWQgbG9uZyB0aWQ7CgoJY29wcGVycGxhdGVfaW5pdChhcmdjLCBhcmd2KTsKCglyZXQg
PSB0X2NyZWF0ZSgiVEFTSyIsIDIwLCAwLCAwLCAwLCAmdGlkKTsKCXJldCA9IHRfc3RhcnQodGlk
LCAwLCB0YXNrLCBhcmdzKTsKCgl3aGlsZSAoMSkgdG1fd2thZnRlcigxMDAwKTsKfQo=
--0016364ed8344c9f4504added6ce
Content-Type: text/x-csrc; charset=US-ASCII; name="tm-11.c"
Content-Disposition: attachment; filename="tm-11.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gsvrmhd92

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPGNvcHBlcnBs
YXRlL2luaXQuaD4KI2luY2x1ZGUgPGNvcHBlcnBsYXRlL3RyYWNlb2JqLmg+CiNpbmNsdWRlIDxw
c29zL3Bzb3MuaD4KCnN0YXRpYyB2b2lkIHRhc2sodV9sb25nIGEwLCB1X2xvbmcgYTEsIHVfbG9u
ZyBhMiwgdV9sb25nIGEzKQp7CglpbnQgaTsKCXVuc2lnbmVkIGxvbmcgdGltZXJfaWQ7CgoJZm9y
IChpPTA7aTwxMDA7aSsrKSB7CgkgIHRtX2V2YWZ0ZXIoMjAsIDB4MSwgJnRpbWVyX2lkKTsKCX0K
CXRfZGVsZXRlKDApOwp9CgppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQp7Cgl1X2xv
bmcgYXJnc1tdID0geyAxLCAyLCAzLCA0IH07CglpbnQgcmV0OwoJdW5zaWduZWQgbG9uZyB0aWQ7
CgoJY29wcGVycGxhdGVfaW5pdChhcmdjLCBhcmd2KTsKCglyZXQgPSB0X2NyZWF0ZSgiVEFTSyIs
IDIwLCAwLCAwLCAwLCAmdGlkKTsKCXJldCA9IHRfc3RhcnQodGlkLCAwLCB0YXNrLCBhcmdzKTsK
Cgl3aGlsZSAoMSkgdG1fd2thZnRlcigxMDAwKTsKfQo=
--0016364ed8344c9f4504added6ce--

