MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17564.11393.93645.251930@domain.hid>
Date: Fri, 23 Jun 2006 20:01:37 +0200
Subject: Re: [Xenomai-core] [BUG] oops on skincall without nucleus being loaded
In-Reply-To: <1151079971.4438.103.camel@domain.hid>
References: <449A7261.7040503@domain.hid> <449A7602.1020004@domain.hid>
	<17563.61309.258099.930934@domain.hid>
	<1151079971.4438.103.camel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
 > On Fri, 2006-06-23 at 15:41 +0200, Gilles Chanteperdrix wrote:
 > > Jan Kiszka wrote:
 > >  > Jan Kiszka wrote:
 > >  > > Hi,
 > >  > > 
 > >  > > wondering why suddenly things crash on invoking the latency test, I
 > >  > > realised that I turned the nucleus into a module which was not yet
 > >  > > loaded. Here is the oops in this case:
 > >  > 
 > >  > Correction: the nucleus was still compiled in, the native skin was missing.
 > > 
 > > After a few investigation, the problem appears to be that the nucleus
 > > assume that user-space skins will issue a bind syscall before using a
 > > skin, and that the user-space RTDM library does not exit if binding
 > > fails.
 > 
 > I don't get it: the muxid should be invalid then(?)

Yes the muxid is -1 and everything works fine, it was just a
misinterpretation. When issuing syscalls with a fixed muxid whereas
there is no interface corresponding to this muxid, the nucleus crashes,
but it is acceptable, user-space interfaces should issue an
__xn_sys_bind syscall first.

-- 


					    Gilles Chanteperdrix.

