From: Marco Camurri <marco.camurri@iit.it>
Message-ID: <79642a26-d54d-7362-9ea5-872a5f82f0ed@iit.it>
Date: Wed, 18 Oct 2017 08:50:33 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [Xenomai] xenomai 3 migration bitmask for calls
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear all,
I'm migrating a mission critical system based on the native skin of
Xenomai 2 to Xenomai 3.

I read from the migration guide that now this skin is called Alchemy,
therefore I did the modification in header includes and other things.

However, some bitmask variables some xenomai calls have been removed.
I would like to replicate the exact behavior I had on Xenomai 2
in the new system.
In particular, the calls I have in the previous system are:

1) rt_task_spawn(&servo_ptr, name, servo_stack_size, servo_priority,
                  T_FPU | T_JOINABLE | T_CPU(cpuID), motor_servo, NULL)

    T_FPU and T_CPU are removed, who do I make the new call?
    Just with T_JOINABLE?

2) rt_heap_create(&heap,name,(size_t)(elemNum*elemSize), H_SHARED)

    H_SHARED has been removed.
    The only options I have now are: H_FIFO, H_PRIO, H_SINGLE.
    What should I choose?

3) rt_timer_set_mode((RTIME) TM_ONESHOT)

    TM_ONESHOT does not exist anymore.  What should I set in the
    rt_set_mode function?
    The documentation only says to set 0 for no op, but it does not tell
    anything about the other options.

Thank you,
Marco.

-- 
Marco Camurri
Post-Doctoral Researcher - Dynamic Legged Systems Lab
Istituto Italiano di Tecnologia - Advanced Robotics Department
via Morego 30, 16163 Genova (Italy)


