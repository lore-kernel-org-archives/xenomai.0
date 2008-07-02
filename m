Date: Wed, 02 Jul 2008 14:41:44 +0200
Message-Id: <853493434@domain.hid>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@domain.hid>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] latency in kernel mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, smolorz@domain.hid
Cc: xenomai@xenomai.org

Sorry, for my late answer.

I enabled the timerbench module, and installed it with the other modules (IRQ Benchmark and Context Switch).
The Switchtest test works, so I think the modules are correct installed and the tests are able to load them.
Does this mean the timerbench module isn't ok? Or are there other possible reasons, why the latency test still says:

bash-3.00# ./run -- -t 1
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Test mode: in-kernel periodic task
== All results in microseconds
latency: failed to start in-kernel timer benchmark, code -25
---|------------|------------|------------|--------|-------------------------
RTS|  267928.028|  805352.732|      32.768|       0|    00:00:07/00:00:07
bash-3.00#

I just want to add that I'm using a ppc405 on an Xilinx Virtex2pro (XUP Board), Linux v2.6.23xlnx, a rootFS from eldk4.1 and Xenomai 2.4.2.

Are there any other importent options in compiling the kernel. I thought perhaps there are good default values, which will do it for me in the beginning. 
My Real-time sub-system config: 
[*] Xenomai
 <*> Nucleus
 [*] Pervasive real-time support in user-space
 [ ] Interuppt shield support
 [*] Priority coupling support
 [*] optimize as pipeline head
 (32) number of pipe devices
 (512) Number of registry slots
 (128) Size of the system heap (Kb)
 [*] Statistics collection
 [ ] Debug Support
 [ ] Shared interuppts
 Timing --> [ ] Enable periodic timing
                  (0) Scheduling latency (ns)
 Scalability --> [ ] 0(1) scheduler
                       Timer indexing method (Linear) --> (X) Linear
                                                                               ( ) Tree
                                                                               ( ) Hash
Machine --> No options!
Interfaces --> Not in the mood to print all of this, but if it would help, i 'would do it.
Drivers --> only the three testing drivers as modules

Another Question I have is about the Output of my switchbench test:

bash-3.00# ./run -- -n 5000
*
*
* Type ^C to stop this application.
*
*
== Sampling period: 100 us
== Do not interrupt this program
RTH|       lat min|     lat avg|     lat max|        lost
RTD|      -29560|        5810|       49723|        4352
bash-3.00#

Is it normal that the lost number is that high? If not, what can i do?

Thanks for all your help.
Joachim
_________________________________________________________________________
In 5 Schritten zur eigenen Homepage. Jetzt Domain sichern und gestalten! 
Nur 3,99 EUR/Monat! http://www.maildomain.web.de/?mc=021114


