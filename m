Subject: Re: [PATCH 1/2] cobalt/sched: guard against missed rescheduling upon
 CPU migration
References: <20191127181624.3043-1-rpm@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <88a366e4-7d0a-cea3-1b22-65103628fa78@xenomai.org>
Date: Wed, 27 Nov 2019 19:17:57 +0100
MIME-Version: 1.0
In-Reply-To: <20191127181624.3043-1-rpm@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 11/27/19 7:16 PM, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> In some cases, we may want to kick the rescheduling procedure
> (xnsched_run()) from call sites running over the root thread with hard
> irqs enabled, which could lead to a missed rescheduling opportunity,
> due to a CPU migration issue:
> 

To early to push, please do not consider this one.

-- 
Philippe.

