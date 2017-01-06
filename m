References: <CAKwtv24db+w_EtqbQ1AN_SDfyqnEGBW_W2fNoSbLh5Fzg6qmzQ@mail.gmail.com>
 <CAKwtv26Fn0TsHwq0jgumCFrrpNkU_xAi7i+YAWVaHzep9tDmGw@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <77eae493-a610-11cd-90fc-924747c28e5f@xenomai.org>
Date: Fri, 6 Jan 2017 12:48:48 +0100
MIME-Version: 1.0
In-Reply-To: <CAKwtv26Fn0TsHwq0jgumCFrrpNkU_xAi7i+YAWVaHzep9tDmGw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Deadline Task Scheduling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mobin Motallebizadeh <mobin.motallebizadeh@gmail.com>, xenomai@xenomai.org

On 01/06/2017 12:37 PM, Mobin Motallebizadeh wrote:
> On Fri, Dec 30, 2016 at 12:26 PM, Mobin Motallebizadeh <
> mobin.motallebizadeh@gmail.com> wrote:
> 
>> Hi
>>
>> Is ‘Deadline Task Scheduling’ (explained here: https://www.kernel.org/doc/
>> Documentation/scheduler/sched-deadline.txt)
>>
>> supported in cobalt core?
>>
>> I want a simple procedure to manage periodic tasks with hard deadlines.
>>
>> Thanks in advance.
>>
> Hi and Happy New Year!
> wish you all a good year and hope you have enjoyed
>  holidays.

Thanks, best wishes too.

> I think according to this:
> (
> http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__api__sched.html#ga14f50e1f5d815c90f1f4225eca5d3a8c
> )
> "policy : scheduling policy, one of SCHED_FIFO, SCHED_RR, or SCHED_OTHER;"
> 
> the answer to my question was No.

The reference doc would rather be:
http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__api__sched.html#ga405020019f5df8c7e74d30fd457384ed

which states "SCHED_WEAK, SCHED_FIFO, SCHED_COBALT, SCHED_RR,
SCHED_SPORADIC, SCHED_TP, SCHED_QUOTA or SCHED_NORMAL". But the answer
is still no though.

-- 
Philippe.

