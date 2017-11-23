References: <d3f6995a-1d45-d262-21a0-97a51253da91@alaxarxa.net>
 <e665e5ab-796f-8aac-997c-33b88079d27c@xenomai.org>
 <a30fcf3f-ad18-0210-ad51-6a0ab0b73872@alaxarxa.net>
 <bd2c4a53-33cf-b4aa-79c5-243fe1d5b660@xenomai.org>
 <275c60a3-db60-fdb7-7ffc-96988ca50913@alaxarxa.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a58f4cc0-0e42-c1d6-71e6-c18b00d1076d@xenomai.org>
Date: Thu, 23 Nov 2017 16:12:04 +0100
MIME-Version: 1.0
In-Reply-To: <275c60a3-db60-fdb7-7ffc-96988ca50913@alaxarxa.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Cannot initialize TLSF memory manager
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/23/2017 04:08 PM, Leopold Palomo-Avellaneda wrote:
> On 23/11/17 16:04, Philippe Gerum wrote:
>> On 11/23/2017 03:58 PM, Leopold Palomo-Avellaneda wrote:
>>> On 23/11/17 13:22, Philippe Gerum wrote:
>>>> On 11/23/2017 01:10 PM, Leopold Palomo-Avellaneda wrote:
>>>>> Hi,
>>>>>
>>>>>
>>>>> I have seen this bug before, but it seems that it's again in 3.0.6. Running
>>>>> 3.0.6 with:
>>>>>
>>>>>  xeno-config --info
>>>>> Xenomai version: Xenomai/cobalt v3.0.6
>>>>> Linux bmm3 4.9.51-xenomai-3.0.6-ipipe #1 SMP Thu Nov 23 09:03:27 CET 2017 x86_64
>>>>> GNU/Linux
>>>>> Kernel parameters: BOOT_IMAGE=/boot/vmlinuz-4.9.51-xenomai-3.0.6-ipipe
>>>>> root=UUID=ab96eed9-cd79-4d30-9e93-e9f32a18cca6 ro quiet
>>>>> xenomai.allowed_group=113 nosmap
>>>>> I-pipe release #4 detected
>>>>> Cobalt core 3.0.6 detected
>>>>> Compiler: gcc version 6.3.0 20170516 (Debian 6.3.0-18)
>>>>> Build args: --build=x86_64-linux-gnu --includedir=/usr/include
>>>>> --mandir=/usr/share/man --infodir=/usr/share/info --sysconfdir=/etc
>>>>> --localstatedir=/var --disable-silent-rules --libdir=/usr/lib/x86_64-linux-gnu
>>>>> --libexecdir=/usr/lib/x86_64-linux-gnu --disable-maintainer-mode
>>>>> --disable-dependency-tracking --prefix=/usr --includedir=/usr/include/xenomai
>>>>> --mandir=/usr/share/man --with-testdir=/usr/lib/x86_64-linux-gnu/xenomai
>>>>> --enable-fortify --libdir=/usr/lib/x86_64-linux-gnu/ --enable-pshared
>>>>> --enable-registry --enable-doc-build --enable-dlopen-libs --enable-tls
>>>>> --enable-smp --with-core=cobalt --build x86_64-linux-gnu
>>>>> build_alias=x86_64-linux-gnu CFLAGS=-g -O2
>>>>> -fdebug-prefix-map=/build/xenomai-3.0.6+ds1=. -fstack-protector-strong -Wformat
>>>>> -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -fno-omit-frame-pointer
>>>>> LDFLAGS=-Wl,-z,relro -Wl,-z,now -Wl,--as-needed CPPFLAGS=-Wdate-time
>>>>> -D_FORTIFY_SOURCE=2
>>>>>
>>>>>
>>>>>
>>>>> when I try xeno-test, I got:
>>>>>
>>>>>  xeno-test
>>>>> Started child 2593: /bin/bash
>>>>> /usr/lib/x86_64-linux-gnu/xenomai/xeno-test-run-wrapper /usr/bin/xeno-test
>>>>> ++ echo 0
>>>>> ++ testdir=/usr/lib/x86_64-linux-gnu/xenomai
>>>>> ++ /usr/lib/x86_64-linux-gnu/xenomai/smokey --run
>>>>> init_memory_pool(): invalid pool
>>>>>    0"000.022| BUG in heapobj_pkg_init_private(): [main] cannot initialize TLSF
>>>>> memory manager
>>>>>
>>>>>
>>>>> Any idea?
>>>>>
>>>>
>>>> Can you check whether the call to tlsf_malloc() in
>>>> heapobj_pkg_init_private() returns non-NULL?
>>>> (lib/copperplate/heapobj-tlsf.c), and print out the value of alloc_size too?
>>>
>>> Checking the code, it fails before to return anything. Running crosss-link, that
>>> fails in the same function:
>>> ./cross-link
>>>
>>> init_memory_pool(): invalid pool
>>> Init memory pool returns -1 bytes
>>>    0"000.041| BUG in heapobj_pkg_init_private(): [main] cannot initialize TLSF
>>> memory manager
>>>
>>>
>>> I just added:
>>>
>>> +      printf("Init memory pool returns %zd bytes \n", available_size);
>>>
>>>         if (available_size == (size_t)-1)
>>>                 panic("cannot initialize TLSF memory manager");
>>>
>>> +     printf("Running after ...\n");
>>>
>>>
>>> in that function of the file you mentioned.
>>>
>>
>> Can you try this?
>>
>> diff --git a/lib/copperplate/heapobj-tlsf.c b/lib/copperplate/heapobj-tlsf.c
>> index 370985210..0186be423 100644
>> --- a/lib/copperplate/heapobj-tlsf.c
>> +++ b/lib/copperplate/heapobj-tlsf.c
>> @@ -103,6 +103,7 @@ int heapobj_pkg_init_private(void)
>>  	 * out the allocation overhead.
>>  	 */
>>  	mem = tlsf_malloc(alloc_size);
>> +	printf("mem=%p, alloc_size=%zu\n", mem, alloc_size);
>>  	available_size = init_memory_pool(alloc_size, mem);
>>  	if (available_size == (size_t)-1)
>>  		panic("cannot initialize TLSF memory manager");
>>
> ./cross-link
> mem=0x7f70b739a8e0, alloc_size=4096
> init_memory_pool(): invalid pool
> Init memory pool returns -1 bytes
>    0"000.029| BUG in heapobj_pkg_init_private(): [main] cannot initialize TLSF
> memory manager
> 

Ok, so please try this:

diff --git a/lib/copperplate/heapobj-tlsf.c b/lib/copperplate/heapobj-tlsf.c
index 370985210..948f7fc52 100644
--- a/lib/copperplate/heapobj-tlsf.c
+++ b/lib/copperplate/heapobj-tlsf.c
@@ -78,7 +78,7 @@ int heapobj_init_array_private(struct heapobj *hobj, const char *name,
 int heapobj_pkg_init_private(void)
 {
 	#ifdef CONFIG_XENO_PSHARED
-		size_t alloc_size = sysconf(_SC_PAGE_SIZE);
+		size_t alloc_size = sysconf(_SC_PAGE_SIZE) * 2;
 	#else
 		size_t alloc_size = __copperplate_setup_data.mem_pool;
 	#endif


-- 
Philippe.

