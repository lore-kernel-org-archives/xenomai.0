From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Sun, 11 Jun 2017 02:18:08 +0000
Message-ID: <DB6PR0701MB2456BC2070DB561D1D3EF577B5CC0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] What is the main() thread before you call
	rt_task_shadow()?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Giulio Moro wrote:
>> A side note: it seems that calling `rt_task_bind()` causes a switch to s=
econdary mode, as I see the MSW counter increasing for every call to it.
>>=20

Philippe Gerum wrote:
>This should not be the case in x3; you may want to run the app over gdb,
>enabling the T_WARNSW flag at task creation, so that a signal will be
>sent to the process when a mode switch happens. Inspecting the stack
>backtrace should give us a hint about the code causing such switch.

as it turns out, if I call rt_task_shadow() before the loop where I repeate=
dly call rt_task_bind(), then the mode switches go away.

The description of the --main-prio command line option (http://xenomai.org/=
2015/05/application-setup-and-init/#Standard_Xenomai_command_line_options) =
says
"When xenomai_init() is called for bootstrapping the real-time services for=
 the current process, the calling context is automatically turned into a Xe=
nomai thread, managed by the Cobalt kernel."
I assumed that this would be equivalent to a call to `rt_task_shadow()` and=
 that such an explicit call is not needed, given that the process already s=
hows up in /proc/xenomai/sched/stat.
Instead, as I found out above, this is not the case.

So my question is: what kind of task is the main thread after bootstrap (an=
d thus after the call to xenomai_init()), but before the call to rt_task_sh=
adow()?=

