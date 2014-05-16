Message-ID: <5376590C.3080803@ruggedcom.com>
Date: Fri, 16 May 2014 14:29:32 -0400
From: Makarand Pradhan <makarandpradhan@ruggedcom.com>
MIME-Version: 1.0
References: <53765654.8010509@ruggedcom.com> <5376573F.7070800@xenomai.org>
In-Reply-To: <5376573F.7070800@xenomai.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RT_HEAP physical address
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Still null, after using %Lx

                 rt_printf("rc_xeno_heap_create: heap: %p, Lx: phy: 
%Lx\n", heap.mapbase, (unsigned long long)info.phys_addr);

root@ruggedcom:~# ./a.out
Running
Heap allocated: heap: 0x48073000, rc: 0
rc_xeno_heap_create: heap: 0x48073000, Lx: phy: 0





On 16/05/14 02:21 PM, Gilles Chanteperdrix wrote:
> On 05/16/2014 08:17 PM, Makarand Pradhan wrote:
>> Hi All,
>>
>> I am running on MPC8360(powerpc) linux 3.0, xenomai 2.6.3.
>>
>> I am trying to get the physical address of a heap using rt_heap_inquire.
>> All the same, I'm getting a null pointer. Can you pl point out if I'm
>> doing something wrong?
>>
>> Code:
>>
>> #include <rtdk.h>
>> #include <stdio.h>
>> #include <sys/mman.h>
>> #include <native/heap.h>
>> #include <native/task.h>
>>
>> void task1_func(void *arg)
>> {
>>            RT_HEAP heap;
>>            RT_HEAP_INFO info;
>>
>>            rt_printf("Running\n");
>>
>>            int rc = rt_heap_create(&heap, "TEST", 1024, H_DMA);
>>
>>            rt_printf("Heap allocated: heap: %p, rc: %i\n", heap.mapbase, rc);
>>
>>            if (rt_heap_inquire(&heap, &info) == 0)
>>            {
>>                    rt_printf("task1: heap: %p, phy: %x\n", heap.mapbase,
>> info.phys_addr);
> What happens if you try phy: %Lx with (unsigned long long)info.phys_addr ?
>
>


-- 
Makarand Pradhan
Software Engineer Ruggedcom
Siemens Canada Limited
Industry Sector
300 Applewood Crescent,
Vaughan, ON, L4K 5C7
Tel: 905 482 4572
e-mail:  makarand.pradhan@siemens.com
www.ruggedcom.com

This e-mail is intended only for the named recipient(s) and may contain information that is privileged, confidential and/or exempt from disclosure under applicable law. No waiver of privilege, confidence or otherwise is intended by virtue of communication via the internet. Any unauthorized use, dissemination or copying is strictly prohibited. If you have received this e-mail in error, or are not named as a recipient, please immediately notify the sender and destroy all copies of this e-mail. Please be aware that internet communications are subject to the risk of data corruption and other transmission errors. For information of extraordinary sensitivity, we do not recommend communication by e-mail with us.
By submitting personal information to Siemens Canada Limited or its affiliates, service providers and agents, you consent to our collection, use and disclosure of such information for the purposes described in our Privacy Code available at www.siemens.ca. To the extent you provided us with personal information of another individual, you represent that you have the authority and/or have obtained all necessary consents from such individual to enable us to collect, use and disclose such information for the purposes described in our Privacy Code. To obtain further information, please contact our Chief Privacy Officer at privacy.panel.ca@siemens.com.


