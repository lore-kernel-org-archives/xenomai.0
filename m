From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <664a5757-3d5a-af0d-96a0-485bc71d58f8@siemens.com>
Date: Thu, 27 Jul 2017 20:03:47 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Avoid stopping all timers during debug sessions
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,

currently, when gdb interrupts a Xenomai application, all timers stop
firing (except for those marked with XNTIMER_NOBLCK - core timers). This
means, you can't debug one RT application without affecting others on
the same systems. I'm not wondering how to resolve this. Options:

 - convert timer stopping to a per-process feature - implies the need to
   establish some timer-process relationship concept, and it might be
   tricky for drivers and other central timer creators

 - let the application deal with timer overflows during debug:
    - make timer stop optional (in case of single applications that
      can't handle this yet)
    - do not stop timers at all

Any opinions?

BTW, I also have pre/post-debug hook concept for applications out of
tree that can help to make applications debug-aware. In our use cases,
the pre-hook brings hardware into a state that permits application stop,
and the post-host ramps everything up again.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

