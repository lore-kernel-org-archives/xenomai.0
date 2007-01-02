From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <459A31E3.40807@domain.hid>
References: <459A31E3.40807@domain.hid>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 14:22:29 +0100
Message-Id: <1167744149.30347.2.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: SVN checkin #2010
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Tue, 2007-01-02 at 11:20 +0100, Jan Kiszka wrote:
> Hi all - and happy new year,
> 
> I haven't looked at all the new code yet, only the commit messages. I
> found something similar to my fast-forward-on-timer-overrun patch in
> #2010 and wondered if Gilles' original concerns on side effects for the
> POSIX skin were addressed [1]. I recalled that my own final summary on
> this was "leave it as it is" [2].
> 

The best approach is to update the POSIX skin so that it does not rely
on the timer code to act in a sub-optimal way; that's why this patch
found its way in. Scheduling and processing timer shots uselessly is a
bug, not a feature in this case.

> Jan
> 
> [1]https://mail.gna.org/public/xenomai-core/2006-08/msg00122.html
> [2]https://mail.gna.org/public/xenomai-core/2006-08/msg00133.html
> 
-- 
Philippe.



