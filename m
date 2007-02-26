Message-ID: <45E2B251.9040506@domain.hid>
Date: Mon, 26 Feb 2007 11:11:29 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid>
	<45DEE913.9080809@domain.hid>	<45DEF122.2060406@domain.hid>
	<45DEF605.2060402@domain.hid> <45DEF6AA.5030609@domain.hid>
	<45DEFBEA.7010407@domain.hid> <45DEFC86.8090809@domain.hid>
	<45DEFD29.2030301@domain.hid>
In-Reply-To: <45DEFD29.2030301@domain.hid>
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

>>> BTW, do you have the nucleus option "disable priority coupling" set or
>>> not in your config (the latter is default, ie. it's on)? The other bug
>>> is triggered when prio coupling is on, and doesn't appear while it's
>>> off. Just to collect more patterns...
>> CONFIG_XENO_OPT_PRIOCPL=y
> 
> [Ah, using trunk already]
> 
> Mind given a try what happens when it's off?

I switched it off:

# CONFIG_XENO_OPT_PRIOCPL is not set

Still It crashes/hangs after some time.
You want to see the log file?
I assume it will look pretty much the same ...

--
Steven

