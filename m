Subject: Re: [Xenomai-help] What is permanent memory (rt_task_shadow)
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4566DB9B.5010702@domain.hid>
References: <4566DB9B.5010702@domain.hid>
Content-Type: text/plain
Date: Fri, 24 Nov 2006 13:25:34 +0100
Message-Id: <1164371134.4973.39.camel@domain.hid>
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

On Fri, 2006-11-24 at 12:46 +0100, Anders Blomdell wrote:
> The documentation for rt_task_shadow says:
> 
>    task The address of a task descriptor Xenomai will use to store the
>         task-related data. This descriptor must always be valid while
>         the task is active therefore it must be allocated in permanent
>         memory.
> 
> Is it correct to assume that it is OK to the following:
> 

Yes, even if it relies on the assumption that func() will never unwind
its stack space before it self-destroys.

>    void func() {
>      RT_TASK task;
>      int err;
> 
>      err = rt_task_shadow(&task, ...);
>      ...  Realtime activities ...
>      if (err == 0) {
>        rt_task_delete(&task);
>      }
>    }
> 
> Regards
> 
> Anders Blomdell
> 
-- 
Philippe.



