Date: Fri, 2 Feb 2007 14:59:18 +0200 (EET)
From: "Rus V. Brushkoff" <rus@domain.hid>
Subject: Re: [Xenomai-help] Error: cat: /proc/xenomai/stat: Cannot allocate
	memory
In-Reply-To: <1170420270.4981.58.camel@domain.hid>
Message-ID: <Pine.LNX.4.64.0702021456170.12191@domain.hid>
References: <19981456.1170405795640.JavaMail.ngmail@domain.hid>
	<1170408789.4981.1.camel@domain.hid> <1170409755.4981.11.camel@domain.hid>
	<45C309BF.9090808@domain.hid>  <1170415388.4981.36.camel@domain.hid>
	<1170420270.4981.58.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
Cc: xenomai@xenomai.org

:> Yes, 2.6.19-1.6-04 (without nowcow) has the same problem. But the
:> interesting things is that reading /proc/interrupts in loop seems to
:> silently eat kernel memory by small chunks too. I'm now trying on a
:> vanilla kernel.
:Confirmed. A vanilla 2.6.19 silently eats memory when
:reading /proc/interrupts in loop. Mathias, could you please confirm this
:on your box too? TIA,

 Tested on K8 x86_64 SMP and K8 x86 UP : SMP system leaks memory, UP 
doesn't.

:
:

		Rus

