Message-ID: <45DF021A.3080807@domain.hid>
Date: Fri, 23 Feb 2007 16:02:50 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid>
	<45DEE913.9080809@domain.hid>	<45DEF122.2060406@domain.hid>
	<45DEF605.2060402@domain.hid> <45DEF6AA.5030609@domain.hid>
	<45DEF872.5050608@domain.hid>
In-Reply-To: <45DEF872.5050608@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
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
Cc: Xenomai-core@domain.hid

Jan,

>> So what exactly shell I do? I have never worked with "the tracer".
>>
> 
> Start here: http://www.xenomai.org/index.php/I-pipe:Tracer
> 
> I haven't followed all details (while hacking on other bugs :)), but you
> have two options to catch a trace: the one described on that page *if*
> your board survives the crash, or via ipipe_trace_panic_freeze()
> followed by ipipe_trace_panic_dump() (+ switching to sync printk mode
> first).

Do I need CONFIG_IPIPE_TRACE_MCOUNT=y for the ipipe_trace_panic_dump()?

Steven

