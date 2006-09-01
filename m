From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <17656.19065.549422.818297@domain.hid>
References: <1156941389.4323.17.camel@domain.hid> <1156942089.4323.29.camel@domain.hid>
	<17655.18827.661904.949733@domain.hid>
	<1157094795.4322.9.camel@domain.hid>
	<17656.11641.610980.162241@domain.hid>
	<1157121310.4981.18.camel@domain.hid>
	<17656.19065.549422.818297@domain.hid>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 20:02:15 +0200
Message-Id: <1157133735.4975.14.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Xenomai-help] [Fwd: Performance decrease]
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
Cc: xenomai@xenomai.org, xenomai@xenomai.org

On Fri, 2006-09-01 at 16:58 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > > 
>  > > But there is an exception: the "bind" syscall event must be intercepted
>  > > for threads that are not yet marked as monitored.
>  > 
>  > That's the major issue. We need to keep events flowing to a filtering
>  > callback in order to detect binding ops, but without going through the
>  > entire pipeline abstraction. And pipelining as it is now must be kept
>  > for bound Linux tasks, i.e. shadows. The idea is to save the time spent
>  > in the Adeos event dispatcher for tasks that don't need to tell the
>  > world about what they are actually doing.
> 
> The binding operation could be made a standard Linux operation, such as
> an ioctl for instance.
> 

Yes. We would have to define another character device node, but since we
are going to need this for Xenomai3, we would only be anticipating the
requirement anyway.

PS: moving this discussion to xenomai-core.

-- 
Philippe.



