Content-Type: text/plain; charset="us-ascii"
Date: Tue, 06 May 2008 18:06:03 +0200
From: "Karl Reichert" <Karl-Trampe@domain.hid>
Message-ID: <20080506160603.216980@domain.hid>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Pros/Contras Xenomai - CONFIG_PREEMPT_RT
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

Hello all,

I'm currently reading some documents about (standard) linux kernel 2.6.23 and it's latest changes. I saw, that it has high resolution timers available, which can reduce interrupt latency a lot. It's said that they also reduced critical sections occurence and their duration, all in all bringing linux closer to real time requirements.

I also checked the real time patches of Ingo Molnar and Thomas Gleixner (CONFIG_PREEMPT_RT) and the wiki [1] states, that their patches are replacing most kernel spinlocks with mutexes that support priority inheritance, as well as moving all interrupt and software interrupts to kernel threads. Latency tests state times of 24us for a Pentium 4, 2.8 GHz with their patches applied. [2], [3]

I see a lot of advantages from this solution:
1) As their patches do have a good chance to be included in linux kernel in future, one doesn't has to patch anymore the kernel to get real time behavoir.
2) There is only one API to use. No matter if you are creating a program as real time task or not, you can use the same API.
3) One can use CPU isolation on dual core machines, making one core running only real time tasks and the other the rest.
4) As they don't use anything like nucleus, there is less overhead.


These are the thoughts running through my mind at the moment. I would like to discuss these with you. What do you think about this? Where do you see pros and contras for xenomai / CONFIG_PREEMPT_RT?

Thanks in advance for your input!

Karl

[1] http://rt.wiki.kernel.org/index.php/Main_Page
[2] http://linuxdevices.com/files/article081/Siro.pdf
[3] http://rt.wiki.kernel.org/index.php/CONFIG_PREEMPT_RT_Patch

