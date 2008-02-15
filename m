Message-ID: <2ff1a98a0802150148g6c7f7e78k19a9a2a2b878ef2b@domain.hid>
Date: Fri, 15 Feb 2008 10:48:50 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <c73373920802150145g1dccc94ct6bb814150cfc7e4a@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c73373920802130829r496cfa8au24d6048ae9f50fd3@domain.hid>
	<2ff1a98a0802140142o538a956dva8f7d4f34bfbe415@domain.hid>
	<200802141053.02165.peter.soetens@domain.hid>
	<2ff1a98a0802140233y515a47d8wf8036ff1623311@domain.hid>
	<c73373920802150133h1eae9705qf4ba7bf61ecfcb6d@domain.hid>
	<c73373920802150145g1dccc94ct6bb814150cfc7e4a@domain.hid>
Subject: Re: [Xenomai-help] Why Xenomai kill my process?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Salvatore De Astis <dev.rinux@domain.hid>
Cc: xenomai@xenomai.org

On Fri, Feb 15, 2008 at 10:45 AM, Salvatore De Astis
<dev.rinux@domain.hid> wrote:
>
>
>
>
>  Hi at all,
> I'am sure that the same code run fine with Xenomai-2.1.1, kernel
> linux-2.6.15-ipipe-1.2-15.
> Why there are problems now?

Because now, xnpod_delete_thread sends a SIGKILL to the whole process
when not killing the current task.

> I want underline my purpose: my tasks should be exit in asyncronous way
> executing costom exit routine.
>  How can I do this in Xenomai?

run the custom cleanup routine from the deleted thread itself and call
rt_task_delete for the current task only.

> I've considered the use of rt_add_hook() but compiling the code the compiler
> returns these errors:
> warning: implicit declaration of function `rt_task_add_hook'
> undefined reference to `rt_task_add_hook'
>  collect2: ld returned 1 exit status

rt_task_add_hook is a kernel-space only service.

-- 
 Gilles Chanteperdrix

