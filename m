MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17569.5797.264730.964058@domain.hid>
Date: Tue, 27 Jun 2006 13:29:41 +0200
Subject: Re: [Xenomai-core] [BUG] oops on skincall without nucleus being loaded
In-Reply-To: <44A0E712.3020604@domain.hid>
References: <449A7261.7040503@domain.hid> <449A7602.1020004@domain.hid>
	<17563.61309.258099.930934@domain.hid>
	<1151079971.4438.103.camel@domain.hid>
	<17564.11393.93645.251930@domain.hid>
	<17564.12674.330717.263818@domain.hid>
	<44A0E712.3020604@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Gilles Chanteperdrix wrote:
 > >  > misinterpretation. When issuing syscalls with a fixed muxid whereas
 > >  > there is no interface corresponding to this muxid, the nucleus crashes,
 > >  > but it is acceptable, user-space interfaces should issue an
 > >  > __xn_sys_bind syscall first.
 > > 
 > > This is not even possible, since the invalid syscall go through
 > > do_hisyscall_event first and get handled there.
 > > 
 > 
 > Do I get this correctly now: problem fixed by commit #1264? Is there
 > still anything we should do about the RTDM lib?

Yes, it is fixed. There is nothing more to do about the RTDM lib.

-- 


					    Gilles Chanteperdrix.

