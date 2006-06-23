From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17563.61309.258099.930934@domain.hid>
Date: Fri, 23 Jun 2006 15:41:17 +0200
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

After a few investigation, the problem appears to be that the nucleus
assume that user-space skins will issue a bind syscall before using a
skin, and that the user-space RTDM library does not exit if binding
fails. So, there are two ways we can fix this problem:
- either we make the nucleus paranoid and have it handle gracefully
  syscalls to non loaded tables;
- or we make the user-space RTDM library behave like other skins and
  exit if the interface is not bound.

-- 


					    Gilles Chanteperdrix.

