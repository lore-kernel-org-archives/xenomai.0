References: <44eflvcaft.fsf@lowell-desk.lan>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <31210f5e-1137-54e8-9e22-7562de250614@xenomai.org>
Date: Fri, 9 Feb 2018 11:02:50 +0100
MIME-Version: 1.0
In-Reply-To: <44eflvcaft.fsf@lowell-desk.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_timer_start latency?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>, xenomai@xenomai.org

On 02/09/2018 12:45 AM, Lowell Gilbert wrote:
> Am I correct in assuming that when calling rtdm_timer_start(), I should
> not be getting multi-second latencies before the first call to the timer
> routine? Just checking before I dig in too far.
> 

Of course not. I suspect an absolute expiry time is given with a
relative mode spec.

-- 
Philippe.

