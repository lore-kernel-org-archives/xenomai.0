Message-ID: <4EF4F72D.5010007@domain.hid>
Date: Fri, 23 Dec 2011 22:48:29 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <20111223173309.GM27742@domain.hid>
	<4EF4C5A5.6000105@domain.hid>
	<20111223183246.GN27742@domain.hid>
	<4EF4DFAB.9040406@domain.hid>
	<20111223202530.GO27742@domain.hid>
In-Reply-To: <20111223202530.GO27742@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] CONFIG_XENO_HW_UNLOCKED_SWITCH=y causes random
 process corruption in xenomai 2.6.0 on powerpc.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Lennart Sorensen <lsorense@domain.hid>
Cc: xenomai@xenomai.org

On 12/23/2011 09:25 PM, Lennart Sorensen wrote:
> On Fri, Dec 23, 2011 at 09:08:11PM +0100, Philippe Gerum wrote:
>> Do you have a typical test scenario which triggers this bug?
>
> It can take a couple of hours under pretty heavy load to get one
> occourance.  But with preemptible context swiches off we haven't seen
> any in a week.
>
> For sure xenomai tasks are handling interrupts quite a lot at the time.
>
> I wish we had a simple test case to show it, but it seems to require
> triggering an interrupt in the middle of a context switch at exactly
> the wrong place.
>

Is it reproducible with the basic latency or cyclic tests if waiting for 
long enough? Running ltp in parallel would trigger a decent load, but 
sometimes two shell loops forking commands in the background are enough 
to trigger a variety of issues when something fragile exists in the mmu 
layer as modified by the I-Pipe.

-- 
Philippe.

