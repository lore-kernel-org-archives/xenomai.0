Message-ID: <50FB1A58.5040307@zultron.com>
Date: Sat, 19 Jan 2013 16:12:40 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <50FAFF77.8020803@zultron.com>
In-Reply-To: <50FAFF77.8020803@zultron.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 32-bit regression tests:  CLOCK_REALTIME wonkiness
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On 01/19/2013 02:17 PM, John Morris wrote:
> Hi list,
> 
> These are the final tests on 32-bit before the initial RedHat packages
> can be released for wider testing.
> 
> On this host, a Dell Celeron with ICH5 chipset, the CLOCK_REALTIME
> numbers look funny.  All other tests run correctly.

Whoops, how embarrassing, I reported the wrong thing:  it's the
native/tsc numbers that look funny.

++ /usr/lib/xenomai/regression/native/tsc
Checking tsc for 1 minute(s)
min: 4294967295, max: 0, avg: -nan
min: 4294967295, max: 0, avg: -nan
min: 4294967295, max: 0, avg: -nan
min: 4294967295, max: 0, avg: -nan
min: 4294967295, max: 0, avg: -nan
min: 4294967295, max: 0, avg: -nan
[...]
min: 4294967295, max: 0, avg: -nan -> -nan us

	John

> http://www.zultron.com/static/2013/01/xenomai/3.5.7-test-32-bit/config-3.5.7.txt
> 
> http://www.zultron.com/static/2013/01/xenomai/3.5.7-test-32-bit/dmesg.log
> 
> http://www.zultron.com/static/2013/01/xenomai/3.5.7-test-32-bit/xeno-regression-test.log

