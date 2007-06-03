MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18018.59607.152227.603371@domain.hid>
Date: Sun, 3 Jun 2007 18:14:15 +0200
In-Reply-To: <46607BF5.2@domain.hid>
References: <18016.24172.608531.418407@domain.hid> <46607BF5.2@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Problem with RTDM descriptors with only rt close
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Gilles Chanteperdrix wrote:
 > > Hi,
 > > 
 > > I had a problem with an RTDM driver: /proc/xenomai/rtdm/open_fildes
 > > could not close its descriptors. So, I tried with trunk which has
 > > auto-cleanup of RTDM descriptors, to see if descriptors would be closed,
 > > the descriptors were not auto-closed when killing my application
 > > either. After a little investigation, it appears that the problem is
 > > that my drivers had a real-time close handler but no non-realtime
 > > handler, so when close was invoked from a non real-time context (either
 > > /proc/xenomai/rtdm/open_fildes, or the auto-cleanup routine), the
 > > default close handler installed by RTDM simply returned -38 and close
 > > aborted.
 > > 
 > > The way to fix this issue was rather simple: implement a non real-time
 > > close handler, but I find this behaviour a bit disturbing, maybe
 > > implementing a non real-time close handler could be mandatory ?
 > > 
 > 
 > It is, read the fine manual :). Moreover, if you had validated your
 > driver via CONFIG_XENO_OPT_DEBUG_RTDM, you would have got an error on
 > registration. But given the now even more required close_nrt handler, I
 > think decoupling this particular check from the debug switch is
 > appropriate. Will fix.

I have to say that I did not really test trunk, I backported the
auto-cleanup stuff to the version of the v2.3.x branch that I am
using. So, if the debug check was added after this commit, I missed it
completely.

-- 


					    Gilles Chanteperdrix.

