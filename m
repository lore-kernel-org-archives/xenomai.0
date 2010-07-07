MIME-Version: 1.0
Date: Wed, 7 Jul 2010 17:56:52 +0800
Message-ID: <AANLkTilmN6HTqYAcEv5qTqYhpjgBiMYQAPvPwCnynAHu@domain.hid>
From: Everett Wang <everteq@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai-help] task management, multi-thread, multi-core
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

Hi All,

I am working on a navigation program that has two realtime tasks. One
is a high priority one executed in a higher frequency. Another task
runs about 1/10th of the first one, but requires substantially more
CPU computations. I am using an atom board which has dual threads
capability. I am worried that the second task can block the execution
of the first one until it finishs all the calculations. Can this
happen in a dual thread and/or dual core CPU? If yes, should I break
the task two into small chunks and let the task one to send a trigger
to
execute one chunk at a time? I know it is not xenomai specific
question and I have tried to read manual or other documents trying to
figure
it out.

I have read that tasks require more resources than threads in Linux.
The inter-threads communication is also more efficient than that of
tasks. Are these also true for xenomai realtime OS? Should I create
threads instead of tasks?


Any suggestions are welcome. Thanks for reading. :-)

Everett

