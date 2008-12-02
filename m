Message-ID: <49359483.4060201@domain.hid>
Date: Tue, 02 Dec 2008 21:03:15 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <493306F5.2080605@domain.hid>	<49330CD3.4090700@domain.hid>	<4933BAE2.3000502@domain.hid>	<4933F1A4.8060209@domain.hid>	<4933F18F.7080103@domain.hid>
	<4933FE5A.5060501@domain.hid>	<49355B5D.8070802@domain.hid>
	<49355A59.4050600@domain.hid>	<49357C02.1090001@domain.hid>
	<49358003.1080705@domain.hid> <4935919D.2080602@domain.hid>
In-Reply-To: <4935919D.2080602@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread cancelation and scheduling magics
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Wolfgang Grandegger wrote:
> -bash-3.2# cat stat sched
> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>   0  0      0          12563      0     00500080   99.9  ROOT
>   0  1407   1          1          0     00300380    0.0  cancel-test
>   0  1409   1          3          1     00300380    0.0  ctrl_func
>   0  1410   1          3          0     00300380    0.0  calc_func
>   0  0      0          4373414    0     00000000    0.1  IRQ512: [timer]
> CPU  PID    PRI      PERIOD     TIMEOUT    TIMEBASE  STAT       NAME
>   0  0       39      0          0          master    R          ROOT
>   0  1407     0      0          0          master    X          cancel-test
>   0  1409    39      0          0          master    X          ctrl_func
>   0  1410    38      0          0          master    X          calc_func
> 
> When does this priority coupling happen.

Each time a thread switches from primary to secondary mode, it is enqueued by
decreasing priority order into a list tracking relaxed threads for the given
CPU. The root thread for that CPU dynamically inherits the priority of the
topmost thread queued to the relax/RPI list. This list is updated as soon as:
- a primary mode thread is relaxed (enqueued)
- a relaxed thread goes back to primary mode (dequeued)
- a relaxed thread blocks on a linux service (dequeued)
- a relaxed thread resumes from a linux service (enqueued)
When no more threads are linked to the RPI list, the root thread priority is
downgraded to -1.

In effect, this couples the Xenomai priority scale to the linux one, so that
switching to secondary mode does not allow lower priority threads still in
primary mode to preempt.

CONFIG_XENO_OPT_PRIOCPL controls whether such coupling should happen at all.

-- 
Philippe.

