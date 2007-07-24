From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <15F13C9AC6F2054D8AC7AFEA62FA218E04E32C@vwagwox00002.vw.vwg>
References: <15F13C9AC6F2054D8AC7AFEA62FA218E04E32C@vwagwox00002.vw.vwg>
Content-Type: text/plain
Date: Tue, 24 Jul 2007 14:03:57 +0200
Message-Id: <1185278637.5998.334.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] [NEWBIE question] Use of rt_task_send
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
To: "Koenig, Kai (EEFA/4)" <kai.koenig@domain.hid>
Cc: xenomai@xenomai.org

On Tue, 2007-07-24 at 13:19 +0200, Koenig, Kai (EEFA/4) wrote:
> Hello,
> 
> As the topic says I am quite the newbie working with Xenomai. As a
> result I have some questions regarding the use of the API.
> 
> I tried checking the archives, but did not find what I was looking
> for.
> 
> I am currently working on a middleware, that manages communication
> (local and over network) between different processes/threads by use of
> Synchonous Message Passing over a special interface.
> 
> I tried using rt_task_send, rt_task_receive and rt_task_reply for
> realization of said interface on Xenomai. Now my questions:
> 
> 1) How do i get the task description of another real-time task that is
> needed for rt_task_send? 
> I have the symbolic name, the task was created with. If I try to
> contact a real-time thread from a user space task I can use it with
> rt_task_bind to get the descriptor of the target task.

> 
> But the API states this is a user-space task only. Is there a similar
> API call for getting the task descriptor of another real-time task
> from kernel space?

You don't need to (and can't) use the registry here since you can share
task descriptors as global variables in kernel space. If you want to
reach a server task created in kernel space, from kernel space, just
export the task descriptor of the server task (the one filled in by
rt_tassk_create()), and use it as is.

Btw: developing in kernel space is most often the wrong approach: this
is only aimed at supporting legacy applications (e.g. RTLinux / RTAI
based ones implemented as kernel modules). Xenomai always favours the
user-space programming model.

> I checked the message queue and pipe services and there seems to be
> the same problem, so I know, I am probably missing something.

Same answer.

> I thought of acessing the registry directly, but I read in some post
> that the nucleus API calls are supposed to only be used by other
> skins.

Indeed. Calling into the nucleus interface is always wrong and will
likely break at some point.
> 
> 2) Is it possible to use rt_task_send, receive and reply with
> applications that are compiled against the POSIX skin?
> 
No, because we need to have a native task TCB for these services to
work.

> Thanks, 
> Kai 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



