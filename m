Date: Mon, 27 Feb 2006 06:20:56 -0800
From: Steven Seeger <steve@domain.hid>
Message-ID: <C0284AC8.253E%steve@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Subject: [Xenomai-help] resume/suspend periodic timing issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I seem to have discovered a condition where if I have a thread in periodic
timing (system tick of 125000 ns) and my thread suspends itself based on
some condition, when I resume the thread later based on user input,
rt_task_wait_period() doesn't block until the thread has "caught up" with
where it should be. In other words, say I have a thread that is supposed to
run every 2 ms. I suspend it for 1 second, and then resume it.
rt_task_wait_period() will return immediately 50 times. This can be fixed by
calling rt_task_set_periodic() again after the thread's suspend call.

Is there any way around this?

Here is the thread in question: (2 ms period)

void meas_data::_meas_thread::task_func(void)
{
    meas_data::meas_update_data meas;
    const int display_hit = 25;
    
    int display_count=0;
        
    for(;;) {
        if(!motor->is_moving()) {
            meas.time = 0.0;
            display_count = 0;
            stop();
            set_period_ns(get_period_ns()); //fixes suspend/resume timing
        }
        else rt_task_wait_period();
        
        meas.force = motor->get_force();
        meas.lps = motor->get_linear();
        meas.sd = motor->get_limit_distal();
        meas.sp = motor->get_limit_proximal();
        meas.steps = motor->get_moved_steps();
        meas.time += 0.01;
        
/* log data to file */
        void *ptr = file_queue.alloc(sizeof(meas));
        assert(ptr);
        memcpy(ptr, &meas, sizeof(meas));
        file_queue.send(ptr, sizeof(meas));

/* display data on screen twice a second */
        if(++display_count>=display_hit) {
            display_count = 0;
            
            ptr = display_queue.alloc(sizeof(meas));
            assert(ptr);
            memcpy(ptr, &meas, sizeof(meas));
            display_queue.send(ptr, sizeof(meas));
        }
    }
}

When I resume the thread, I can see the data on the screen come in way too
fast until the thread "catches up." I have confirmed that it is
rt_task_wait_period() returning immediately.

Steven


