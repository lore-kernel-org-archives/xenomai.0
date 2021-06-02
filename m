MIME-Version: 1.0
From: Marco Barletta <barlettamarco8@gmail.com>
Date: Wed, 2 Jun 2021 22:42:14 +0200
Message-ID: <CAK6DXL0CWr2cZq7Gr-vN3xswwEB+w19xAP7ZgxS-K5QdLprRag@mail.gmail.com>
Subject: Info about timers
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
I'm doing some tests to stress my patch of sched quota, but I had some
overruns, especially for tasks with period near to ms. My method for
testing Is checking overrun by making the difference between a clock read
and the expected deadline, but I saw that for latency test you used the
overruns in siginfo. However reading the doc of siginfo it seems to me that
those are more like period skipped than real overruns, am I missing
something? Moreover the signals to a real time task are delivered in
primary or secondary mode? (Note: to generate a custom cpu burn load i use
a non blocking timer fd and i poll on It after starting it with wcet time,
do you know any other more predictable way?)
Thanks for helping as always;
Best regards.
