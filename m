From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16143.52321.271972.985045@domain.hid>
Date: Sat, 12 Jul 2003 10:52:49 +0200
Subject: [Adeos-main] a few questions
In-Reply-To: <200307120723.h6C7NmW06778@domain.hid>
References: <200307120723.h6C7NmW06778@domain.hid>
List-Id: <adeos-main.nongnu.org>
List-Unsubscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <http://mail.gnu.org/pipermail/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <http://mail.nongnu.org/mailman/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Der Herr Hofrat <der.herr@domain.hid>
Cc: adeos-main@gna.org


Hi,

Der Herr Hofrat writes:
 > 
 > HI !
 > 
 >  reading my wai into adeos - so pleas excuse if these question are stupid..
 >  after reading the docs on adeos.org and a few comments in the 
 >  RTAI mailng list a few questions arose:
 > 
 >  1) Is ther and example of running multiple domains under adeos

You can find a trivial code which loads a domain module intercepting
the timer IRQ here:
http://savannah.nongnu.org/cgi-bin/viewcvs/adeos/adeos/platforms/linux/examples/simple/.

For a more complex implementation, there's something in RTAI's ongoing
magma development branch called the "Xenomai skins" which runs three
concurrent domains:

o the RTAI domain (priority=200)
o the Xenomai domain (priority=150)
o the (root) Linux domain (priority=100)

RTAI runs real-time tasks with memory protection created by RTOS
emulators mounted by Xenomai, and the Xenomai domain shields
interrupts from the Linux domain when needed to guarantee determinism.
IOW, the event flow goes this way:
[IRQ/traps] ==> RTAI -> Xenomai -> Linux, each of them being able to
decide whether the next domain down the pipeline should be passed the
event or not.

 > (exept for RTAI which is not completly independant (?) of the root domain - atleast it does not seem posible to run multiple instances of RTAI in paralell ?

In fact, it is indeed logically independent once the root domain has
loaded the RTAI one. One could take the Adeos-based HAL, only change
its domain priority and load it as-is, concurrently to the original
RTAI domain for running kernel-based tasks.  Have a look to
arch/i386/arti.c from the RTAI "etna" or stromboli" branches, or
rtai-core/arch/i386/hal/arti.c from the "magma" branch.

 >  Has anybody ran multiple Linux or other OS'under ADEOS
 >  and are there any docs about this ??
 >
 >  2) for shared resources - Network cards etc. - the
 >     Root domain driver is responsible (or a root-domain-process) for
 >     dispatching the domain specific data (i.e. a ip-packet for a 
 >     specific domain)a
 > 

Running multiple concurrent Linux instances using Adeos on a single
box would indeed require to decide about which instance/domain
controls which set of hardware resources and system software, and use
some kind of virtual relay to honor inter-domain requests. But as of
now, there has not been much work on this application of the Adeos
scheme (none that I know of to be precise).

Philippe.


