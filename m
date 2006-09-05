From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17661.36295.341485.45864@domain.hid>
Date: Tue, 5 Sep 2006 16:46:31 +0200
Subject: Re: [Xenomai-core] RTAI Vs Xenomai performance
In-Reply-To: <20060905143639.53778.qmail@domain.hid>
References: <44FD5D64.2080204@domain.hid>
	<20060905143639.53778.qmail@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: somshekar kadam <som_kadam@domain.hid>
Cc: xenomai@xenomai.org

somshekar kadam wrote:
 > HI Jan,
 > 
 > I am runnng the testsuite given by RTAI and Xenomai,
 > 
 > I need to this figures to compare on performance for
 > the doc to port XENOMAI on MIPS.
 > 
 > I see RTAI gives results in nanoseconds and XENOMAI in
 > microsecond, so i should say latency with Xenomai is
 > 3000 micrsecond where as RTAI its 3000 Nanosecond ,
 > correct me if I am wrong. 
 > I have attached both testsuite reults 

As indicated by the overruns count, you have a hardware problem, most
likely an issue with SMIs, or power management. Please
read the TROUBLESHOOTING file.

-- 


					    Gilles Chanteperdrix.

