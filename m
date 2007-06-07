From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46685C21.5020709@domain.hid>
References: <200706071049.32906.ngustavson@domain.hid>
	<200706071311.09891.ngustavson@domain.hid> <46684CCB.8010806@domain.hid>
	<200706071337.07691.ngustavson@domain.hid> <46685C21.5020709@domain.hid>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 22:15:39 +0200
Message-Id: <1181247339.4998.150.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Fwd: can't use message pipe - Cannot
	allocate	memory
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2007-06-07 at 21:27 +0200, Jan Kiszka wrote:
> NZG wrote:
> >>> Write does stop throwing errors with a pool of 16384.
> >> Just repeating for confirmation: rt_pipe_create with smaller, but
> >> non-zero pool sizes doesn't report some error? 
> > Incorrect, if it's created with smaller it does report an error. If it's 
> > created with 0 however, it seems ok. (at least it doesn't throw an error)
> 
> You mean the write fails, but rt_pipe_create is fine. At least here, and
> Philippe noticed the same. Looks like the margin for minimal-sized heaps
> is broken. 2*PAGE_SIZE should be 3*PAGE_SIZE net space, Philippe?

Please leave me a few yea^H^H^Hmoments, I'm trying to understand my
code... Mpf.

> 
> > 
> >> Pipes are asymmetric: RT<->NRT only.
> > RT<->NRT is my goal.
> > essentially I 
> > 1. spawn off a real time task which creates a  pipe to receive commands
> > 2. throw commands at it from the user space thread which spawned the real time 
> > process (which is still NRT correct? I'm fuzzy on this).
> 
> It is NRT.
> 
> Jan
> 
-- 
Philippe.



