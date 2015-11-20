Message-ID: <trinity-17288378-c85b-4966-9ff0-d55ecc9b4a19-1448001870373@3capp-webde-bap02>
From: JK.Behnke@web.de
Date: Fri, 20 Nov 2015 07:44:30 +0100
In-Reply-To: <20151119202109.GA2972@hermes.click-hack.org>
References: <trinity-4e7fb472-a4bb-442c-a8c9-6c8a9ebe09cc-1447920592443@3capp-webde-bap51>
 <20151119085558.GB29706@hermes.click-hack.org>
 <trinity-cacbcd3c-ab7f-431a-a768-a9dddeae4b84-1447929286225@3capp-webde-bap51>,
 <20151119202109.GA2972@hermes.click-hack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] rtdm_clock_read overhead/accuracy question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

   Hello Gilles,
   >On Thu, Nov 19, 2015 at 11:34:47AM +0100, JK.Behnke@web.de wrote:
   >> Hello Gilles,
   >>
   >> many thanks for your help up to now.
   >> I still have some questions, see below.
   >>
   >> >On Thu, Nov 19, 2015 at 09:09:52AM +0100, JK.Behnke@web.de wrote:
   >> >> >On Wed, Nov 18, 2015 at 06:11:00PM +0100, JK.Behnke at web.de
   >> wrote:
   >> >> >> Hello Gilles,
   >> >> >>
   >> >> >> >On Wed, Nov 18, 2015 at 03:36:25PM +0100, JK.Behnke at web.de
   >> wrote:
   >> >> >> >> Hello Gilles,
   >> >> >> >>
   >> >> >> >> thanks for your quick response.
   >> >> >> >> See my comments/questions below.
   >> >> >> >>
   >> >> >> >> >On Wed, Nov 18, 2015 at 02:34:56PM +0100, JK.Behnke at
   web.de
   >> wrote:
   >> >> >> >> >> Hello,
   >> >> >> >> >>
   >> >> >> >> >> I'm currently debugging a problem in my xenomai
   >> application.
   >> >> >> >> >> In order ot get timing information I do the following
   >> inside the
   >> >> >> >> >> read-handler of my rtdm driver.
   >> >> >> >> >>
   >> >> >> >> >> // --- start code snippet
   ---------------------------------
   >> >> >> >> >> nanosecs_abs_t t1, t2;
   >> >> >> >> >> rtdm_lock_get_irqsave(&lockobj, lockctx);
   >> >> >> >> >>
   >> >> >> >> >> t1=rtdm_clock_read();
   >> >> >> >> >> rtdm_task_busy_sleep(10000); // code block to be
   measured.
   >> >> >> >> >> t2=rtdm_clock_read();
   >> >> >> >> >>
   >> >> >> >> >> rtdm_lock_put_irqrestore(&lockobj, lockctx);
   >> >> >> >> >> // --- end code snippet
   ---------------------------------
   >> >> >> >> >>
   >> >> >> >> >> I observe the following time differences t2-t1:
   >> >> >> >> >> min=10176 ns, max=10737 ns, avg=10314 ns
   >> >> >> >> >>
   >> >> >> >> >> This means in this case the average overhead of the two
   >> rtdm_clock_read
   >> >> >> >> >> calls is
   >> >> >> >> >> approximately 314 ns/2 = 157 ns.
   >> >> >> >> >
   >> >> >> >> >No, this means that the average overhead of
   rtdm_clock_read
   >> is
   >> >> >> >> >314ns.
   >> >> >> >> >
   >> >> >> >> >what you do is:
   >> >> >> >> >read time
   >> >> >> >> >convert to ns
   >> >> >> >> >busy sleep
   >> >> >> >> >read time
   >> >> >> >> >convert to ns
   >> >> >> >> >
   >> >> >> >> >As you can see, between the two time reads, there is only
   one
   >> >> >> >> >conversion to nanoseconds, (which we assume is the bulk of
   >> the
   >> >> >> >> >overhead). And more generally, the overhead of the second
   >> time read
   >> >> >> >> >is not counted either.
   >> >> >> >> >
   >> >> >> >> >
   >> >> >> >> >>
   >> >> >> >> >> Is that realistic?
   >> >> >> >> >
   >> >> >> >> >This seems to be a lot. The "tsc" test will measure the
   >> average
   >> >> >> >> >difference between two time reads, and the "arith" test
   will
   >> measure
   >> >> >> >> >the average time for a "multiply then shift" operation,
   >> adding the
   >> >> >> >> >two should give you an idea of the overhead. From what I
   >> recall,
   >> >> >> >> >reading the tsc on an atom N230 (a very old one) had an
   >> overhead
   >> >> >> >> >around 20ns.
   >> >> >> >> Where do I find the "tsc test", which test application do I
   >> have to run?
   >> >> >> >
   >> >> >> >The application is named "tsc".
   >> >> >>
   >> >> >> Thanks, meanwhile I found the tsc tool under
   >> >> >> /usr/xenomai/bin/regression
   >> >> >
   >> >> >Yeah, well, not a very good default directory. You can onverride
   it
   >> >> >with an option from the configure script.
   >> >> >
   >> >> >>
   >> >> >> Here are my "tsc" results
   >> >> >> Atom E640 (1.0 GHz): min: 26, max: 936, avg: 34.0001 ->
   0.0262211
   >> us ==> 26 ns
   >> >> >> Atom E660 (1.3 GHz): min: 26, max: 1105, avg: 34.0001 ->
   >> 0.0262211 us ==> 26 ns
   >> >> >
   >> >> >Well, there is a problem with the time conversion routines. 34
   >> >> >cycles on a 1.0 GHz machine should be 34ns, not 26ns. Other than
   >> >> >that, it seems consistent with what I observe on my old atom.
   >> >>
   >> >> What can I do about that?
   >> >
   >> >Check the boot to see what frequency xenomai uses, and follow all
   >> >the operations which compute the constants used for time
   conversion.
   >> >The frequency is probably the culprit though.
   >> I can't find any hint on the frequency used by xenomai.
   >> The single line I get by dmesg is:
   >> tsc: Refined TSC clocksource calibration: 997.507 MHz
   >>
   >> Where do I get the right information?
   >
   >Xenomai on x86 uses the "cpu_kHz" variable, the one reported divided
   >by 1000 in /proc/cpuinfo
   >
   >> Where should I start digging in the sourcecode?
   >
   >Start by posting the full logs. From the bootloader up to the moment
   >when the root filesystem is mounted.
   >
   >> >You should upgrade to Xenomai 2.6 git head also, in case the issue
   >> >you have has already been fixed.
   >> >
   >> How can I verify that time conversion is working?
   >
   In the meantime I probably found the cause.
   After having upgraded to xenomai 2.6.4 it worked correctly.
   Then I switched back to xenomai 2.6.3 and it still worked correctly.
   As I have multiple systems used for testing (1.0 GHz and 1.3 GHz CPUs),
   I think that I probably mixed them up at some point in time during
   testing.
   26ns correlates with 34 cycles on a 1.3 GHz CPU.
   On the 1.0 GHz CPU the tsc tool returns 34ns as result.

   Sorry for bothering you with that problem and thanks again for your
   help.
   Nevertheless for me it was very instructional.

   Regards
   Jochen
