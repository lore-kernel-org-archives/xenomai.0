Subject: Re: [Dovetail] x86 test version available (kernel v5.10)
From: Jan Kiszka <jan.kiszka@siemens.com>
References: <874kixxf9e.fsf@xenomai.org>
 <f850676b-a67f-442e-4642-0b8791162236@siemens.com>
 <87k0rprr5a.fsf@xenomai.org>
 <46e13cc0-6f1c-65f3-34cc-4a6ea44d00d8@siemens.com>
 <aab28877-6309-edb3-45dc-b9d504451fc9@siemens.com>
Message-ID: <d3aadb22-6426-5326-31ed-fb44ee2a31aa@siemens.com>
Date: Mon, 15 Feb 2021 16:11:31 +0100
MIME-Version: 1.0
In-Reply-To: <aab28877-6309-edb3-45dc-b9d504451fc9@siemens.com>
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
Cc: xenomai@xenomai.org

On 15.02.21 14:28, Jan Kiszka wrote:
> Now the next issue is
> 
> /usr/lib/xenomai/testsuite/smokey: test sched_quota failed: Protocol error
> sched-quota.c:332, out of quota: 13.7%
> (on a real target, an Atom-class box).
> 

Testsuite issue, long pending:

https://gitlab.denx.de/Xenomai/xenomai/-/blob/master/testsuite/smokey/sched-quota/sched-quota.c#L204

Those pthread_kill() in the loop will kick the caller into non-rt, while
it is not yet done with collecting the loop counters from the other
workers. Result is pure random, sometimes still within the defined
limits, but sometimes reporting false overruns.

No idea what those signal submissions supposed to do - test runs and
terminates fine without them as well.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

