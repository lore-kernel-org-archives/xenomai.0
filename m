Message-ID: <534D44CA.3000105@xenomai.org>
Date: Tue, 15 Apr 2014 16:40:10 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAPRPZsAmXEyH4wcMeGcWPB3B-3=04DoS=K2k-QbQ+DidPcptAg@mail.gmail.com>	<534BD45B.8070402@xenomai.org>
 <CAPRPZsDSg6Yb3w+UEktb+7AmdZ-7JngVQH4tBbxnk5EV04y0AA@mail.gmail.com>
In-Reply-To: <CAPRPZsDSg6Yb3w+UEktb+7AmdZ-7JngVQH4tBbxnk5EV04y0AA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Slow execution of RT task
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeroen Van den Keybus <jeroen.vandenkeybus@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/14/2014 02:45 PM, Jeroen Van den Keybus wrote:
>> .config would help. TIA,
>
>
> I've attached both the one for the 3.10 and the 3.8 kernels. In the
> meantime I found out that the 3.8 kernel exhibits the same problem.
>
> Please let know if attachments don't work. I'll paste into e-mail
> immediately (but personally I don't like .configs in the archive...).
>
>

I can't reproduce this bug using your configuration, so we need a 
different approach.

Could you patch the code fragment in, enable CONFIG_IPIPE_TRACE, then 
get a dump from /proc/ipipe/trace/frozen once the warning has triggered?
Maybe getting a bit more context by setting 
/proc/ipipe/trace/backtrace_points to 2048 would help too. TIA,

diff --git a/kernel/rcutree.c b/kernel/rcutree.c
index 3538001..a1f09e3 100644
--- a/kernel/rcutree.c
+++ b/kernel/rcutree.c
@@ -477,6 +477,8 @@ void rcu_irq_exit(void)
  	rdtp = &__get_cpu_var(rcu_dynticks);
  	oldval = rdtp->dynticks_nesting;
  	rdtp->dynticks_nesting--;
+	if (rdtp->dynticks_nesting < 0)
+		ipipe_trace_freeze(0);
  	WARN_ON_ONCE(rdtp->dynticks_nesting < 0);
  	if (rdtp->dynticks_nesting)
  		trace_rcu_dyntick("--=", oldval, rdtp->dynticks_nesting);

-- 
Philippe.

