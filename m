Message-ID: <50FB02E8.1060605@zultron.com>
Date: Sat, 19 Jan 2013 14:32:40 -0600
From: John Morris <john@zultron.com>
MIME-Version: 1.0
References: <50FAFF77.8020803@zultron.com> <50FB0138.2090400@xenomai.org>
In-Reply-To: <50FB0138.2090400@xenomai.org>
Content-Type: text/plain; charset=UTF-8
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>



On 01/19/2013 02:25 PM, Gilles Chanteperdrix wrote:
> On 01/19/2013 09:17 PM, John Morris wrote:
> 
>> Hi list,
>>
>> These are the final tests on 32-bit before the initial RedHat packages
>> can be released for wider testing.
>>
>> On this host, a Dell Celeron with ICH5 chipset, the CLOCK_REALTIME
>> numbers look funny.  All other tests run correctly.

> Nothing really wrong here, the ToD offset is due to the fact that the
> realtime clock was changed between the time Xenomai read it to set its
> own realt-ime clock, and the time clocktest is run, and the drift is due
> to the tsc frequency adjustments made by Linux after Xenomai is started.
> 

Woo hoo!  That means it's time to start working on the package repos.
I'll report back soon.  Thanks for all the help.

	John

