Message-ID: <55080A6B.6080103@xenomai.org>
Date: Tue, 17 Mar 2015 12:05:15 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAPRPZsAaZ1iCH8UDETf7T8OFJoeoUuNoy+qyMkqykNrQK3115w@mail.gmail.com>
In-Reply-To: <CAPRPZsAaZ1iCH8UDETf7T8OFJoeoUuNoy+qyMkqykNrQK3115w@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Odd latency test result
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/17/2015 11:56 AM, Jeroen Van den Keybus wrote:
> Hi,
> 
> 
> While trying to reproduce the lockup issue, I noticed one of the
> latency tests reports a min. latency of about -20 us (and a max. of 27
> us). /proc/xenomai/latency is set to 1036, so I would've expected that
> the min. latency could be as low as -1.03 us, but not lower.
> 
> There were 3 tests running concurrently for 2 days, each running at
> 20, 21 and 22 us, so it's possible that weirdness occurred with
> latencies about as large as the task period. No overruns though.
> 
> Currently not an issue for us, but just to let you know that it happened.
> 

Are you running with CONFIG_XENO_OPT_TIMER_HEAP or _LIST?

-- 
Philippe.

