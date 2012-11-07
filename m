Message-ID: <509AB38E.1060802@grandegger.com>
Date: Wed, 07 Nov 2012 20:16:30 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
References: <9A40FDD0-65C2-470A-ACB7-AB556CF62501@mah.priv.at>
In-Reply-To: <9A40FDD0-65C2-470A-ACB7-AB556CF62501@mah.priv.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM API: no CPU binding,
	FPU setting for tasks available?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Haberler <mail17@mah.priv.at>
Cc: xenomai@xenomai.org

On 11/07/2012 08:06 PM, Michael Haberler wrote:
> As suggested, I adapted the LinuxCNC kernel support from native to RTDM API; my remaining issues are:
> 
> - how do I achieve CPU binding which is available in rt_task_create() (T_CPU(cpuid))?
> - do I need to tell an RTDM task that the thread might use the FPU (T_FPU in rt_task_create()) ?

http://www.xenomai.org/documentation/trunk/html/api/group__task.html#ga03387550693c21d0223f739570ccd992
it pretty clear.
 
Wolfgang.


