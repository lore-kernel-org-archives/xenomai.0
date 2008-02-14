Message-ID: <2ff1a98a0802140142o538a956dva8f7d4f34bfbe415@domain.hid>
Date: Thu, 14 Feb 2008 10:42:23 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <c73373920802130829r496cfa8au24d6048ae9f50fd3@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c73373920802130829r496cfa8au24d6048ae9f50fd3@domain.hid>
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

On Wed, Feb 13, 2008 at 5:29 PM, Salvatore De Astis <dev.rinux@domain.hid> wrote:
> Hi,
> I need to implement a multitask application.
> The most important point is to have a 'custom' exit procedure for each task.
> The calling of the exit procedure should happen in asynchronous mode.
> The exit procedure of each task, after the 'custom' code, must call  the
> rt_task_delete()   before leaving.
>
> The following code is a simple example:
> There are two tasks, two semaphores and two other tasks (pending on
> semaphores) whose target is to execute the parent's exit procedure.
> In this case the exit procedure is the my_exit() routine for both tasks,
> but, of course, I'd like to have custom exit procedure for each task.
>  Please read the questions following the code section.
>
> Why the opaque2 is 0 in Pippo's rt_task_delete call? Dmesg shows me
> 3086322608 in __rt_task_create() of Pippo task.
> What's wrong with my code?
>  Does a better method exist to implemet  asyncronous rt_task_delete in
> Xenomai?

The best way to do what you want to do is to call rt_task_delete from
the task to be deleted itself, because trying to delete a thread from
another thread entails problems which can only be solved by sending a
SIGKILL to the whole application.

However, have you noted that Xenomai automatically deletes per-process
objects upon process termination  ? So maybe you do not really need a
complicated cleanup mechanism.

-- 
 Gilles Chanteperdrix

