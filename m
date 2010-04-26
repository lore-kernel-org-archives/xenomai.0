Message-ID: <4BD5BA03.5000101@domain.hid>
Date: Mon, 26 Apr 2010 18:06:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BD5987A.2050804@domain.hid> <4BD59A48.5070002@domain.hid>
In-Reply-To: <4BD59A48.5070002@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] nucleus: Plug race between rpi_clear_remote
	and rpi_next
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> I'm meditating over an oops in rpi_clear_remote. NULL pointer deref, it
>> /seems/ like thread->rpi is invalid. Looking at the code, I wonder if
>> this could explain the bug:
>>
>>
>> static void rpi_clear_remote(struct xnthread *thread)
>> {
>> ...
>>         rpi = thread->rpi;
>>         if (unlikely(rpi == NULL))
>>                 return;
>>
>>         xnlock_get_irqsave(&rpi->rpilock, s);
>>
>>         /*
>>          * The RPI slot - if present - is always valid, and won't
>>          * change since the thread is resuming on this CPU and cannot
>>          * migrate under our feet. We may grab the remote slot lock
>>          * now.
>>          */
>>         xnsched_pop_rpi(thread);
>>         thread->rpi = NULL;
>>
>> ...
>>
>> So we deref (xnsched_pop_rpi) and clear thread->rpi under rpilock, but
>> we check for it without any protection? Sounds racy. I think 'thread' is
>> not only pointing to the current thread but could refer to a foreign one
>> as well, right? Don't we need this:
>>
>> diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
>> index 872c37f..1f995d6 100644
>> --- a/ksrc/nucleus/shadow.c
>> +++ b/ksrc/nucleus/shadow.c
>> @@ -331,6 +331,12 @@ static void rpi_clear_remote(struct xnthread *thread)
>>  
>>  	xnlock_get_irqsave(&rpi->rpilock, s);
>>  
>> +	/* Re-check under lock, someone may have cleared rpi by now. */
>> +	if (unlikely(thread->rpi == NULL)) {
>> +		xnlock_put_irqrestore(&rpi->rpilock, s);
>> +		return;
>> +	}
>> +
>>  	/*
>>  	 * The RPI slot - if present - is always valid, and won't
>>  	 * change since the thread is resuming on this CPU and cannot
> 
> Another worry: Can thread->rpi become != rpi without being NULL? Or can
> we really only race for clearance here?
> 

I think so now, therefore I'm proposing this:

----------->

Most RPI services work on the current task or the one to be scheduled in
next, thus are naturally serialized. But rpi_next is not as it can walk
the chain of RPI requests for a CPU independently. In that case,
clearing RPI via rpi_clear_remote can race with rpi_next, and if the
former loses after checking thread->rpi for NULL, we will dereference a
NULL pointer in xnsched_pop_rpi().

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 ksrc/nucleus/shadow.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/ksrc/nucleus/shadow.c b/ksrc/nucleus/shadow.c
index 872c37f..cf7c08f 100644
--- a/ksrc/nucleus/shadow.c
+++ b/ksrc/nucleus/shadow.c
@@ -332,6 +332,15 @@ static void rpi_clear_remote(struct xnthread *thread)
 	xnlock_get_irqsave(&rpi->rpilock, s);
 
 	/*
+	 * Re-check under lock. Someone may have invoked rpi_next and cleared
+	 * rpi by now.
+	 */
+	if (unlikely(!rpi_p(thread))) {
+		xnlock_put_irqrestore(&rpi->rpilock, s);
+		return;
+	}
+
+	/*
 	 * The RPI slot - if present - is always valid, and won't
 	 * change since the thread is resuming on this CPU and cannot
 	 * migrate under our feet. We may grab the remote slot lock


