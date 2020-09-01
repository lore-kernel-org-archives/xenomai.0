MIME-Version: 1.0
From: =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date: Tue, 1 Sep 2020 17:11:43 +0800
Message-ID: <CAAvDm6YkY012JKwbWErAe2CYpcDzyT+31P1n+nTaogx0tA1L8g@mail.gmail.com>
Subject: About the reasons for setting the timer-internal thread with the
 THREADOBJ_IRQCONTEXT flag.
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>

Hi,

I found that the timer-internal thread is set with the
THREADOBJ_IRQCONTEXT flag.
Here is the related code snippet:
static int server_prologue(void *arg)
{
   svpid = get_thread_pid();
   copperplate_set_current_name("timer-internal");
   timersv_init_corespec();
   threadobj_set_current(THREADOBJ_IRQCONTEXT);

   return 0;
}

Could you please tell me the reasons for setting the timer-internal
thread with the THREADOBJ_IRQCONTEXT flag.

What are the potential problems if not setting this flag?
(I want to make it possible to call rt_task_sleep in the callback
function of the timer which is created by rt_alarm_create.)

Thank you for your attention to this matter.
Best regards
Sunshilong

