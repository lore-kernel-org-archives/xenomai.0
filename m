Subject: Re: [Xenomai-help] Error: cat: /proc/xenomai/stat: Cannot allocate
	memory
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <Pine.LNX.4.64.0702040912210.300@domain.hid>
References: <19981456.1170405795640.JavaMail.ngmail@domain.hid>
	<1170408789.4981.1.camel@domain.hid> <1170409755.4981.11.camel@domain.hid>
	<45C309BF.9090808@domain.hid>  <1170415388.4981.36.camel@domain.hid>
	<1170420270.4981.58.camel@domain.hid>
	<Pine.LNX.4.64.0702021456170.12191@domain.hid>
	<1170426719.4981.66.camel@domain.hid>
	<Pine.LNX.4.64.0702021635150.12191@domain.hid>
	<Pine.LNX.4.64.0702031807260.22251@domain.hid>
	<1170520703.8282.6.camel@domain.hid>
	<Pine.LNX.4.64.0702040912210.300@domain.hid>
Content-Type: text/plain
Date: Sun, 04 Feb 2007 10:12:00 +0100
Message-Id: <1170580320.4208.1.camel@domain.hid>
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

On Sun, 2007-02-04 at 09:16 +0200, Rus V. Brushkoff wrote:
> On Sat, 3 Feb 2007, Philippe Gerum wrote:
> 
> :> Does anybody seeing memleak has nvidia module loaded ?
> :Not here.
> 
>  Ok, the last thing I've can see - seems like leak occured at the 
> boxes with some uptime - where any interrupt counter is big ehough (nearly 
> 9 decimal digits). Does anybody can confirm/disprove this suggestion ?
> 

I can reproduce the issue systematically even on a freshly booted box
reading /proc/interrupts in loop.

> :
> 
> 		Rus
-- 
Philippe.



