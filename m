From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200709131006.52248.peter.soetens@domain.hid>
References: <200709071127.17913.peter.soetens@domain.hid>
	<1189169200.26986.52.camel@domain.hid>
	<200709131006.52248.peter.soetens@domain.hid>
Content-Type: text/plain
Date: Thu, 13 Sep 2007 14:49:35 +0200
Message-Id: <1189687775.25006.63.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] Summary: Xenomai 2.3.2 and 2.4 lock-ups
	and	OOPSes
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Peter Soetens <peter.soetens@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Thu, 2007-09-13 at 10:06 +0200, Peter Soetens wrote:
> >
> > Please point me at the actual Orocos test code that breaks, with the
> > hope to get a fairly standalone test case from it; if you do have a
> > standalone test case already, this would be even better. I intend to
> > address this issue asap.
> 
> I stripped the OS layer of Orocos for xenomai and built a testcase, which 
> causes a complete lockup with that. In order to avoid the lock-up, comment 
> some thread/mutex/semaphore creations. All these classes call the functions 
> from fosi.c and fosi_internal_join.cpp. So the testcase could be reduced to 
> call only these functions...
> It seems you need to construct a number of threads and mutexes in the 
> same application before it happens. With only 'little' use of these 
> primitives, our applications run fine 1000's times in a row.

Ok. I can confirm that something tragically bugous is happening at
nucleus level when running this testcase. So far, I already triggered
the -ENOMEM issue, and a nifty crash during task creation. I'll dig
this, thanks.

-- 
Philippe.



