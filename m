MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18142.49532.752950.449999@domain.hid>
Date: Wed, 5 Sep 2007 16:47:24 +0200
In-Reply-To: <1188914054.28092.137.camel@domain.hid>
References: <46DD59D9.9010003@domain.hid>
	<1188914054.28092.137.camel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Make watchdog-timer configurable
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
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
 > On Tue, 2007-09-04 at 15:12 +0200, Johan Borkhuis wrote:
 > > I made the following change to Xenomai (version 2.3.2, but it could also 
 > > be applied to 2.4 as the watchdog code has not been changed).
 > > 
 > > The watchdog timeout is fixed at 4 seconds. For us this is a problem as 
 > > there are some processes that take more time than this.
 > > 
 > > I made the following change to allow this to be changed through the 
 > > Linux kernel configuration. The value is configurable between 1 and 60 
 > > seconds.
 > > 
 > > Below is a patchfile that implements this change. Please let me know if 
 > > you have comments on this, or if there are problems with this change.
 > > 
 > 
 > Looks good. Will merge, thanks.

I have nothing against the patch.

That said, if you have a real-time activity that does not let Linux run
for 4 seconds, you are risking some troubles when the real-time activity
gives back the control to Linux, such as random lockups for example.

-- 


					    Gilles Chanteperdrix.

