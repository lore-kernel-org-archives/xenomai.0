Message-ID: <470F7927.7000700@domain.hid>
Date: Fri, 12 Oct 2007 15:39:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <470E8BFE.4070804@domain.hid> <1192179524.5149.23.camel@domain.hid>
	<470F3B03.1040501@domain.hid>
	<20071012110054.GA26325@domain.hid>
	<470F5753.5020809@domain.hid>
	<20071012131938.GA31893@domain.hid>
In-Reply-To: <20071012131938.GA31893@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH] fix hw-timer setup/cleanup for i386
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stelian Pop <stelian@domain.hid>, Xenomai-core@domain.hid

Stelian Pop wrote:
> On Fri, Oct 12, 2007 at 01:15:31PM +0200, Jan Kiszka wrote:
> 
>>> root@domain.hid# cat /proc/ipipe/trace/max
>> /frozen holds the result. Also, a bit more post_trace_points may help to
>> see what goes on after that function is called.
> 
> Ah, sorry. Here it comes, with post_trace_points set to 100:
> 
...
> :    +func                  -6    0.209  xnarch_get_cpu_time+0x8 (xnpod_enable_timesource+0xa0)
> :    +func                  -6    0.094  rthal_get_8254_tsc+0xe (xnarch_get_cpu_time+0xd)

Ah, CONFIG_M486. Try to pick a less generic CPU type, maybe TSC-less
support got broken recently.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

