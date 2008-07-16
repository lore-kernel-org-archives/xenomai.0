Message-ID: <487E6557.8060109@domain.hid>
Date: Wed, 16 Jul 2008 23:17:11 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <487B8B3E.8020805@domain.hid> <487B91F6.3070909@domain.hid>
	<487BA305.6040401@domain.hid> <487BB89B.6010604@domain.hid>
	<487BF171.2090902@domain.hid> <487C42CB.5080405@domain.hid>
	<487DCCA4.60509@domain.hid>
In-Reply-To: <487DCCA4.60509@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_bind() and timeout values
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
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Stefan Kisdaroczi wrote:
> Hi,
> 
> your patch didnt work. The bind_calls are now blocking infinite (at
> least much too long, still waiting...)
> To compile i had to change following line in your patch:
> -    if (timeout != TM_NONBLOCK && timeout != TM_INFINITE)
> +    if (timeout != XN_NONBLOCK && timeout != XN_INFINITE)
>

Ok, fair enough. This one has been tested. No kidding.

--- ksrc/nucleus/registry.c	(revision 4050)
+++ ksrc/nucleus/registry.c	(revision 4051)
@@ -711,7 +711,6 @@
 	xnobject_t *object;
 	xnthread_t *thread;
 	xntbase_t *tbase;
-	xnticks_t stime;
 	int err = 0;
 	spl_t s;

@@ -723,7 +722,8 @@

 	xnlock_get_irqsave(&nklock, s);

-	stime = xntbase_get_time(tbase);
+	if (timeout != XN_INFINITE && timeout != XN_NONBLOCK)
+		timeout += xntbase_get_time(tbase);

 	for (;;) {
 		object = registry_hash_find(key);
@@ -738,18 +738,8 @@
 			goto unlock_and_exit;
 		}

-		if (timeout != XN_INFINITE) {
-			xnticks_t now = xntbase_get_time(tbase);
-
-			if (stime + timeout >= now)
-				break;
-
-			timeout -= (now - stime);
-			stime = now;
-		}
-
 		thread->registry.waitkey = key;
-		xnsynch_sleep_on(&registry_hash_synch, timeout, XN_RELATIVE);
+		xnsynch_sleep_on(&registry_hash_synch, timeout, XN_REALTIME);

 		if (xnthread_test_info(thread, XNTIMEO)) {
 			err = -ETIMEDOUT;

> I will use following patch for the moment, this works.
> 
> --- xenomai/nucleus/registry.c.old    2008-07-15 00:36:10.000000000 +0200
> +++ xenomai/nucleus/registry.c    2008-07-15 15:28:23.000000000 +0200
> @@ -733,8 +733,10 @@ int xnregistry_bind(const char *key, xnt
>          if (timeout != XN_INFINITE) {
>              xnticks_t now = xntbase_get_time(tbase);
> 
> -            if (stime + timeout >= now)
> -                break;
> +            if (stime + timeout <= now) {
> +                err = -ETIMEDOUT;
> +                goto unlock_and_exit;
> +            }       
> 
>              timeout -= (now - stime);
>              stime = now;
> 
> 
> Philippe Gerum schrieb:
>> Stefan Kisdaroczi wrote:
>>> Hi Philippe,
>>>
>>> the attached patch fixed the problem for me.
>>
>> Good spot. Now it's official, since four years that feature exists or
>> so, nobody
>> actually used registry timeouts... Oh, well...
>>
>>> However, i think that in the "break case" still EACCES is returned.
>>> Can the break be replaced with a "return ETIMEDOUT" ?
>>>
>>
>> Yes, normally we should do that along with your patch. Actually, the most
>> appropriate fix would be to use an absolute timeout value internally,
>> since the
>> nucleus allows it.
>>
>> --- ksrc/nucleus/registry.c    (revision 4044)
>> +++ ksrc/nucleus/registry.c    (working copy)
>> @@ -711,7 +711,6 @@
>>      xnobject_t *object;
>>      xnthread_t *thread;
>>      xntbase_t *tbase;
>> -    xnticks_t stime;
>>      int err = 0;
>>      spl_t s;
>>
>> @@ -723,7 +722,8 @@
>>
>>      xnlock_get_irqsave(&nklock, s);
>>
>> -    stime = xntbase_get_time(tbase);
>> +    if (timeout != TM_NONBLOCK && timeout != TM_INFINITE)
>> +        timeout += xntbase_get_time(tbase);
>>
>>      for (;;) {
>>          object = registry_hash_find(key);
>> @@ -738,18 +738,8 @@
>>              goto unlock_and_exit;
>>          }
>>
>> -        if (timeout != XN_INFINITE) {
>> -            xnticks_t now = xntbase_get_time(tbase);
>> -
>> -            if (stime + timeout >= now)
>> -                break;
>> -
>> -            timeout -= (now - stime);
>> -            stime = now;
>> -        }
>> -
>>          thread->registry.waitkey = key;
>> -        xnsynch_sleep_on(&registry_hash_synch, timeout, XN_RELATIVE);
>> +        xnsynch_sleep_on(&registry_hash_synch, timeout, XN_ABSOLUTE);
>>
>>          if (xnthread_test_info(thread, XNTIMEO)) {
>>              err = -ETIMEDOUT;
>>  --
>> Philippe.
>>
>>
> 
> 


-- 
Philippe.

