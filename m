Date: Wed, 6 May 2009 16:12:17 -0700 (PDT)
From: Martin Shepherd <mcs@domain.hid>
Message-ID: <Pine.LNX.4.64.0905061412070.24701@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Xenomai-help] Selecting the appropriate RTDM _rt/_nrt ioctl at
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
To: xenomai@xenomai.org

I'm in the process of writing an RTDM device driver. Some of the ioctl
requests that it implements can only be executed from non-realtime
context, due to the need for them to call Linux kernel functions,
while other ioctl requests are context-agnostic, but are intended to
be used from realtime context.

At first glance the RTDM documentation appears to indicate that I
should implement the ioctl requests that require non-realtime context
in the ioctl_nrt() handler of the driver, and implement the remaining
context-agnostic requests in both the ioctl_nrt() and ioctl_rt()
handlers. However for this to work transparently, RTDM would have to
know which request codes were implemented by ioctl_nrt() and which by
ioctl_rt(), then automatically switch context, if needed, before
calling them.  I don't see anything implemented along these lines.

In principle I could tell application writers that they have to
explicitly switch to the secondary linux domain before calling
rt_dev_ioctl() for a request that requires this. However I don't see
any RTDM or Xenomai user-API call for switching contexts (other than
xnshadown_relax(), which is marked as for internal use only). I
imagine that one could do the equivalent by calling something like
sleep(0) to force a switch to the Linux domain. But this seems like a
kludge.

Am I missing something obvious?

Thanks,

Martin

