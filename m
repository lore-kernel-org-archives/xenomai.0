MIME-Version: 1.0
Date: Thu, 12 May 2011 14:07:30 +0200
Message-ID: <BANLkTikenoYE=42uhjRq=DeP5FT9sip-dg@domain.hid>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] Fast-sync and auto-relaxed priority 0 threads
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

Hi,

We are using the auto-relax patches on top of the latest Xenomai 2.5.6
release. This means our priority 0 task is in secondary domain most of
the time.

We've seen a lot of domain switching and gatekeeper activity when this
task is acquiring a mutex which is not locked. Of course an
auto-relaxed prio 0 thread will do domain switching more often, but in
this case because we have fast sync enabled I would expect it doesn't
have to make a kernel call thus no switching..

Looking into the code I've found that at rt_mutex_acquire_inner there
is explicitly a check for secondary domain. This must have been done
while xnsynch_fast_acquire can only be called from primary domain. Is
that the case?? In the implementation behind xnsynch_fast_acquire I
cannot find a reason why it cannot be called from secondary domain.
Can anyone comment on this?

It would save a lot of overhead for our priority 0 task if we could
have fast sync in secondary mode. All suggestions are welcome!

Thanks,
Henri.

Xenomai: 2.5.6 + auto-relax patches.
Linux-kernel: 2.6.32.15
Platform: x86

