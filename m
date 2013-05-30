Message-ID: <51A73A1A.8000404@xenomai.org>
Date: Thu, 30 May 2013 13:38:02 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51A6F9AD.3000207@free.fr>
In-Reply-To: <51A6F9AD.3000207@free.fr>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Context switching kernel tracing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?U3TDqXBoYW5lIEFOQ0VMT1Q=?= <sancelot@free.fr>
Cc: xenomai@xenomai.org

On 05/30/2013 09:03 AM, Stéphane ANCELOT wrote:

> Hi,
> 
> I have got some problems with an architecture, and 2 realtime tasks.
> 
> The realtime is not always respected.


Hi,

a few things to check:

Would there be any involuntary mode switches? See rt_task_set_mode or
pthread_set_mode_np documentation to enable debug.

Are you able to reproduce the problem with the latency test? You can
launch several instances in parallel, if you absolutely need several
task. If yes, then probably the easiest solution is to enable the I-pipe
tracer, then run the latency test with the -f argument.

> 
> This is a very strange problem in this architecture, since it happens 
> statically almost every three reboots...
> 
> It looks like there is something in the kernel / or setted up by bios  
> that is happening and locks the task switching context.


Ok, so if it has a bios, it is an x86. Which version of the I-pipe patch
and Xenomai are you using? Can not it be an SMI issue, have you tried
the SMI workaround?

http://www.xenomai.org/documentation/xenomai-2.6/html/TROUBLESHOOTING/#SMI

Regards.

-- 
                                                                Gilles.

