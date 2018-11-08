Subject: Re: Segmentation error 6 in rt_heap_create() without --enable-pshared
References: <20181107140007.2730e228@md1za8fc.ad001.siemens.net>
 <d9daa769-4782-8d60-8150-81dfb601ca43@xenomai.org>
 <20181107160958.020f4bc0@md1za8fc.ad001.siemens.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <ae00964e-6ba4-5c56-b5e4-e107b2c2ae36@xenomai.org>
Date: Thu, 8 Nov 2018 10:17:44 +0100
MIME-Version: 1.0
In-Reply-To: <20181107160958.020f4bc0@md1za8fc.ad001.siemens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 11/7/18 4:09 PM, Henning Schild wrote:
> Am Wed, 7 Nov 2018 14:31:10 +0100
> schrieb Philippe Gerum <rpm@xenomai.org>:
> 
>> On 11/7/18 2:00 PM, Henning Schild via Xenomai wrote:
>>> Readding list ...
>>>   
>>
>> Does this help?
>>
>> diff --git a/lib/copperplate/heapobj-heapmem.c
>> b/lib/copperplate/heapobj-heapmem.c index 5c0ce9b2d..124fe564a 100644
>> --- a/lib/copperplate/heapobj-heapmem.c
>> +++ b/lib/copperplate/heapobj-heapmem.c
>> @@ -33,8 +33,8 @@ int __heapobj_init_private(struct heapobj *hobj,
>> const char *name, int ret;
>>  
>>  	if (mem == NULL) {
>> -		_mem = __STD(malloc(size));
>> -		if (_mem == NULL)
>> +		mem = __STD(malloc(size));
>> +		if (mem == NULL)
>>  			return -ENOMEM;
>>  	}
>>  	
>> @@ -43,16 +43,16 @@ int __heapobj_init_private(struct heapobj *hobj,
>> const char *name, else
>>  		snprintf(hobj->name, sizeof(hobj->name), "%p", hobj);
>>  
>> -	ret = heapmem_init(hobj->pool, _mem, size);
>> +	hobj->pool = mem;
>> +	hobj->size = size;
>> +
>> +	ret = heapmem_init(hobj->pool, mem, size);
> 
> ret = -EINVAL

Part of the solution in this patch (on top of the previous one), but more changes are needed for a complete fix:

diff --git a/lib/copperplate/heapobj-heapmem.c b/lib/copperplate/heapobj-heapmem.c
index 124fe564a..3961bd054 100644
--- a/lib/copperplate/heapobj-heapmem.c
+++ b/lib/copperplate/heapobj-heapmem.c
@@ -33,6 +33,7 @@ int __heapobj_init_private(struct heapobj *hobj, const char *name,
 	int ret;
 
 	if (mem == NULL) {
+		size = HEAPMEM_ARENA_SIZE(size); /* Count meta-data in. */
 		mem = __STD(malloc(size));
 		if (mem == NULL)
 			return -ENOMEM;
@@ -60,7 +61,7 @@ int heapobj_init_array_private(struct heapobj *hobj, const char *name,
 			       size_t size, int elems)
 {
 	return __bt(__heapobj_init_private(hobj, name,
-			   HEAPMEM_ARENA_SIZE(size * elems), NULL));
+					   size * elems, NULL));
 }
 
 int heapobj_pkg_init_private(void)

-- 
Philippe.

