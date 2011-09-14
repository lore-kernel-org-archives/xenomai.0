MIME-Version: 1.0
Date: Wed, 14 Sep 2011 14:18:42 +0200
Message-ID: <CANKLDms-kVpt6hk7adH880tK5xJL2=D9Y=M25Cn-0hBDueuUfQ@mail.gmail.com>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] multicore: reserving core(s) for Xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

We'll start experiments running our Xenomai application on a
multi-core CPU (x86/ARM). I'm sure there are some Xenomai users who
already have experience with it.

What I would like to do is to run the Xenomai realtime threads on one
core of the multi-core CPU. And I would like to reserve this core only
for the Xenomai realtime threads.

I'm using the Native API, so I can pass the CPU affinity flags for the
Xenomai threads during task creation/shadow. But how can I make sure
other threads will not make use of the same processor? I cannot call
taskset for every task that is spawned... right?

Are there any idea's on how this configuration could be made easier?
It would be nice if there was a kernel config option to reserve
core(s) for Xenomai that Linux will not use.

Any ideas and help are welcome!

Thanks,
Henri.

