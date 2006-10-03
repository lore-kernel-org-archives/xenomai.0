Message-ID: <4522840E.50708@domain.hid>
Date: Tue, 03 Oct 2006 10:38:54 -0500
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] POSIX API Questions
References: <J6JUZA$835CBCA6714D18503B21543C9C3611BE@laposte.net>
In-Reply-To: <J6JUZA$835CBCA6714D18503B21543C9C3611BE@laposte.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

gilles.chanteperdrix wrote:
> The main thread is automatically shadowed by the POSIX skin
> library initialization routine. Most people need this anyway
> and if they do not need it, it is harmless.

Thanks.  That sounds like a good policy.

> A word about the process termination: using atexit is error
> prone, because the registered callback get called in the
> context of the thread that is calling exit, before the
> cancellation handlers are called, so for example if a thread
> is calling exit while holding a mutex and the routine
> registered with atexit need to lock the same mutex, the program
> deadlocks. I experienced various issues trying to terminate
> cleanly a posix application, the method I would advise is the
> one used by the switchtest program.

I will take a look at this.  Thanks.

> I do not see anything suspicious, but in order to be sure you can
> use pthread_set_mode_np(0, PTHREAD_WARNSW) to cause a SIGXCPU
> signal to be sent when the calling thread involontary switches to
> secondary mode. See:
> http://www.xenomai.org/documentation/trunk/html/api/group__posix__thread.html#ga14

That's exactly what I need.

Thanks for the advice,

Jeff


