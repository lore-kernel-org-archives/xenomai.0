MIME-Version: 1.0
From: Marco Barletta <barlettamarco8@gmail.com>
Date: Sat, 8 May 2021 17:13:20 +0200
Message-ID: <CAK6DXL0_dMXz7Xdi4vZSBZ9J5E9dVwiWiKOLnoX686ecWe5e3w@mail.gmail.com>
Subject: Timer_Create for periodic tasks
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi everyone;
I'm currently running Xenomai 3.1 and I'm facing with an issue. When I want
to create a periodic task using timer_create and consequently sigwait or
sigwaitinfo it works when running in root pid namespace, but when i run the
task in a child pid namespace the thread doesn't receive the ALRM signal (I
don't know if it's the timer create the problem or the sigwait). I also
tried to use a server to translate my pid but the cobalt core rejects the
call since the pid of the currently running thread is different. Is this a
problem related to how xenomai manages the xnthread or is an inherent
problem of posix?
Thanks for helping, best regards

-- 
Marco Barletta
