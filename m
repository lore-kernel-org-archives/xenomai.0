Message-ID: <51980F22.4060103@xenomai.org>
Date: Sun, 19 May 2013 01:30:42 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <8D5AE3DA-87FF-4AC2-B888-4116ED22A9BF@mah.priv.at>
In-Reply-To: <8D5AE3DA-87FF-4AC2-B888-4116ED22A9BF@mah.priv.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Beagleboard 3.8 regression results
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/18/2013 11:39 PM, Michael Haberler wrote:

> using Stephan's 3.8 patch for the BeagleBoard and running
> 
> arm:/usr/xenomai/bin# ./xeno-regression-test -l "/usr/lib/xenomai/testsuite/dohell -m /tmp 100" -t 2
> 
> gives 
> 
> select service with posix message queues: success
> ++ start_load
> ++ echo start_load
> ++ check_alive /usr/xenomai/bin/switchtest
> ++ echo check_alive /usr/xenomai/bin/switchtest
> ++ check_alive /usr/xenomai/bin/switchtest -s 1000
> ++ echo check_alive /usr/xenomai/bin/switchtest -s 1000
> ++ check_alive /usr/xenomai/bin/latency -t 2
> ./xeno-regression-test failed: dead child 1988 not found!
> 
> not sure what to make of it - any recommendations how to proceed?


there are two ways to use dohell
either you pass -l to get it to launch ltp testsuite
or you pass a duration, in seconds.
Otherwise dohell exits prematurely with no things left to do.

-- 
                                                                Gilles.

