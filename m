From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17589.7054.61661.221910@domain.hid>
Date: Wed, 12 Jul 2006 17:55:58 +0200
Subject: Re: [Xenomai-core] [PATCH] relax context check for rt_task_suspend
In-Reply-To: <44B50771.9080003@domain.hid>
References: <44B4C09F.209@domain.hid>
	<b647ffbd0607120500jccf65cdqd781ff668f2c7ba8@domain.hid>
	<44B4EA3B.1010109@domain.hid>
	<b647ffbd0607120645n69a20805rfb9e62c8cfb3061f@domain.hid>
	<44B50771.9080003@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Dmitry Adamushko wrote:
 > > --- task.c      2006-05-19 18:25:19.000000000 +0200
 > > +++ task-my.c   2006-07-12 15:40:16.549170000 +0200
 > > @@ -426,7 +426,8 @@ int rt_task_suspend(RT_TASK *task)
 > >         goto unlock_and_exit;
 > >     }
 > > 
 > > 
 > > -    if (xnpod_unblockable_p()) {
 > > +    /* we are about to suspend a task, let's check wehther it may sleep */
 > > +    if (xnthread_test_flags(task, XNLOCK|XNROOT)) {
 > >         err = -EPERM;
 > >         goto unlock_and_exit;
 > >     }
 > > 
 > > 
 > > 
 > > See the difference? :) it was slightly broken indeed, meaning it just
 > > bailed
 > > out all the calls from the interrupt context which is wrong according to
 > > spec.
 > 
 > Fine, now I achieved what I always wanted: someone really thought about
 > it! :)
 > 
 > I tried to bundle your approach with appropriate documentation update
 > and a minor fix in the attached patch. Credits go to you then.

Patch applied.

-- 


					    Gilles Chanteperdrix.

