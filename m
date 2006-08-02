Date: Wed, 02 Aug 2006 18:08:25 +0200
From: "Petr Cervenka" <grugh@domain.hid>
MIME-Version: 1.0
Message-ID: <200608021808.18076@domain.hid>
Content-Type: text/plain; charset="windows-1250"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] rt_pipe and rt_queue problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I have Xenomai snapshot (18.5.2006,  2.1.1 ~ 2.1.2) and userspace application.
I need to exchange lot of data between two tasks (producer -> consumer) with some buffer in the middle.
I used rt_pipe/linux device scheme, but I realised that the preformance is very low. (At least some performance monitor showed it)
So I tried to use rt_queue. But when I tried to read from queue with timeout (or TM_INFINITE), I got an EPERM error.
That means: "service should block, but was called from a context, which cannot sleep.". But I want to sleep (and wait for new data).
Where is the problem? Do you have any advice?
Petr Cervenka


