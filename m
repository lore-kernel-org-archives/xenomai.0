Subject: Re: [Xenomai-core] latency hangs on AT91RM9200
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45DEE913.9080809@domain.hid>
References: <45DECFAF.60304@domain.hid>  <45DEE913.9080809@domain.hid>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 14:26:26 +0100
Message-Id: <1172237186.26738.8.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai-core@domain.hid

On Fri, 2007-02-23 at 14:16 +0100, Gilles Chanteperdrix wrote:

> I do not think to remember that there are cases where calling schedule
> from a real-time context is done by Xenomai, so maybe you can call panic
> in schedule instead of returning. I will try and trig a tracer freeze
> and dump the tracer at this point in order to have a better idea of what
>  happens.
> 

True. Just BUG() instead of returning from schedule() in this case would
do.

-- 
Philippe.



