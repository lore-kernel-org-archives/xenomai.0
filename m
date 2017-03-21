References: <1132124080.7126689.1490059327685.ref@mail.yahoo.com>
 <1132124080.7126689.1490059327685@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <83e18cba-a451-4d59-9306-6638f5f52e43@xenomai.org>
Date: Tue, 21 Mar 2017 09:50:04 +0100
MIME-Version: 1.0
In-Reply-To: <1132124080.7126689.1490059327685@mail.yahoo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Documentation for struct threadobj_stat on Alchemy
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <giuliomoro@yahoo.it>, Xenomai Mailing List <xenomai@xenomai.org>

On 03/21/2017 02:22 AM, Giulio Moro wrote:
> In Alchemy RT_TASK_INFO has a member struct threadobj_stat which is undocumented (https://xenomai.org//documentation/xenomai-3/html/xeno3prm/structRT__TASK__INFO.html).
> Looking at the source of copperplate/threadobj.h (https://xenomai.org//documentation/xenomai-3/html/xeno3prm/threadobj_8h_source.html) , it turns out it has these members:
> 
> struct threadobj_stat {
>  ticks_t xtime;

Total execution time in primary mode (ns)

>  ticks_t timeout;

Pending timeout (ns)

>  uint64_t msw;

Total count of mode switches (primary -> secondary)

>  uint64_t csw;

Total count of context switches

>  uint64_t xsc;

Total count of Cobalt system calls.

>  int cpu;

Current CPU.

>  int schedlock;

Scheduler lock depth count.

>  unsigned int status;

Internal status bits (from uapi/kernel/thread.h, state flags)

>  uint32_t pf;

Number of page faults in primary mode. Debug stuff, should be zero.

-- 
Philippe.

