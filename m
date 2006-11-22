Subject: Re: [Xenomai-help] What returns rt_task_self in relation to
	rt_task_create
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20403318.1164195534169.JavaMail.ngmail@domain.hid>
References: <20403318.1164195534169.JavaMail.ngmail@domain.hid>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 14:09:55 +0100
Message-Id: <1164200995.5006.280.camel@domain.hid>
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2006-11-22 at 12:38 +0100, M. Koehrer wrote:
> Hi all,

> Background of the question:
> I want to write an application that uses a couple of similar tasks.
> I have to store some task-specific information (internal states...).
> Now I am looking for a simple way to get this information at runtime from my task
> by calling rt_task_self() (or something similar) to use this address to reach my
> additional information.
> 

Use pthread_getspecific() for obtaining back a TLS data previously
defined by pthread_setspecific(), indexed on a TLS key obtained from
pthread_key_create(). Warning: AFAICT, only pthread_getspecific()
refrain from performing any kind of Linux syscall (in the current NPTL
and older LinuxThreads implementation, that is), thus won't migrate your
RT task to secondary mode when called. The two others could call vanilla
kernel services, so you must use them during non-critical preliminary
init steps of your task.

-- 
Philippe.



