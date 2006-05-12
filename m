MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17508.51754.556970.508385@domain.hid>
Date: Fri, 12 May 2006 19:47:22 +0200
Subject: Re: [Xenomai-help] starnge latencies with native
In-Reply-To: <20060512185206.3a6b2705@domain.hid>
References: <20060512172456.555caf51@domain.hid>
	<17508.46837.9322.301862@domain.hid>
	<20060512185206.3a6b2705@domain.hid>
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
To: xenomai@xenomai.org

Daniel Simon wrote:
 > On Fri, 12 May 2006 18:25:25 +0200
 > Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
 > 
 > > Are you still running a kernel with ACPI_PROCESSOR ?
 > 
 > yes, otherwise this laptop stops overheating in a few minutes, may
 > be its not a good platform for real-time ...
 > 
 > may be this behaviour was hidden in the testuite programs by the
 > "warming up" delay???

The warming up delay is only one second, whereas you experience high
latencies during several seconds. The latency test runs with a period of
100 us by default, this may make it less sensitive to the effect you
observe, did you try running the latency test with a period of 1s ?

-- 


					    Gilles Chanteperdrix.

