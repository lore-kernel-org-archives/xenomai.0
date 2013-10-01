Message-ID: <524A808E.8000405@xenomai.org>
Date: Tue, 01 Oct 2013 09:58:06 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <c0f20d88.0000172c.00000009@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
In-Reply-To: <c0f20d88.0000172c.00000009@dmerrill_win764.PERF.PERFORMANCESOFTWARE>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] psos+ tm_wkafter never resumes task when using gdb
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Daniel Merrill <daniel.merrill@psware.com>
Cc: xenomai@xenomai.org

On 09/26/2013 05:33 PM, Daniel Merrill wrote:
> We are attempting to port to xenomai some legacy code written for the
> pSOS+ operating system. Up to this point everything in the xenomai pSOS+
> skin has been working perfectly, but now we've uncovered a strange
> problem. The legacy code has around 50 tasks. A handful of them are only
> expected to run at slow periodic rates (one is run every 5 seconds,
> another every 60 seconds, etc.) To achieve this, the task sits in an
> infinite loop in which is performs the necessary work then puts itself to
> sleep for the wait time. The code for putting the task to sleep calls the
> pSOS+ API method tm_wkafter(), passing the appropriate number of ticks.
>

We'd need to know your current configuration to go further. Which kernel 
release, which I-pipe version, which Xenomai release, which machine 
architecture?

A simple test code stripped down to the bare minimum for reproducing the 
issue would likely speed up the resolution too.

-- 
Philippe.

