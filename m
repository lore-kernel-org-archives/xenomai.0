MIME-Version: 1.0
Date: Mon, 6 Aug 2012 17:23:44 +0430
Message-ID: <CAKKWdtf72dcw0Zg8F+Rh3JQe2ejvTjqujSHgw2R1Se7S7fcpYg@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] question: scheduling4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I wonder if i can ask questions about SCHED_RR scheduling policy.

If there is only one Xenomai real time task, it is an infinite loop,
never leaves Xenomai domain and it has a higher priority than Linux
for sure and it executes for one time slot first.

Then the scheduler is called and it sees that task has higher fixed
priority than Linux and continues to execute it for another time slot
and it continues. So Linux with the static priority 0, is never
executed!

I know that Linux executes somehow, what is the logic behind that?
Would you please explain the functionality of SCHED_RR? and only in
this case what effects the length of the time slot (time quantum)?
The SCHED_RR policy of Linux kernel is the same as what we have in Xenomai?

Sorry for too many questions.
Regards

