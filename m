From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18016.24172.608531.418407@domain.hid>
Date: Fri, 1 Jun 2007 19:59:08 +0200
Subject: [Xenomai-core] Problem with RTDM descriptors with only rt close
	handler.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


Hi,

I had a problem with an RTDM driver: /proc/xenomai/rtdm/open_fildes
could not close its descriptors. So, I tried with trunk which has
auto-cleanup of RTDM descriptors, to see if descriptors would be closed,
the descriptors were not auto-closed when killing my application
either. After a little investigation, it appears that the problem is
that my drivers had a real-time close handler but no non-realtime
handler, so when close was invoked from a non real-time context (either
/proc/xenomai/rtdm/open_fildes, or the auto-cleanup routine), the
default close handler installed by RTDM simply returned -38 and close
aborted.

The way to fix this issue was rather simple: implement a non real-time
close handler, but I find this behaviour a bit disturbing, maybe
implementing a non real-time close handler could be mandatory ?

-- 


					    Gilles Chanteperdrix.

