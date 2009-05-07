Message-ID: <4A029C21.2010605@domain.hid>
Date: Thu, 07 May 2009 10:30:25 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0905061412070.24701@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0905061412070.24701@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Selecting the appropriate RTDM _rt/_nrt ioctl at
	run-time.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: xenomai@xenomai.org

Martin Shepherd wrote:
> I'm in the process of writing an RTDM device driver. Some of the ioctl
> requests that it implements can only be executed from non-realtime
> context, due to the need for them to call Linux kernel functions,
> while other ioctl requests are context-agnostic, but are intended to
> be used from realtime context.
> 
> At first glance the RTDM documentation appears to indicate that I
> should implement the ioctl requests that require non-realtime context
> in the ioctl_nrt() handler of the driver, and implement the remaining
> context-agnostic requests in both the ioctl_nrt() and ioctl_rt()
> handlers. However for this to work transparently, RTDM would have to
> know which request codes were implemented by ioctl_nrt() and which by
> ioctl_rt(), then automatically switch context, if needed, before
> calling them.  I don't see anything implemented along these lines.
> 
> In principle I could tell application writers that they have to
> explicitly switch to the secondary linux domain before calling
> rt_dev_ioctl() for a request that requires this. However I don't see
> any RTDM or Xenomai user-API call for switching contexts (other than
> xnshadown_relax(), which is marked as for internal use only). I
> imagine that one could do the equivalent by calling something like
> sleep(0) to force a switch to the Linux domain. But this seems like a
> kludge.
> 
> Am I missing something obvious?

Maybe you want to study ksrc/drivers/serial16550A.c a bit. It comes with
some (IOCTL) use cases that should be similar to yours.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

