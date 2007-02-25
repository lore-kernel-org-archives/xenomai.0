Message-ID: <bc4264770702250638k6b2a2737raef60866a3dc3401@domain.hid>
Date: Sun, 25 Feb 2007 14:38:54 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] timing, scheduling. some theory?
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

Hi,

Ok I have the framework of my application up. Qt, user-interface, 2
tasks running in parallel, one @ 1ms the other @ 2ms.

Next step is to start incorporating the work that must be performed in
the tasks but before I do so it will be useful to have some
understanding of how the scheduling takes place.

I fear the above might not convey my question clearly. I find it hard
to explain exactly what I mean by this so I will pose the question
differently.

What does

rt_task_wait_period();

do exactly? It will be followed by the work that must be done in the
task but does the work get performed while rt_task_wait_period(); is
"waiting" or does nothing happen while the program is on that call?

In the latter case I will have no real control over when the task is
complete. On a fast machine the task will be finished sooner than on a
slower machine.

For example say I am setting outputs based on calculations (e.g. QR
decompositions, singular value decompositions etc) processing certain
inputs. If I read the inputs  first after calling
rt_task_wait_period() then  do the calculations and finally set the
outputs the time difference between reading the inputs and setting
outputs will (in the best case) depend on the the speed of the
machine.

In this scenario there are obviously more optimal manners to structure
the program but I am using it as an example.

Anyhow is there any documentation that elucidates these aspects of xenomai?

Regards,

Roland.

