References: <20210115011639.15390-1-hongzhan.chen@intel.com>
 <20210115011639.15390-5-hongzhan.chen@intel.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 5/8] dovetail/kevents: dovetail: implement
 handle_ptrace_cont
In-reply-to: <20210115011639.15390-5-hongzhan.chen@intel.com>
Date: Sat, 16 Jan 2021 13:31:16 +0100
Message-ID: <87sg71rrl7.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: hongzha1 <hongzhan.chen@intel.com>
Cc: xenomai@xenomai.org


hongzha1 via Xenomai <xenomai@xenomai.org> writes:

> Signed-off-by: hongzha1 <hongzhan.chen@intel.com>
>
> diff --git a/kernel/cobalt/dovetail/kevents.c b/kernel/cobalt/dovetail/kevents.c
> index b5dc50ea7..378017bea 100644
> --- a/kernel/cobalt/dovetail/kevents.c
> +++ b/kernel/cobalt/dovetail/kevents.c
> @@ -473,7 +473,7 @@ int handle_ptrace_resume(struct task_struct *tracee)
>  	return KEVENT_PROPAGATE;
>  }
>  
> -static void handle_ptrace_cont(void)
> +static void handle_ptrace_cont(struct task_struct *next_task)
>  {

Dovetail does not pass any argument to the client core along with
INBAND_TASK_PTCONT, because "current" may always be assumed. So
handle_ptrace_cont() receives no argument, and next_task is actually
"current" in this case.

The reason was that the I-pipe gave us no way to observe ptraced tasks
waking up from a stopped state, so we resorted to observing context
switches, figuring out when/if the incoming task was about to resume
from a ptrace-induced stopped state. Since Dovetail can send us such
event directly from the context of the resuming task, next_task ==
current in this context.

-- 
Philippe.

