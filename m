MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17904.25471.871531.824810@domain.hid>
Date: Thu, 8 Mar 2007 20:26:55 +0100
Subject: Re: [Xenomai-help] task not being scheduled
In-Reply-To: <200702280931.46615.jweber@domain.hid>
References: <45E494AC.5050603@domain.hid> <45E58DA9.5030907@domain.hid>
	<45E58FA6.6000504@domain.hid>
	<200702280931.46615.jweber@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jweber@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

Jeff Weber wrote:
 > 
 > On Wednesday 28 February 2007 08:20, Gilles Chanteperdrix wrote:
 > > Jan Kiszka wrote:
 > >
 > > > Jeff, you have the ultimate test case now. Will you have some time to
 > > > run that test on your box so that we can quickly find and resolve the
 > > > bug?
 > 
 > Yes.  I've rebuilt my kernel with the linked list scheduler, but I've saved 
 > the previous heap scheduler config.  I will recreate the bug config, and 
 > await a patch or instrumentation.
 > >
 > > Is it possible to get a simplified version of the application you are
 > > running with only timer-related events ? Some kind of model that I could
 > > quietly run in the simulator ?
 > That will be more difficult.  The application requires a custom kernel module, 
 > and has many dependencies upon our hardware.  Further, the app is written in 
 > C++, which I understand is not compatible with the simulator.
 > 
 > Let me know if you would like to move this discussion off the xenomai-help 
 > list, to xenomai-core, or a private email discussion.
 > 
 > And again, thanks for taking the time to look at my trace, config and 
 > recommend a solution.  It was causing considerable frustration on this end.

Thank you Jeff for helping. The issue should now be resolved by commit
#2280 in trunk and #2281 in branch 2.3.

-- 


					    Gilles Chanteperdrix.

