Message-ID: <51A138CA.5050902@zultron.com>
Date: Sat, 25 May 2013 17:18:50 -0500
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <8D5AE3DA-87FF-4AC2-B888-4116ED22A9BF@mah.priv.at>
	<51993D66.3070208@zultron.com> <519967A1.3030509@xenomai.org>
In-Reply-To: <519967A1.3030509@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1
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
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/19/2013 07:00 PM, Gilles Chanteperdrix wrote:
> On 05/19/2013 11:00 PM, John Morris wrote:
> 
>> On 05/18/2013 04:39 PM, Michael Haberler wrote:
>>> using Stephan's 3.8 patch for the BeagleBoard and running
>>>
>>> arm:/usr/xenomai/bin# ./xeno-regression-test -l "/usr/lib/xenomai/testsuite/dohell -m /tmp 100" -t 2
>>>
>>> gives 
>>>
>>> select service with posix message queues: success
>>> ++ start_load
>>> ++ echo start_load
>>> ++ check_alive /usr/xenomai/bin/switchtest
>>> ++ echo check_alive /usr/xenomai/bin/switchtest
>>> ++ check_alive /usr/xenomai/bin/switchtest -s 1000
>>> ++ echo check_alive /usr/xenomai/bin/switchtest -s 1000
>>> ++ check_alive /usr/xenomai/bin/latency -t 2
>>> ./xeno-regression-test failed: dead child 1988 not found!
>>
>> Be sure that the path to dohell is correct.  I think that's the correct
>> path for 2.6.0 and earlier, but in 2.6.2.1 it should be
>> /usr/lib/xenomai/dohell or similar.
> 
> 
> dohell is installed in the directory you pass to --with-testdir
> configure script option. If you do not pass this option, it gets
> installed in $bindir, that is $prefix/bin. I do not think this changed
> for 2.6.2.1.

Thank you.  The documentation at
http://wiki.linuxcnc.org/cgi-bin/wiki.pl?XenomaiKernel is updated.

Also, I was wrong about the location for the Debian package
configuration, which put dohell in /usr/lib/xenomai/testsuite/dohell.

	John

