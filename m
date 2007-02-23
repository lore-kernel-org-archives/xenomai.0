Message-ID: <45DEF6AA.5030609@domain.hid>
Date: Fri, 23 Feb 2007 15:14:02 +0100
From: Steven Scholz <steven.scholz@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
References: <45DECFAF.60304@domain.hid> <45DEE913.9080809@domain.hid>
	<45DEF122.2060406@domain.hid> <45DEF605.2060402@domain.hid>
In-Reply-To: <45DEF605.2060402@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

Gilles,

>> Sure but I would still not expect the system to hang!
>> As I said missing a deadline is bad but ok.
>> But hanging the whole system is not quite ok.
> 
> I want this bug solved too, especially since I am not sure that we will
> only see it with too short periods.

Makes us two! ;-)

> I would add the call to printascii(printk_buff) directly in vprintk, and
> use printk. Note however that special care must be taken to avoid
> recursion when calling printk inside schedule, because printk may use
> schedule. Anyway, I think the tracer will give better results than a
> simple backtrace.
Ok. Thanks.

So what exactly shell I do? I have never worked with "the tracer".

Steven

