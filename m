References: <1521024178.8992.7.camel@sprinte.eu>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6cb98615-fa18-9c11-affd-5bcda302ed44@xenomai.org>
Date: Wed, 14 Mar 2018 12:00:31 +0100
MIME-Version: 1.0
In-Reply-To: <1521024178.8992.7.camel@sprinte.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Strange behaviour after calling clock_settime
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Julien Blanc <julien.blanc@sprinte.eu>, xenomai@xenomai.org

On 03/14/2018 11:42 AM, Julien Blanc wrote:
> Hi,
> 
> The current xenomai documentation states that it is allowed to call
> clock_settime with CLOCK_REALTIME parameter to set the value of the
> xenomai realtime clock. On our board, the value at bootup is always 0

Assuming you run in dual kernel mode, i.e. using Cobalt?
Assuming you run Xenomai 3.whatever?

> (so, epoch), despite the hardware clock being correctly set.
> 
> However, we experience bad behaviour when doing so. Notably, alchemy
> condition variables seems to no longer work.

This is vague. What does "no longer work" mean, specifically? Soft hang,
kernel crash, does not unblock upon signal, timeout fails to trigger or
call always fails on timeout?

There are smoke tests in the standard installation for testing basic
POSIX mechanisms with Cobalt:

# smokey --run=posix*

Those tests may take up to ~25s or so to complete. Also, you will need a
properly calibrated timer to pass some of them, esp. those testing the
clocks. So you may want to run "autotune" to get the timer gravity
values right before running the smoke tests.

-- 
Philippe.

