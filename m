Date: Wed, 9 Nov 2005 12:26:00 +0100 (MET)
From: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Message-ID: <Pine.GSO.4.58.0511091211310.13432@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Xenomai-core] Ambiguity in description about rt_task_delete()
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I just stumbled across an ambiguity in the documentation for
rt_task_delete() in the native skin. One could think that this function
can only be called from userspace if it is a RT task because of

"This service can be called from:
...
User-space task (switches to primary mode)"

But this is only true if the argument is NULL. Otherwise it is possible
from NRT context (if I understood the code in task.c correctly).

Maybe a clearer description is necessary here.


Sebastian

