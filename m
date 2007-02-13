MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17874.6444.25366.622467@domain.hid>
Date: Tue, 13 Feb 2007 21:01:48 +0100
Subject: Re: [Xenomai-help] pthread_make_periodic_np and clock_gettime
In-Reply-To: <45D20F8E.9040900@domain.hid>
References: <5D63919D95F87E4D9D34FF7748CE2C2A8018AD@ARVMAIL1.mra.roland-man.biz>
	<45D20F8E.9040900@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Roderik_Wildenburg@domain.hid, Xenomai-help@domain.hid

Jan Kiszka wrote:
 > Roderik_Wildenburg@domain.hid wrote:
 > > Can anybody tell me, how I have to set the 2. parameter (starttp) of
 > > pthread_make_periodic_np ?
 > > When I use clock_gettime to fill startp I get a giant timeout value in
 > > the /proc/xenomai/sched list and my task never gets periodic.
 > > 
 > > Is this just a problem of my hardware(PPC)/xenomai(2.3) combination or
 > > does anybody else have the same problem. 
 > > 
 > > See attached code example for easier testing.
 > > 
 > 
 > Confirmed over v2.3.x in periodic mode, aperiodic is fine. Gilles?

Ok. I will have a look at it.

-- 


					    Gilles Chanteperdrix.

