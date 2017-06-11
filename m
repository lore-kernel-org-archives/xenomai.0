References: <DB6PR0701MB2456BC2070DB561D1D3EF577B5CC0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <890b7c4a-9da6-877f-692b-26434ffc1665@xenomai.org>
Date: Sun, 11 Jun 2017 16:38:51 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB2456BC2070DB561D1D3EF577B5CC0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] What is the main() thread before you call
 rt_task_shadow()?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 06/11/2017 04:18 AM, Giulio Moro wrote:
> Giulio Moro wrote:
>>> A side note: it seems that calling `rt_task_bind()` causes a switch to secondary mode, as I see the MSW counter increasing for every call to it.
>>>
> 
> Philippe Gerum wrote:
>> This should not be the case in x3; you may want to run the app over gdb,
>> enabling the T_WARNSW flag at task creation, so that a signal will be
>> sent to the process when a mode switch happens. Inspecting the stack
>> backtrace should give us a hint about the code causing such switch.
> 
> as it turns out, if I call rt_task_shadow() before the loop where I repeatedly call rt_task_bind(), then the mode switches go away.
> 
> The description of the --main-prio command line option (http://xenomai.org/2015/05/application-setup-and-init/#Standard_Xenomai_command_line_options) says
> "When xenomai_init() is called for bootstrapping the real-time services for the current process, the calling context is automatically turned into a Xenomai thread, managed by the Cobalt kernel."
> I assumed that this would be equivalent to a call to `rt_task_shadow()` and that such an explicit call is not needed, given that the process already shows up in /proc/xenomai/sched/stat.
> Instead, as I found out above, this is not the case.
> 
> So my question is: what kind of task is the main thread after bootstrap (and thus after the call to xenomai_init()), but before the call to rt_task_shadow()?

By default, this is a task bound to the Cobalt core with a zero priority
(SCHED_OTHER,0), which means that it can request services to Cobalt, but
does not compete with actual real-time threads. As a consequence, such
thread will switch to primary mode when issuing a Cobalt service which
requires it (such as one called by rt_task_bind()), then switch back to
secondary mode automatically when leaving the Cobalt syscall.

This explains the MSW increase when calling rt_task_bind() over the
default main() thread, which stops when making it a real-time thread via
rt_task_shadow().

-- 
Philippe.

