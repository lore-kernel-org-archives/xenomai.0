From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17438.51347.702261.525919@domain.hid>
Date: Mon, 20 Mar 2006 16:21:55 +0100
Subject: Re: [Xenomai-core] yet another test tool
In-Reply-To: <441DD89A.4000501@domain.hid>
References: <441DD89A.4000501@domain.hid>
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
 > (...)As Xenomai does not support hard-RT signal delivery yet (...)

This is the next feature missing to the POSIX skin. I would like to
implement this, but I am not sure which way to go :
- either, if it is possible, getting Linux signals services to run in
  every domain at Adeos level, by replacing spinlocks with spinlocks_hw
  and such kind of tricks;
- or adding a generic service at the adeos layer (a hook called when
  returning to user-space), building a generic user-space signals
  service at the nucleus level, and finally building all posix signals
  services on top of this.

The first approach guarantees the best integration with Linux, but
potentially add sections in Linux that are not preemptible by any
Xenomai skin. With the second approach, all services related to signals
have to be reimplemented plus some shortcuts to have standard user-space
tools such as "kill" working.


 > 
 > What do you think, is it worth including as a POSIX counterpart for
 > testsuite/latency?

There are a few details that I do not like about this tool, but we may
take it, and fix the details later.


-- 


					    Gilles Chanteperdrix.

