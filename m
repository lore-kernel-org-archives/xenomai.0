Subject: Re: Antwort: Re: Antwort: Re: [Xenomai-core] Questions about pSOS
	task mode and task priority
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <OF57C5E5AF.FD2C8432-ONC1257272.005A3F8F@uk.marconicomms.com>
References: <OF57C5E5AF.FD2C8432-ONC1257272.005A3F8F@uk.marconicomms.com>
Content-Type: text/plain
Date: Wed, 31 Jan 2007 01:42:17 +0100
Message-Id: <1170204137.21219.52.camel@domain.hid>
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

Ok, confirmed, I've spotted the issue. It's an interesting corner case
due to the task creation/start protocol that definitely needs more brain
cycles to be solved properly. More later, thanks for reporting this.

-- 
Philippe.



