From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17889.46252.70825.137576@domain.hid>
Date: Sun, 25 Feb 2007 17:09:16 +0100
Subject: Re: [Xenomai-core] x86_64 - Initial results.
In-Reply-To: <200702251557.19205.paul_c@domain.hid>
References: <200702241526.22786.paul_c@domain.hid>
	<200702250106.32393.paul_c@domain.hid> <45E15EAA.1040300@domain.hid>
	<200702251557.19205.paul_c@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul <paul_c@domain.hid>
Cc: Jan Kiszka <jan.kiszka@domain.hid>, xenomai@xenomai.org

Paul wrote:
 > On Sunday 25 February 2007 10:02, Jan Kiszka wrote:
 > > >> Rather the CONFIG_IPIPE_TRACE feature, with the IRQs off tracking option
 > > >> set
 > 
 > > Please grab trace/frozen instead, enable verbose mode, and increase
 > > back_trace_points so that the reported latency is fully covered. See
 > 
 > OK - Recompiled with the 1.04 patch for UP with the ipipe trace support. After 
 > cutting Xorg's configs to a minimum (vesa driver, no Glx/dri
 > support),

If you want to disable X acceleration, you should add :

Option "NoAccel"

in the "Device" section of your X configuration file.
 
 > latency runs OK and reports some pretty horrible numbers when X starts (no 
 > WM). Enabling the tracer, and starting/stopping X, the system either locks up 
 > or latency goes in to a zombie state.
 > 
 >  The attached trace logs provide little information - Also included dmesg and 
 > kernel config.

-- 


					    Gilles Chanteperdrix.

