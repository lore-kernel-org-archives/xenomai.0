Message-ID: <533C100A.7050501@xenomai.org>
Date: Wed, 02 Apr 2014 15:26:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5339EBE1.3060907@xenomai.org>
 <20140401013227.GA17765@csclub.uwaterloo.ca> <533A9A7C.7020408@xenomai.org>
 <20140401131257.GB17765@csclub.uwaterloo.ca> <533B14FC.1000007@xenomai.org>
 <20140401194053.GC17765@csclub.uwaterloo.ca> <533B270F.4060702@xenomai.org>
 <20140401214539.GD17765@csclub.uwaterloo.ca>
 <20140402023531.GE17765@csclub.uwaterloo.ca> <533BB83F.5040301@xenomai.org>
 <20140402132401.GF17765@csclub.uwaterloo.ca>
In-Reply-To: <20140402132401.GF17765@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 04/02/2014 03:24 PM, Lennart Sorensen wrote:
> On Wed, Apr 02, 2014 at 09:11:59AM +0200, Gilles Chanteperdrix wrote:
>> On 04/02/2014 04:35 AM, Lennart Sorensen wrote:
>>> All I changed was the -l option, which I changed to the location I
>>> installed ltp to.
>>>
>>> Maybe xeno-regression-test is broken.  Maybe it assumes /bin/sh is bash
>>> or something.
>>>
>> I am using this command with ash (busybox shell) without any problem.
>> Parsing these quotes is done by the interactive shell you are running,
>> not xeno-regression-test itself.
>
> This is the line that is causing issues as far as I can tell.
>
> check_alive /usr/lib/xenomai/testsuite/latency ${1+"$@"}
>
> So it is passing all the original arguments to latency for some reason,
> and latency has no idea what -m is supposed to mean.
>
> On Debian /bin/sh is dash, which is a pure posix shell.  If it isn't
> posix, it isn't valid.  checkbashisms doesn't seem to think there is
> anything wrong with that line though.
>
> As far as this shows I think the quotes were right:

xeno-regression-test does not take into account your -l option, since it 
is using dohell 900 as load, instead of the line you specified. Are you 
sure you did not mix-up -1 and -l ?


-- 
					    Gilles.

