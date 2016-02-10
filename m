MIME-Version: 1.0
Date: Wed, 10 Feb 2016 13:41:29 -0500
Message-ID: <CAHoW4hGmcH5kLzwi-B3LfMrioqdj3TQ_5S8rGP6MbRudcwEBDA@mail.gmail.com>
From: Charles Kiorpes <ckiorpes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] Process shared rt_event_wait() never signaled on ARM with
	Mercury core
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,
I am having some difficulty getting two processes to signal each other on
an AM572x EVM.
I have two small sample applications:

- app1 : creates an event "MYTEST" using rt_event_create(), clears the
event, and then rt_event_wait()s for TM_INFINITE.  When the event is
signaled, app1 rt_event_clear()s the event and then loops back to the
rt_event_wait()

- app2 : binds to the "MYTEST" event, sleeps for one second,
rt_event_signal()s the event, and then loops back to the one second sleep

I am using the Mercury core, built natively, configured with:
xenomai-3.0.1/configure \
--with-core=mercury \
--enable-debug \
--enable-pshared \
--disable-registry \
--enable-smp \
--enable-condvar-workaround

I launch both applications in different terminals in this order:
# sudo ./app1 --session="Test"
# sudo ./app2 --session="Test"

The following behavior results:
- app1 claims to have successfully created the event
- app2 claims to have successfully bound to the event
- app2 loops correctly, signalling the event once per second
- app1 never wakes up from the first rt_event_wait()

I am running the 4.1.15-ti-rt kernel with full preemption.

On an x86 virtual machine with a vanilla 4.2.0-27-generic kernel, the
applications perform as expected (app1 wakes up when app2 signals the
event).

Any advice as to where to look for further debugging would be greatly
appreciated.

Thanks,
Charles
