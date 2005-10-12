Message-ID: <434D21A7.8040905@domain.hid>
Date: Wed, 12 Oct 2005 16:45:59 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] remove_proc_entry problem semi-tracked down
References: <BF726CBF.17F0%steve@domain.hid>
In-Reply-To: <BF726CBF.17F0%steve@domain.hid>
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
To: Steven Seeger <steve@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> The kernel panic in remove_proc_entry happens when a userspace fusion app
> calls a xenomai function that deletes something from the register in atexit.
> For example, I have a set of c++ classes that wrap mutexes, queues, etc. If
> I have a global instance, it sometimes causes a kernel panic in the
> destructor where the rt_mutex_delete, rt_queue_delete, etc, is called. This
> seems to always happen with rt_queue_delete, but not always with
> rt_mutex_delete. (A couple of starts/stops seem to create the problem.)
> 
> This is when exiting with a call to exit(0), not with a control-c.
> 

Please (re)send the panic stack dump you get.

-- 

Philippe.

