From: Henry Bausley <hbausley@deltatau.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 05 Aug 2013 16:05:03 -0700
Message-ID: <1375743903.7948.33.camel@lx-henry>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Using a PowerPC Critical Interrupt Input alongside Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org



I am experimenting with powerpc critical interrupts.  

Is it feasible  to use a powerpc Critical Interrupt along side xenomai?
What would I have to do in general to accomplish this?

  I have written to the appropiate powerpc registers to make the
interrupt critical.

  I have modified head_44x.S to call my own routine.
ie.
changed 

CRITICAL_EXCEPTION(0x0100, CriticalInput, unknown_exception)

to

CRITICAL_EXCEPTION(0x0100, CriticalInput, do_CIRQ) 


My critical interrupt handler even works a few times. I can even see my
xenomai shared memories from my own critical interrupt handler.
However , after a few interrupts my xenomai application faults. 







Outbound scan for Spam or Virus by Barracuda at Delta Tau


