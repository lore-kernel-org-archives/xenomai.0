From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17637.63157.596008.331241@domain.hid>
Date: Fri, 18 Aug 2006 19:19:49 +0200
Subject: Re: [Xenomai-core] Re: Test, benchmark
In-Reply-To: <44E5F0B4.8070405@domain.hid>
References: <44DA896F.9060102@domain.hid> <44DB1865.90004@domain.hid>
	<44DB9958.10109@domain.hid> <44DCAF88.2060801@domain.hid>
	<44E5F0B4.8070405@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jim Cromie <jim.cromie@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Jim Cromie wrote:
 > [ 1574.162754] Xenomai: starting RTDM services.
 > cpu 0: 2079 context switches.
 > cpu 0: 4212 context switches.
 > cpu 0: 6336 context switches.
 > cpu 0: 8442 context switches.
 > ...
 > cpu 0: 246981 context switches.
 > cpu 0: 249096 context switches.
 > cpu 0: 250263 context switches.
 > [ 1698.479703] Xenomai: stopping RTDM services.
 > 
 > wrt the data emitted, what can we learn from the numbers ?
 > They look to be increasing linearly, with some noise/perturbations.
 > We could do some statistics, but whats useful ?
 > Histogramming, averaging the delta-context-switches ?
 > 
 > Also, I see from the help-text that it does many kinds of context switches.
 > Does it make sense to run each kind for a bunch of samples,
 > so that we can see # and variation for each kind of switch ?

No, because one of the threads in the chain of context switches is
sleeping, otherwise the program would completely block your box. So, the
figures are largely irrelevant, the only important thing about them is
that they are increasing, it proves that the test is really switching
contexts. But the test fails if the value stop increasing, so no, the
output is useless. Note that if you add the -q option, the program will
be silent and only print the final count of context switches.

A question: I see that you always use the -n option, do you have
problems running the test without this option ? When launched with the
-n option switchtest does not test cpu context switches.

-- 


					    Gilles Chanteperdrix.

