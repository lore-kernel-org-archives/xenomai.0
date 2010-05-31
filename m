From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1275328749.27918.92.camel@domain.hid>
References: <4C03EC77.30502@domain.hid>
	<1275328749.27918.92.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 May 2010 20:03:05 +0200
Message-ID: <1275328985.27918.94.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] ipipe-2.6.34-x86-2.6-04: The magical RAM increaser
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main <adeos-main@gna.org>

On Mon, 2010-05-31 at 19:59 +0200, Philippe Gerum wrote:
> On Mon, 2010-05-31 at 19:05 +0200, Jan Kiszka wrote:
> > Hi Philippe,
> > 
> > something is fishy in I-pipe for 2.6.34 (both w/ and w/o Xenomai,
> > goes away once I-pipe is off):
> > 
> > top - 18:55:26 up 3 min,  2 users,  load average: 2.09, 1.42, 0.58
> > Tasks:  60 total,   1 running,  59 sleeping,   0 stopped,   0 zombie
> > Cpu(s):  0.0%us, 24.7%sy,  0.0%ni, 75.3%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
> > Mem:   1012496k total,   121264k used,   891232k free,     4676k buffers
> > Swap:  1156644k total,        0k used,  1156644k free,    80748k cached
> > 
> >   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> >  5636 root      20   0 51776 3.7t 3.7t S  0.0 392333.0   0:00.01 sshd
> >  4195 haldaemo  20   0 34220 1.8t 1.8t S  0.0 188901.4   0:02.10 hald
> >  5327 root      20   0 19036 1.5t 1.5t S  0.0 159839.4   0:00.15 syslog-ng
> >  5495 root      20   0  164m 1.4t 1.4t S  0.0 145308.6   0:00.23 nscd
> >  5563 root      20   0 16240 1.4t 1.4t S  0.0 145308.6   0:00.01 smartd
> >  5523 root      20   0 10204 982g 982g S  0.0 101716.0   0:00.01 avahi-dnsconfd
> >  5330 root      20   0  4012 701g 701g S  0.0 72654.3   0:00.04 klogd
> >  4154 root      20   0  3872 561g 561g S  0.0 58123.4   0:00.04 acpid
> >  5991 root      20   0 13264 2356 1596 S  0.0  0.2   0:00.34 bash
> > 
> > I swear this machine does *not* yet have Tera bytes of RAM (just 1G).
> > 
> > Looks like /proc/<pid>/stat is broken, likely even something deeper.
> > Philippe, did you ran into suspicious conflicts in the mm subsystem
> > while rebasing over this kernel? Any spontaneous idea?
> 
> Bad hunks in mm/memory.c.

This might even date back to 2.6.33, with changes in the vm accounting
IIRC.

> 
> > 
> > Jan
> > 
> 
> 


-- 
Philippe.



