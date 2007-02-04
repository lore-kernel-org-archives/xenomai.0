Subject: Re: Antwort: Re: Antwort: Re: [Xenomai-core] Questions about pSOS
	task mode and task priority
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <OF57C5E5AF.FD2C8432-ONC1257272.005A3F8F@uk.marconicomms.com>
References: <OF57C5E5AF.FD2C8432-ONC1257272.005A3F8F@uk.marconicomms.com>
Content-Type: text/plain
Date: Sun, 04 Feb 2007 12:59:40 +0100
Message-Id: <1170590381.4208.26.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Markus Osterried <Markus.Osterried@domain.hid>
Cc: xenomai@xenomai.org, Thomas Necker <Thomas.Necker@domain.hid>

On Mon, 2007-01-29 at 17:41 +0100, Markus Osterried wrote:
> Hi Philippe,
> 
> see below a code snippet for demonstration of the task priority problem.
> The expected behaviour is that the new task is running immediately after
> lowering root's priority.
> The log of the reached statements should therefor be: 1, 10, 2, 3, 4, 5
> But instead the log is: 1, 2, 3, 4, 10, 5, i.e. the new task is running
> only after blocking root task.
> 

This issue has been addressed in the v2.3.x maintenance branch and
trunk/, so the fix will be available with v2.3.1 and above.

> About your question regarding the preemtible bit:
> The task should always be non-preemtible, also after it is unblocked.

Also fixed in v2.3.x and trunk/, since we now allow for sleeping
scheduler locks.

-- 
Philippe.



