Message-ID: <485794CC.3030102@domain.hid>
Date: Tue, 17 Jun 2008 12:41:16 +0200
From: Pierangelo Masarati <masarati@domain.hid>
MIME-Version: 1.0
References: <48568E78.5000606@domain.hid> <485695AE.7030509@domain.hid>
In-Reply-To: <485695AE.7030509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] latency fix for 2.6.25?
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: rpm@xenomai.org
Cc: adeos-main@gna.org

Philippe Gerum wrote:
> Pierangelo Masarati wrote:
>> Dear ADEOS users,
>>
>> 2.6.25 seems to show abnormal latencies on hardware that showed good
>> performances up to 2.6.24.  We think we traced down the issue to x86's
>> process_xx.c, which disappeared after regressing default_idle() to
>> 2.6.24.  The related changes are described in the attached patch.
>>
> 
> This patch would badly break the runqueue statistics, and likely the Linux
> scheduler tick engine too.
> 
> Actually, the hunk in default_idle() seems useless, since co-kernel activity
> should be accounted as Linux idle time anyway. Does this patch also fixes
> the issue you tracked down?

Dear Philippe,

we'll try it.  It will require some time to empirically let it run for a 
while to be sure.  Usually, the weird latency effect occurs within half 
a hour, but we'd like to wait a little longer.

Apart from not disturbing Linux, your fix should work, since it doesn't 
touch the hw flag.  The problem with the patch is likely that: CPU i 
gets the seqlock after hlt, and can be preempted by the RTOS; CPU k 
tries to acquire the lock before hlt, i.e. with hw flags disabled, so it 
cannot be preempted by the RTOS.  If the RTOS after preempting CPU i 
does a bit of work, the RTOS on CPU k is stalled until the RTOS finishes 
working on CPU i.

In any case, it is now running on two machines: a 32 and a 64 bit.  I'll 
let you know.

Sincerely, p.

