Resent-Message-ID: <17230.51015.15044.257418@domain.hid>
Resent-To: xenomai@xenomai.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17230.50005.610300.142351@domain.hid>
In-Reply-To: <200510131146.04013.bdi-emc@domain.hid>
References: <000d01c5cfcb$8b5dfaf0$0600a8c0@domain.hid>
	<434E19AD.4030500@domain.hid>
	<200510131146.04013.bdi-emc@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-core] Future of fusion
Date: Thu, 13 Oct 2005 22:28:05 +0200
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Paul <bdi-emc@domain.hid>

Paul wrote:
 > 
 > Hi Philippe
 > 
 > On Thursday 13 October 2005 09:24, Philippe Gerum wrote:
 > > - Regular automated benchmarking: What is Xenomai currently capable of, how
 > > stable is it, do we progress or regress over time and releases, arch by
 > > arch?
 > 
 > Have a couple of x86 development boxes running 24/7 - Could set one up as a 
 > compile farm for running automated builds. Also have a PowerPC thin client 
 > that I would like to utilise, but could really do with some help in setting 
 > up the tools for cross-compiling the base system under Debian.

Actually, there are ready made debian cross toolchain packages at
debian.speedblue.org 

 > Gilles already has a tarball of the Debian rules I used for packaging fusion. 
 > With minor changes, these could be used for a Xenomai package. One 
 > possibility is to use the rules and the compile farm to produce "ready to 
 > run" kernel/Xenomai Debian packages.

Well, quite frankly, I do not know much about the debian packages
creation process, in any case not enough to do the work which remains
to be done. The best I can do is add the debian directory to the svn
repository, letting volunteers work on it and submit patches...

-- 


					    Gilles Chanteperdrix.

