Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1283)
From: Michael Haberler <mail17@mah.priv.at>
In-Reply-To: <50FAAE9A.2060705@xenomai.org>
Date: Mon, 21 Jan 2013 12:43:59 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <1C475D27-61D9-41F9-98D8-476556B485C4@mah.priv.at>
References: <4D4F8D1B-022E-47F8-A579-EBF2A3427C5D@mah.priv.at>	<50F6D940.3040406@xs4all.nl>	<F1ACE4FC-3E71-4498-B683-81F5C40CB6E3@mah.priv.at>	<50F7AF53.2090800@xs4all.nl>
	<50F7BC13.50009@xenomai.org>	<50F7FCD8.7020105@xs4all.nl>
	<50FA9FA0.7020400@xenomai.org>
	<F995AEC4-6B7E-4DB9-9C64-A5ED3F01DCFA@mah.priv.at>
	<50FAAE9A.2060705@xenomai.org>
Subject: Re: [Xenomai] [Emc-developers] "new RTOS" status:
	Scheduler	(?)	lockup on ARM
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

the suspicion now turned to the DHCP lease setting and RTC time warp =
issues - the Beaglebone doesnt have an RTC so it starts up at 1-1-1970

the first DHCP lease still has 1970 timestamps, but eventually the RTC =
is set with ntpdate and it could be this causes confusion

the thing which is hard to believe for me: loss of IP connectivity - =
conceivable; kernel hang - why?

question: does a RTC time warp have any possible bearing on Xenomai =
operations?

- Michael=

