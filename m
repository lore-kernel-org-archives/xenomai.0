Subject: Re: [Xenomai-core] Re: [BUG] trunk: oops with Stephan's stress test
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45EC10B0.20906@domain.hid>
References: <45DEDED6.4070202@domain.hid>	<1172237401.26738.13.camel@domain.hid>
	<45DEED50.4070007@domain.hid>	<1172238537.26738.15.camel@domain.hid>
	<45DEF482.9030903@domain.hid>	<45E58CE3.20807@domain.hid>
	<45E58FB4.6070603@domain.hid>	<45E59574.50808@domain.hid>
	<45E599F1.5020205@domain.hid> <45E5A5DF.2060609@domain.hid>
	<45E5A725.7060408@domain.hid>  <45EC10B0.20906@domain.hid>
Content-Type: text/plain
Date: Sat, 31 Mar 2007 22:47:07 +0200
Message-Id: <1175374027.20140.47.camel@domain.hid>
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
To: Stephan Zimmermann <s.zimmermann@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Mon, 2007-03-05 at 13:44 +0100, Stephan Zimmermann wrote:
> Jan Kiszka schrieb:
> 
> > That happens when you overload your box with the test so that Linux does
> > not totally starve, just a bit too much so that it thinks it ran into a
> > soft-lockup. I've seen this here as well.
> 
> OK, you are right. My mistake.
> 
> But back to business, the Celeron M keeps crashing, even at 1 kHz. We 
> have figured out that it hast s.th. to do with rt_queue_create call. The 
> modified code we use for testing is attached to this mail. 
> 'queue_main.cpp' lets the system crash, while 'noqueue_main.cpp' does 
> not. The .config of the linux kernel is also attached.
> 
> Hopefully this helps to find a solution.

Unfortunately, I still cannot trigger this issue here. Here is what I'm
doing to try reproducing it:

- x86 kernel 2.6.20-1.7-03 stock, Xenomai v2.3.1 stock
- your Xenomai configuration, and specifically the nucleus and the
native interface built as modules, all Xenomai debug switches on,
watchdog on.
- booting and starting X
- running the following script in a loop for 100 times :
	modprobe xeno_nucleus
	modprobe xeno_native
	./queue_main
	rmmod xeno_native xeno_nucleus
- reboot (No obvious sign of system corruption, shutdown goes smoothly,
hw reboot is properly triggered after a graceful stop)

Does this match the way you are trigerring the iussue yourself?

-- 
Philippe.



