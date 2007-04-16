From: Jeff Weber <jweber@domain.hid>
Date: Mon, 16 Apr 2007 16:27:01 -0500
References: <200704161449.27506.jweber@domain.hid>
	<200704161520.53584.jweber@domain.hid>
	<17955.57309.169970.14672@domain.hid>
In-Reply-To: <17955.57309.169970.14672@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704161627.01925.jweber@domain.hid>
Subject: Re: [Xenomai-help] page faults
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai Help <xenomai@xenomai.org>

On Monday 16 April 2007 15:43, Gilles Chanteperdrix wrote:
> If the fault you observe is due to an access to some memory after a call
> to fork or one of its derivative (such as system, popen, etc...), the
> patch would have copied the whole real-time process address space at
> fork time instead of setting up COW mappings.
No process forks are involved.  Though mlockall() was called from Linux 
main(), and the page fault was encountered by a separate Xenomai task.  
Here's the task history:

static constructor allocates buffer from heap
enter main()
call mlockall(), verify return status == 0
buffer is forcibly cleared using memset(buffer, 0, sizeof(buffer))
main calls rt_task_shadow() to create Xenomai startup task
startup task spawns Xenomai communications task via rt_task_start()
communications task encounters page fault

Let me know if you are able to spot the source of the page faults.

	thanks,
	Jeff

