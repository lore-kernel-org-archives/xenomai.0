Subject: Re: [Xenomai-help] What is permanent memory (rt_task_shadow)
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4566F43E.1070205@domain.hid>
References: <4566DB9B.5010702@domain.hid>
	<1164371134.4973.39.camel@domain.hid>  <4566F43E.1070205@domain.hid>
Content-Type: text/plain
Date: Fri, 24 Nov 2006 14:47:43 +0100
Message-Id: <1164376064.4973.59.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2006-11-24 at 14:31 +0100, Anders Blomdell wrote:
> Philippe Gerum wrote:
> > On Fri, 2006-11-24 at 12:46 +0100, Anders Blomdell wrote:
> >> The documentation for rt_task_shadow says:
> >>
> >>    task The address of a task descriptor Xenomai will use to store the
> >>         task-related data. This descriptor must always be valid while
> >>         the task is active therefore it must be allocated in permanent
> >>         memory.
> >>
> >> Is it correct to assume that it is OK to the following:
> >>
> >>    void func() {
> >>      RT_TASK task;
> >>      int err;
> >>
> >>      err = rt_task_shadow(&task, ...);
> >>      ...  Realtime activities ...
> >>      if (err == 0) {
> >>        rt_task_delete(&task);
> >>      }
> >>    }
> > 
> > Yes, even if it relies on the assumption that func() will never unwind
> > its stack space before it self-destroys.
> OK, good. Follow-up question:
> 
>    Is there any way to do the inverse of rt_task_shadow (since
>    the answer above implies that rt_task_delete will destroy the
>    linux task as well)?
> 

No interface currently exists for that, even if technically, this could
be done by simply unmapping the shadow (needs a bit more thought for
corner cases, but still, there should be no showstopper). This would be
safe only against the current Linux task though.

> Regards
> 
> Anders Blomdell
> 
-- 
Philippe.



