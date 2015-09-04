MIME-Version: 1.0
From: Michael Smith <2michael.smith@gmail.com>
Date: Fri, 4 Sep 2015 11:44:52 +0200
Message-ID: <CANWkrRNJ1576NNq7zqbn-VZTZKrRmiSTTZjyaBXw5R=gQDQckw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] RTNet rtcfg - system hang
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all.
I am trying to get RTNet to work, but the system keeps on crashing
when rtcfg is called.
I'm working on  Xenomai-3.0 rc5.

I have traced the crash to kernel/drivers/net/stack/rtcfg/rtcfg_event.c:151
This is in function rtcfg_main_state_off() where the rtdm_task_init()
is called. This thread creation call completely locks up the system.

Is there any fix for this yet? Or any advice on how to fix it myself?

Thanks
Michael Smith

