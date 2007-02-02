Subject: Re: [Xenomai-help] Error: cat: /proc/xenomai/stat: Cannot allocate
	memory
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <Pine.LNX.4.64.0702021456170.12191@domain.hid>
References: <19981456.1170405795640.JavaMail.ngmail@domain.hid>
	<1170408789.4981.1.camel@domain.hid> <1170409755.4981.11.camel@domain.hid>
	<45C309BF.9090808@domain.hid>  <1170415388.4981.36.camel@domain.hid>
	<1170420270.4981.58.camel@domain.hid>
	<Pine.LNX.4.64.0702021456170.12191@domain.hid>
Content-Type: text/plain
Date: Fri, 02 Feb 2007 15:31:59 +0100
Message-Id: <1170426719.4981.66.camel@domain.hid>
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
To: "Rus V. Brushkoff" <rus@domain.hid>
Cc: xenomai@xenomai.org

On Fri, 2007-02-02 at 14:59 +0200, Rus V. Brushkoff wrote:
> :> Yes, 2.6.19-1.6-04 (without nowcow) has the same problem. But the
> :> interesting things is that reading /proc/interrupts in loop seems to
> :> silently eat kernel memory by small chunks too. I'm now trying on a
> :> vanilla kernel.
> :Confirmed. A vanilla 2.6.19 silently eats memory when
> :reading /proc/interrupts in loop. Mathias, could you please confirm this
> :on your box too? TIA,
> 
>  Tested on K8 x86_64 SMP and K8 x86 UP : SMP system leaks memory, UP 
> doesn't.

Thanks. I do have a leak on UP here though; vmstat or any other command
do not eat this memory (at least neither ps or top report any continuous
growth of their vm space while running the test), so I would wildly
guess that's a kernel-based leakage occurring somewhere in the procfs
support.

> 
> :
> :
> 
> 		Rus
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



