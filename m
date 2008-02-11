Message-ID: <47B07FA4.8050801@domain.hid>
Date: Mon, 11 Feb 2008 18:02:28 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D376AD7@domain.hid>
	<47B053A2.9010503@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D376ADB@slcmail.slc.mew.int>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D376ADB@slcmail.slc.mew.int>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] overhead
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> The overhead was measured by only comparing cpu usage between tasks from
> the statistics collection stuff. There are some userland tasks running
> at 8khz, so apparently this is a problem for Xenomai on this board. I
> had no problem at all with these tasks in kernel space under rtai. 
> 
> There are no faults at all under /proc/xenomai/faults.
> 
> The main way I can tell something is wrong is that if my three fast
> tasks are running (8 khz in kernel space, 8 khz in userspace, and 50 hz
> in userspace) then a lower priority task will timeout and trip a
> watchdog. If I remove the IO routines from the 50hz task, then the
> others can still run.

I/O does not come for free (specifically on ISA HW - if that is the case
for you). But if you think that this makes a difference here, what about
measuring both kernel- and userland-based I/O accesses in a loop and
compare the runtime? This would also allow you to quantify the impact -
regardless if there is a difference or not.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

