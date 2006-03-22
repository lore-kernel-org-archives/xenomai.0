From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17441.51298.263977.458028@domain.hid>
Date: Wed, 22 Mar 2006 22:57:54 +0100
Subject: Re: [Xenomai-core] yet another test tool
In-Reply-To: <17440.14775.987528.126782@domain.hid>
References: <441DD89A.4000501@domain.hid>
	<17438.51347.702261.525919@domain.hid>
	<441EDA08.7050900@domain.hid>
	<17438.65058.166546.339686@domain.hid>
	<441F1B05.1090505@domain.hid>
	<17440.14775.987528.126782@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>, xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
 > Philippe Gerum wrote:
 >  > The current implementation is one thing (we could fix it), the purpose 
 >  > of the tool is another, and actually, this is the latter which seems 
 >  > useful to me. By sharing some common tests between native preemption and 
 >  > real-time sub-systems like Xeno, we would make performance comparisons 
 >  > more relevant. 
 > 
 > Ok. I added the tool. I also had to add some cruft to configure.in to
 > get the --wrap flags in src/testsuite/cyclic/Makefile.
 > 
 > Now, running this test seem to have uncovered a bug with the binary heap
 > based timers that the latency test did not show. I am investigating on
 > this, but in the mean time, please do not enable the binary heap timers
 > option.

The bug was not due to the binary heap timers list, but to the fact that
the POSIX skin module (and other skins modules) did call
xnpod_stop_timer.

I removed all such calls of xnpod_stop_timer, since xnpod_shutdown calls
xnpod_stop_timer when needed (that is, only when shutting down the last
skin pod).

-- 


					    Gilles Chanteperdrix.

