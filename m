Message-ID: <44390326.8020301@domain.hid>
Date: Sun, 09 Apr 2006 14:50:46 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4438F951.5010507@domain.hid>
In-Reply-To: <4438F951.5010507@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH] trigger I-pipe trace freezing via proc
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
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi Philippe,
> 
> here is a tiny patch to re-trigger trace freezing by writing a positive
> number to /proc/ipipe/trace/frozen. Writing 0 provides the old
> behaviour, i.e. resets the frozen trace so that ipipe_trace_freeze() can
> capture a new trace.
> 
> Please apply.
> 

Applied, thanks.

-- 

Philippe.

