Message-ID: <20070913102242.npdjpbxjl04k48cs@domain.hid>
Date: Thu, 13 Sep 2007 10:22:42 +0200
From: Peter Soetens <peter.soetens@domain.hid>
References: <200709071127.17913.peter.soetens@domain.hid>
	<1189169200.26986.52.camel@domain.hid>
	<200709131006.52248.peter.soetens@domain.hid>
In-Reply-To: <200709131006.52248.peter.soetens@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Summary: Xenomai 2.3.2 and 2.4 lock-ups
	and	OOPSes
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

Quoting Peter Soetens <peter.soetens@domain.hid>:
> I stripped the OS layer of Orocos for xenomai and built a testcase, which
> causes a complete lockup with that. In order to avoid the lock-up, comment
> some thread/mutex/semaphore creations.

that's in trigger-bug.cpp, use 'make' to create the executable.

Peter

-- 
www.fmtc.be


