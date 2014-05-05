Message-ID: <53673CB3.8090106@xenomai.org>
Date: Mon, 05 May 2014 09:24:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <536689FE.5060503@xenomai.org>
 <1399238572.11209.YahooMailNeo@web171603.mail.ir2.yahoo.com>
In-Reply-To: <1399238572.11209.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FreeRTOS skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matthias Schneider <ma30002000@yahoo.de>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/04/2014 11:22 PM, Matthias Schneider wrote:
> ----- Original Message -----
> 
>> From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <xenomai@xenomai.org>
>> Cc:
>> Sent: Sunday, May 4, 2014 8:42 PM
>> Subject: Re: [Xenomai] FreeRTOS skin
>>   
>> On 05/04/2014 06:59 PM, Matthias Schneider wrote:
>>> Hi all,
>>>   
>>> please find enclosed a patch with a FreeRTOS skin for xenomai-forge I have
>>> been  working on for some time. I would like to get some feedback and advice
>>> what still needs to be done to get it accepted in Xenomai. There is a set of
>>> unit tests included and the possibility to download the original FreeRTOS package
>>> in order to run most of its (platform independent) test suite. Until now I have
>>> been working under mercury only. Documentation is available in form of a README
>>> file in lib/freertos/README, which should also be a good starting point. I have
>>> not attached "configure" to the patch, so you will need to recreate the configure
>>> script first before actually running it. You can apply the patch via
>>   
>>   
>> Hi,
>>   
>> I am not sure that checking whether a type is compatible with void *
>> will not suddenly avoid the assert check for any pointer type in:
>>   
>> @@ -328,6 +328,7 @@ static inline int pshared_check(void *heap, void *addr)
>>          ({
>> \
>>                  type handle;                                            \
>>                  assert(__builtin_types_compatible_p(typeof(type), unsigned long)  || \
>> +              __builtin_types_compatible_p(typeof(type), void*) || \
>>                        __builtin_types_compatible_p(typeof(type), uintptr_t));
>> \
>>                  assert(ptr == NULL || __memchk(__main_heap, ptr));      \
>>                  handle = (type)ptr;                                    \
>> @@ -337,6 +338,7 @@ static inline int pshared_check(void *heap, void *addr)
>>          ({
>> \
>>                  type *ptr;                                              \
>>                  assert(__builtin_types_compatible_p(typeof(handle), unsigned  long) || \
>> +              __builtin_types_compatible_p(typeof(handle), void*) || \
>>                        __builtin_types_compatible_p(typeof(handle), uintptr_t));
>> \
>>                  ptr = (type *)handle;                                  \
>>                  ptr;                                                    \
>>   
> I do agree with the argument; actually originally I had typedef'ed
> xQueueHandle, xTaskHandle and xSemaphorehandle as uintptr_t.
> However, when compiling original FreeRTOS applications like the
> "demo", I ran into many warnings (warning: comparison between
> pointer and integer) when comparing the handles to "NULL"
> like
> 
> if (queueHandle != NULL) {}
> 
> Now I see three possibilities:
> * stick with the void* and allow it in the check (admittedly
>    greatly reducing its use)
> * change the application code
> * suppress warnings when compiling application code (not really
>    my favorite)
> 
> Originally the handles are tyepdef'ed to void* as well.
> Any ideas?
> 

The point of this assertion is to make sure that your skin-defined object handle is wide enough to convey a native pointer directly, for the process-private configuration (with shared multi-processing enabled, this type would convey an offset instead).

There is no point in using a runtime assertion for C, we should be doing this instead:

diff --git a/include/copperplate/heapobj.h b/include/copperplate/heapobj.h
index 38deb89..6b5617c 100644
--- a/include/copperplate/heapobj.h
+++ b/include/copperplate/heapobj.h
@@ -324,21 +324,30 @@ static inline int pshared_check(void *heap, void *addr)
 	return 0;
 }
 
+#ifdef __cplusplus
+#define __check_ref_width(__dst, __src)			\
+	({						\
+		assert(sizeof(__dst) >= sizeof(__src));	\
+		(typeof(__dst))__src;			\
+	})
+#else
+#define __check_ref_width(__dst, __src)					\
+	__builtin_choose_expr(						\
+		sizeof(__dst) >= sizeof(__src), (typeof(__dst))__src,	\
+		((void)0))
+#endif
+
 #define mainheap_ref(ptr, type)						\
 	({								\
 		type handle;						\
-		assert(__builtin_types_compatible_p(typeof(type), unsigned long) || \
-		       __builtin_types_compatible_p(typeof(type), uintptr_t)); \
+		handle = __check_ref_width(handle, ptr);		\
 		assert(ptr == NULL || __memchk(__main_heap, ptr));	\
-		handle = (type)ptr;					\
 		handle;							\
 	})
 #define mainheap_deref(handle, type)					\
 	({								\
 		type *ptr;						\
-		assert(__builtin_types_compatible_p(typeof(handle), unsigned long) || \
-		       __builtin_types_compatible_p(typeof(handle), uintptr_t)); \
-		ptr = (type *)handle;					\
+		ptr = __check_ref_width(ptr, handle);			\
 		ptr;							\
 	})


-- 
Philippe.

