Message-ID: <trinity-8da07db9-dfd7-4c9c-a6ae-9a126bc467e2-1568728631894@3c-app-webde-bs20>
From: JK.Behnke@web.de
Subject: Aw: Re: sideeffect of rcu_nocbs on periodic Alchemy task
Date: Tue, 17 Sep 2019 15:57:11 +0200
In-Reply-To: <ed0415ad-6421-fb35-2859-910cc91bd353@siemens.com>
References: <trinity-a8fa9174-e6b1-4dd6-9b0e-87b36ca132f7-1568726164071@3c-app-webde-bs20>
 <ed0415ad-6421-fb35-2859-910cc91bd353@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Content-Transfer-Encoding: 8bit
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

   Hi Jan,
   wow, that was a really quick response.

   Does "testing latest rt release" mean that I also have to use a new
   Linux kernel version?
   Currently I am running linux 4.14.71-rt44.
   The most recent rt-patch for linux 4.14 seems to be
   "patch-4.14.137-rt66.patch"
   Would you recommend to use that?

   Thanks for your comments

   Jochen

   >> Hello,
   >>
   >> I am running an Alchemy application (xenomai 3.0.9) over Linux
   >> prempt-rt on a dual core
   >> atom (E3930) and noticed a side effect of the Linux boot parameter
   >> "rcu_nocbs".
   >
   >To clarify: You are using Xenomai in mercury mode (userspace libs
   only) on a
   >stock preempt-rt kernel, right? Then a kernel splash is best reported
   to the
   >preempt-rt community. But first make sure to have tested also the
   latest release
   >to clarify if that is a stable -rt issue or a general one.
   >
   >Jan
   >
   >>
   >> Whenever the kernel bootparameter "rcu_nocbs=1" is set, I get the
   >> following Linux
   >> kernel warning, when the AlchemyTask (TestTask) is terminated.
   >>
   >>
   >> Sep 17 13:02:43 localhost kernel: [ 97.342398] ------------[ cut
   here
   >> ]------------
   >> Sep 17 13:02:43 localhost kernel: [ 97.342412] WARNING: CPU: 0 PID:
   >> 530 at
   >>
   /home/behnkjoc/prc2020/poky/build-tca5-32/tmp/work-shared/congatec-tca5
   >> -32/kernel-source/kernel/rcu/tree_plugin.h:310
   >> rcu_note_context_switch+0x2a0/0x4d0
   >> Sep 17 13:02:43 localhost kernel: [ 97.342414] Modules linked in:
   >> ec_generic(O) ec_master(O) spidev nls_iso8859_1 cmdlinepart
   >> intel_spi_platform intel_spi spi_nor mtd spi_pxa2xx_platform joydev
   >> intel_rapl intel_powerclamp coretemp crc32_pclmul snd_hda_codec_hdmi
   >> pcbc aesni_intel aes_i586 crypto_simd cryptd intel_cstate
   >> intel_rapl_perf i2c_i801 lpc_ich pcspkr idma64 virt_dma intel_lpss_
   >> pci intel_lpss input_leds mac_hid i915 video snd_hda_intel
   >> drm_kms_helper snd_hda_codec snd_hda_core snd_hwdep snd_pcm
   >> hid_multitouch drm mei_me snd_timer fb_sys_fops syscopyarea
   sysfillrect
   >> snd
   >> mei sysimgblt soundcore shpchp sch_fq_codel nfsd autofs4
   >> Sep 17 13:02:43 localhost kernel: [ 97.342470] CPU: 0 PID: 530 Comm:
   >> TestTask Tainted: G O 4.14.71-rt44 #1
   >> Sep 17 13:02:43 localhost kernel: [ 97.342472] task: f3347300
   >> task.stack: f32ea000
   >> Sep 17 13:02:43 localhost kernel: [ 97.342476] EIP:
   >> rcu_note_context_switch+0x2a0/0x4d0
   >> Sep 17 13:02:43 localhost kernel: [ 97.342478] EFLAGS: 00010002 CPU:
   >> 0
   >> Sep 17 13:02:43 localhost kernel: [ 97.342480] EAX: 00000001 EBX:
   >> 00000000 ECX: 00000001 EDX: 00000000
   >> Sep 17 13:02:43 localhost kernel: [ 97.342482] ESI: 00000000 EDI:
   >> f3347300 EBP: f32ebeec ESP: f32ebed0
   >> Sep 17 13:02:43 localhost kernel: [ 97.342485] DS: 007b ES: 007b FS:
   >> 00d8 GS: 00e0 SS: 0068
   >> Sep 17 13:02:43 localhost kernel: [ 97.342487] CR0: 80050033 CR2:
   >> 06338490 CR3: 332d4000 CR4: 003406d0
   >> Sep 17 13:02:43 localhost kernel: [ 97.342489] Call Trace:
   >> Sep 17 13:02:43 localhost kernel: [ 97.342501] ?
   >> unpin_current_cpu+0x53/0x80
   >> Sep 17 13:02:43 localhost kernel: [ 97.342507] __schedule+0x85/0x700
   >> Sep 17 13:02:43 localhost kernel: [ 97.342511] ?
   >> _raw_spin_unlock_irqrestore+0x17/0x50
   >> Sep 17 13:02:43 localhost kernel: [ 97.342514] ?
   >> rt_spin_unlock+0x24/0x50
   >> Sep 17 13:02:43 localhost kernel: [ 97.342517] schedule+0x41/0xe0
   >> Sep 17 13:02:43 localhost kernel: [ 97.342521]
   >> hrtimer_wait_for_timer+0x5d/0x90
   >> Sep 17 13:02:43 localhost kernel: [ 97.342525] ?
   >> wait_woken+0x70/0x70
   >> Sep 17 13:02:43 localhost kernel: [ 97.342530]
   >> timer_wait_for_callback+0x40/0x50
   >> Sep 17 13:02:43 localhost kernel: [ 97.342533]
   >> SyS_timer_delete+0x6b/0x140
   >> Sep 17 13:02:43 localhost kernel: [ 97.342538]
   >> do_int80_syscall_32+0x6b/0xf0
   >> Sep 17 13:02:43 localhost kernel: [ 97.342542]
   >> entry_INT80_32+0x31/0x31
   >> Sep 17 13:02:43 localhost kernel: [ 97.342545] EIP: 0xb22c68d0
   >> Sep 17 13:02:43 localhost kernel: [ 97.342546] EFLAGS: 00000282 CPU:
   >> 0
   >> Sep 17 13:02:43 localhost kernel: [ 97.342548] EAX: ffffffda EBX:
   >> 00000002 ECX: 00000000 EDX: b1d00480
   >> Sep 17 13:02:43 localhost kernel: [ 97.342550] ESI: b1d005e0 EDI:
   >> b22cc000 EBP: b1fc7318 ESP: b1fc72b0
   >> Sep 17 13:02:43 localhost kernel: [ 97.342552] DS: 007b ES: 007b FS:
   >> 0000 GS: 0033 SS: 007b
   >> Sep 17 13:02:43 localhost kernel: [ 97.342556] Code: c3 83 e8 01 39
   >> c2 0f 85 27 02 00 00 83 f9 0f 8d 97 f8 02 00 00 0f 87 78 01 00 00 8b
   04
   >> 8d f8 52 51 c3 e9 a4 9b 83 00 8d 74 26 00 <0f> 0b 80
   >> bf f4 02 00 00 00 0f 85 a6 fd ff ff e9 1c ff ff ff 8d
   >> Sep 17 13:02:43 localhost kernel: [ 97.342600] ---[ end trace
   >> 0000000000000002 ]---
   >> The issue can be reproduced with the following simple program
   >>
   ///////////////////////////////////////////////////////////////////////
   >> ////////
   >> // Test application
   >>
   ///////////////////////////////////////////////////////////////////////
   >> ////////
   >> #include <stdio.h>
   >> #include <unistd.h> // usleep
   >> #include <alchemy/task.h>
   >> #define CPU_AFFINITY_DEFAULT 0
   >> #define MAIN_TASK_NAME "MainTask"
   >> #define MAIN_TASK_PRIO 0
   >> #define MAIN_TASK_MODE 0
   >> #define TESTTASK_NAME "TestTask"
   >> #define TESTTASK_PRIO 10
   >> #define TESTTASK_MODE 0
   >> #define TESTTASK_STACKSIZE 0x100000l // 1 MB
   >> #define TESTTASK_PERIOD_NS (5* 1000000)
   >> typedef struct {
   >> RT_TASK TaskDescr;
   >> int nEndTask;
   >> int Period_ns;
   >> } TESTTASK_CONTEXT;
   >> RT_TASK g_MainTask;
   >> int g_nRun=1;
   >> void TestTask(void *pData) {
   >> TESTTASK_CONTEXT *pCtx = (TESTTASK_CONTEXT *)pData;
   >> unsigned long overrun;
   >> int nErr = 0;
   >> printf("TestTask starting...\n");
   >> nErr = rt_task_set_periodic(NULL, TM_NOW,
   >> rt_timer_ns2ticks(pCtx->Period_ns));
   >> while (!pCtx->nEndTask) {
   >> rt_task_wait_period(&overrun);
   >> }
   >> printf("TestTask terminating...\n");
   >> }
   >> int StartTestTask(TESTTASK_CONTEXT* pCtx)
   >> {
   >> printf("Starting TestTask...\n");
   >>
   >> int err;
   >> pCtx->nEndTask=0;
   >> pCtx->Period_ns=TESTTASK_PERIOD_NS;
   >> err = rt_task_spawn(&pCtx->TaskDescr, TESTTASK_NAME,
   >> TESTTASK_STACKSIZE, TESTTASK_PRIO, T_JOINABLE, TestTask, pCtx);
   >> if (err) {
   >> printf("Error in rt_task_spawn_() \n");
   >> return err;
   >> }
   >> return 0;
   >> }
   >> void StopTestTask(TESTTASK_CONTEXT* pCtx){
   >> printf("Stopping TestTask...\n");
   >> pCtx->nEndTask=1;
   >>
   >> RT_TASK_INFO ti;
   >> if (0 == rt_task_inquire(&pCtx->TaskDescr, &ti) ) {
   >> rt_task_join(&pCtx->TaskDescr);
   >> }
   >> }
   >>
   >> // Signalhandler für SIGTERM und SIGINT (Ctrl-C)
   >> void TerminationHandler(int sig) {
   >> if(sig==SIGTERM) {
   >> printf("##### Termination Signal Handler(%d) #####\n",sig);
   >> }
   >> if(sig==SIGINT) {
   >> printf("##### Signal Handler(%d) #####\n",sig);
   >> }
   >> g_nRun=0;
   >> return;
   >> }
   >> int main(int argc, char* argv[]){
   >> TESTTASK_CONTEXT ctxTestTask;
   >> signal(SIGTERM, TerminationHandler);
   >> signal(SIGINT, TerminationHandler);
   >> StartTestTask(&ctxTestTask);
   >> //--- Main Loop ---
   >> while(g_nRun != 0 ) {
   >> printf("main loop\n");
   >> usleep(1000000); // sleep 1 sec
   >> }
   >> StopTestTask(&ctxTestTask);
   >> printf("MainTask terminating\n");
   >> return 0;
   >> }
   >>
   ///////////////////////////////////////////////////////////////////////
   >> ////////
   >> // End: Test application
   >>
   ///////////////////////////////////////////////////////////////////////
   >> ////////
   >>
   >> Any ideas what could be the problem?
   >>
   >>
   >> Thanks in advance
   >> Jochen
   >>
   >
   >--
   >Siemens AG, Corporate Technology, CT RDA IOT SES-DE
   >Corporate Competence Center Embedded Linux
   >
