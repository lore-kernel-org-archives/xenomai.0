Subject: Re: [Xenomai-help] Multiple NIC trouble
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <cbe23c50702061337yc411319l881b9402e4677d6d@domain.hid>
References: <cbe23c50702061337yc411319l881b9402e4677d6d@domain.hid>
Content-Type: text/plain
Date: Wed, 07 Feb 2007 00:39:43 +0100
Message-Id: <1170805184.23915.94.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Eric Noulard <eric.noulard@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On Tue, 2007-02-06 at 22:37 +0100, Eric Noulard wrote:
> I am about to begin to use Xenomai
> on a dual-core x86_64 box.
> 
> I installed FC6 i386 (32bits) since the adeos patch for x86_64
> was not there when I did the install, I may go back
> to run xenomai on x86_64 since I install both systems (x86_64 and i386)
> 

Xenomai x86_64 is not ready for prime time anyway.

[...]

> How would you suggest me to investigate that problem?
> 

- try disabling Xenomai (CONFIG_XENOMAI) while keeping the interrupt
pipeline (CONFIG_IPIPE) enabled; does the kernel boot properly?

- What does /proc/interrupts say on a sane configuration (i.e. that
boots)?

-- 
Philippe.



