From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17563.64513.188964.943550@domain.hid>
Date: Fri, 23 Jun 2006 16:34:41 +0200
Subject: Re: [Xenomai-core] [BUG] oops on skincall without nucleus being loaded
In-Reply-To: <449A7602.1020004@domain.hid>
References: <449A7261.7040503@domain.hid>
	<449A7602.1020004@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
 > Jan Kiszka wrote:
 > > Hi,
 > > 
 > > wondering why suddenly things crash on invoking the latency test, I
 > > realised that I turned the nucleus into a module which was not yet
 > > loaded. Here is the oops in this case:
 > 
 > Correction: the nucleus was still compiled in, the native skin was missing.

After a more thorough inspection, the problem was the xnshadow_p() call
at the very end of do_losyscall_event. When no pod is loaded this call
oopses.

-- 


					    Gilles Chanteperdrix.

