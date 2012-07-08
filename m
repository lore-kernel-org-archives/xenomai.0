MIME-Version: 1.0
Date: Sun, 8 Jul 2012 16:43:14 +0430
Message-ID: <CAKKWdteig4R7+RLTsSxQrjrb=+0GsUWxFoRXASWE2ZznJJCTyw@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] questions: real-time scheduler
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I have some questions as follows:

1) If i have one real time task and that task is big and does not
finish soon or it has an infinite loop at the end like:
here:  goto here;

Will other non real-time tasks be scheduled? or a real time task will
run to completion.

2) If I have an infinite loop like the above at the end of a real time task:
here:  goto here;

Does the scheduler recognizes this situation to not to schedule this
task, because it does nothing virtually or it assigns a time slot to
that task?

3) What factors effect the length of the time slot assigned to each
real time task? I mean how long CPU continues to stay inside the code
of a real time task?

4) I have a multi-core CPU, can i assign one CPU to a specific task?

5) I want a specific code to be executed (and completed) like every 1
ms (or n ms) on a x86 PC computer. Is it possible with Xenomai?

6) is there any document to explain the architecture of the Xenomai
real time scheduler?

Regards

