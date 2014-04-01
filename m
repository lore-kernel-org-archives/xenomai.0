From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Date: Tue, 1 Apr 2014 09:12:57 -0400
Message-ID: <20140401131257.GB17765@csclub.uwaterloo.ca>
References: <5339D8EB.3030702@xenomai.org>
 <20140331212534.GW17765@csclub.uwaterloo.ca>
 <5339E2CE.7060703@xenomai.org>
 <20140331215348.GX17765@csclub.uwaterloo.ca>
 <20140331215933.GY17765@csclub.uwaterloo.ca>
 <20140331220421.GZ17765@csclub.uwaterloo.ca>
 <5339E80C.9020604@xenomai.org> <5339EBE1.3060907@xenomai.org>
 <20140401013227.GA17765@csclub.uwaterloo.ca>
 <533A9A7C.7020408@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <533A9A7C.7020408@xenomai.org>
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Tue, Apr 01, 2014 at 12:52:44PM +0200, Gilles Chanteperdrix wrote:
> The way I test it is by running xeno-regression-test, using dohell with
> LTP to create a load. Note that the latency result given by
> xeno-regression-test should not be taken into account as switchtest is
> running concurrently and creates large non-preemptible sections,
> xeno-regression-test is more a stress test.

I will see if I can find the invocation to run that then.

I let cyclictest, switchtest and latency running the last 8 hours,
and latency test currently says:

RTD|     -0.814|      2.441|      7.486|       0|     0|     -2.116|     20.182

That seems decent at least.

-- 
Len Sorensen

