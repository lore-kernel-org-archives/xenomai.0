Message-ID: <460D1452.8080400@domain.hid>
Date: Fri, 30 Mar 2007 15:44:50 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Newbie problem : xenomai 2.3.1 and kernel
	2.6.20.4installation problem
References: <5C40CD1E4697424ABDE3AC57CF1B22C6032202AC@FR0-MAILMB20.res.airbus.corp>
In-Reply-To: <5C40CD1E4697424ABDE3AC57CF1B22C6032202AC@FR0-MAILMB20.res.airbus.corp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "RAKOTOSALAMA, Nirilanto" <NIRILANTO.RAKOTOSALAMA@airbus.com>
Cc: xenomai@xenomai.org

RAKOTOSALAMA, Nirilanto wrote:
> 
>  > > Hello everybody !
>  > > 
>  > > I installed xenomai 2.3.0 on a FC6 linux distribution with vanilla kernel 2.6.19.7 following the
>  > > http://www.captain.at/xenomai-2.1-installation.php installation guide. 
>  > > It worked well until I install a new xenomai version (2.3.1) and linux kernel (2.6.20.4)
>  > > with the same kernel configuration than the first install.
>  > > The compilation and installation passed but when I run the xeno-test program, sometimes, it blocks
>  > > at the begining and I have to reboot the PC. Also, the cyclic testsuite program always blocks when I stop it pressing ctl-c.  
>  > > I have no problem with the latency test or others simple programs I made using rt_arlarm objects (I only use native skin).
>  > > 
>  > > When I launch the ancient kernel (which worked before) I have the same behaviour when I launch cyclic test and xeno-test.
> 
>  > This means that the problem lies in user-space. Could you launch
>  > xeno-test with bash -x to see what command of xeno-test blocks ? And
>  > attach gdb to the bloccked cyclictest to see where it is blocked ?
> 
> Strangely, I ran xeno-test 5 times and it did'nt hard lock.
> I ran bash -x xeno_test and it froze twice at :
> 	+date
> 	ven mar 30 09:44:27 CEST 2007
> 	+ echo running: cat /proc/xenomai/interfaces/rtdm
> 	running cat....
> 	+ eval cat /proc/xenomai/interfaces/rtdm
> 	++ cat /proc/xenomai/interfaces/rtdm
> 	+ wait 2953
> 
> Another strange behaviour : I stopped the xeno-test program pressing ctl-C and I
> entered commands in the console, and at the moment I heard the PC signal "beep", the PC froze. (it occurred twice)
> 
> I attached gdb to the cyclictest but, the program is supposed to freeze when I stop it pressing ctl-C
> and during debugging that only stops gdb and doesn't stop cyclictest.
> So I tried to find where it is blocked using printf() into cyclictest sources. But when I run cyclictest and I press ctl-C
> the PC doesn't freeze anymore but reboot. I restored the original cyclictest version and ran it, the PC rebooted.
> After I reinstalled xenomai (only /usr/xenomai) and when I stop the cyclictest, the PC reboots

I meant to attach gdb to cyclictest once it is blocked. But if the
machine reboots, it will be hard. Note that when adding printf to trace
the program termination, you should not add it in a signal handler, as
this could be the cause of deadlocks.

-- 
                                                 Gilles Chanteperdrix

