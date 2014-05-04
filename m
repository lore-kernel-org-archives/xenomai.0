Message-ID: <536689FE.5060503@xenomai.org>
Date: Sun, 04 May 2014 20:42:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
In-Reply-To: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Content-Type: text/plain; charset=UTF-8
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
To: Matthias Schneider <ma30002000@yahoo.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/04/2014 06:59 PM, Matthias Schneider wrote:
> Hi all,
> 
> please find enclosed a patch with a FreeRTOS skin for xenomai-forge I have 
> been  working on for some time. I would like to get some feedback and advice
> what still needs to be done to get it accepted in Xenomai. There is a set of 
> unit tests included and the possibility to download the original FreeRTOS package 
> in order to run most of its (platform independent) test suite. Until now I have 
> been working under mercury only. Documentation is available in form of a README 
> file in lib/freertos/README, which should also be a good starting point. I have 
> not attached "configure" to the patch, so you will need to recreate the configure 
> script first before actually running it. You can apply the patch via

Hi,

I am not sure that checking whether a type is compatible with void * 
will not suddenly avoid the assert check for any pointer type in:

@@ -328,6 +328,7 @@ static inline int pshared_check(void *heap, void *addr)
        ({                                                              \
                type handle;                                            \
                assert(__builtin_types_compatible_p(typeof(type), unsigned long) || \
+               __builtin_types_compatible_p(typeof(type), void*) || \
                       __builtin_types_compatible_p(typeof(type), uintptr_t)); \
                assert(ptr == NULL || __memchk(__main_heap, ptr));      \
                handle = (type)ptr;                                     \
@@ -337,6 +338,7 @@ static inline int pshared_check(void *heap, void *addr)
        ({                                                              \
                type *ptr;                                              \
                assert(__builtin_types_compatible_p(typeof(handle), unsigned long) || \
+               __builtin_types_compatible_p(typeof(handle), void*) || \
                       __builtin_types_compatible_p(typeof(handle), uintptr_t)); \
                ptr = (type *)handle;                                   \
                ptr;                                                    \


That is a bit complicated:
+#if portBYTE_ALIGNMENT == 8
+       #define portBYTE_ALIGNMENT_MASK (0x0007)
+#endif
+
+#if portBYTE_ALIGNMENT == 4
+       #define portBYTE_ALIGNMENT_MASK (0x0003)
+#endif
+
+#if portBYTE_ALIGNMENT == 2
+       #define portBYTE_ALIGNMENT_MASK (0x0001)
+#endif
+
+#if portBYTE_ALIGNMENT == 1
+       #define portBYTE_ALIGNMENT_MASK (0x0000)
+#endif
+
+#ifndef portBYTE_ALIGNMENT_MASK
+       #error "Invalid portBYTE_ALIGNMENT definition"
+#endif

It seems simpler to me to define portBYTE_ALIGNNMENT_MASK to 
portByteALIGNMENT - 1 and trigger an error if portBYTE_ALIGNMENT 
is more than 8 or not a power of 2.

On 64 bits machines, long and int are different, so, you probably want 
#define portLONG long
To avoid unpleasant surprises in:

+#define portCHAR               char
+#define portFLOAT              float
+#define portDOUBLE             double
+#define portLONG               int

I am not sure what is portBYTE_ALIGNEMENT, but I guess sizeof(long) would 
make more sense.
+#define portBYTE_ALIGNMENT     8 //FIXME: double check...

I believe there is an error in these macros definition:
This one looks strange:
+#define portNOP() __asm__ __volatile__ ("nop");

If you do not care whether portNOP is a barrier you can drop the "volatile"
otherwise you should add "memory" as clobber.


It may not be a good idea to define errors to overlap with errno errors in:
+/* Error definitions. */
+#define errCOULD_NOT_ALLOCATE_REQUIRED_MEMORY  (-1)
+#define errNO_TASK_TO_RUN                      (-2)
+#define errQUEUE_BLOCKED                       (-4)
+#define errQUEUE_YIELD                         (-5)

I would either define these errors as errno errors or give them values which
do not correspond to any errno constant.


+#define xSemaphoreAltGive(xSemaphore) xSemaphoreGive(xMutex)
+
+#define xSemaphoreGiveFromISR(xSemaphore, pxHigherPriorityTaskWoken) \
+       xSemaphoreGive(xMutex)
+

About the testsuite: does it really make sense to include both the unpatched 
testsuite and xenomai-specific patches? I mean if you want to include the 
tests in xenomai sources, then include them patched, or do not include them, 
and include the patch.

-- 
                                                                Gilles.

