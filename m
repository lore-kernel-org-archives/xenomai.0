Message-ID: <4CBDF92F.20403@domain.hid>
Date: Tue, 19 Oct 2010 22:01:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1281709057.650414331@domain.hid> <4C65583D.3030800@domain.hid>
	<1281960823.030215299@domain.hid> <4C692FC3.5040802@domain.hid>
	<1283531433.789315367@domain.hid>
	<1283590285.1709.2153.camel@domain.hid>
	<1287134519.029617765@domain.hid>
	<1287143691.028416668@domain.hid> <4CB85C64.9040307@domain.hid>
	<1287496324.10921156@domain.hid>
In-Reply-To: <1287496324.10921156@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Very high latencies under stress testing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: edward.robbins@domain.hid
Cc: xenomai@xenomai.org

edward.robbins@domain.hid wrote:
> Having disabled MTRR (and leaving in Phillipes patch) I am not
> getting unreasonable latencies unless I enable graphics acceleration.
> Can I be sure this has solved the issue?

Yes, run a long stress test while running latency. The stress test
should stress anything (drivers, kernel services) you plan to use in the
final system.

The way we do this when validating Xenomai is by running the "dohell"
scripts, which relies on LTP to stress many kernel services.
http://git.xenomai.org/?p=mkrootfs.git;a=blob;f=tests/dohell;h=327a9f20755e23547f960e4c316141652f839bbf;hb=master

-- 
                                                                Gilles.

