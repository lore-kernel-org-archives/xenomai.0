Message-ID: <4491755C.5010308@domain.hid>
Date: Thu, 15 Jun 2006 16:57:32 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4491426B.50508@domain.hid>
In-Reply-To: <4491426B.50508@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [PATCH] use vmalloc'ed trace buffer
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
> here is the cleaned up and configurable version of my vmalloc hack for
> the I-pipe tracer.
> 
> As it has a slight performance impact to use virtual memory for the
> trace buffer (running "hackbench 10" in parallel to "latency -p 100" on
> a 266 MHz P-MMX: 227 vs. 244 s hackbench runtime), I left this option
> off by default. If there is any kind of CONFIG combination that cries
> for default on, we can easily add it.
> 

Ack. Merged in my tree, thanks.

-- 

Philippe.

