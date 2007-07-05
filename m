From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <468D2728.6010308@domain.hid>
References: <468A8599.60305@domain.hid>  <468D2728.6010308@domain.hid>
Content-Type: text/plain
Date: Thu, 05 Jul 2007 19:42:33 +0200
Message-Id: <1183657353.2631.168.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] kernel boot problem, possibly hanging on	interrupts
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Will Wiles <wilesw@domain.hid>
Cc: adeos-main@gna.org

On Thu, 2007-07-05 at 13:15 -0400, Will Wiles wrote:
> Using the low-level debugging tools makes the kernel hang earlier, so 
> I'm starting to think it is a more serious problem with the interrupt 
> handling that I first expected.
> 
> Below is the 2.6.17 patch, I was wondering if anyone had an ARM setup 
> around that they could use this ipipe patch on and get a successful 
> boot.  It's hard for me to verify since I only have one setup and the 
> debugging tools aren't helpful in this scenario.
> 
> 

Which "low-level debugging tools" are enabled? (.config would help).

A verbatim copy of the boot messages would help trying to figure out
where the problem starts too.

-- 
Philippe.



