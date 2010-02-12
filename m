Message-ID: <4B7592D5.7050406@domain.hid>
Date: Fri, 12 Feb 2010 18:41:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1NfybE-0003dg-9e@domain.hid> <4B758E7A.5060408@domain.hid>
In-Reply-To: <4B758E7A.5060408@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : Fix remapping of
 global sem_heap on fork
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Gilles Chanteperdrix wrote:
> GIT version control wrote:
>> Module: xenomai-jki
>> Branch: for-upstream
>> Commit: 40e5b366397db3dde0ebde861a739dc2cd624b5a
>> URL:    http://git.xenomai.org/?p=xenomai-jki.git;a=commit;h=40e5b366397db3dde0ebde861a739dc2cd624b5a
>>
>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>> Date:   Fri Feb 12 17:40:09 2010 +0100
>>
>> Fix remapping of global sem_heap on fork
>>
>> As xeno_init_sem_heaps might be called multiple times even without fork,
>> we must not remap the global heap here. Register an atfork handler
>> instead that handles this case and simple reject multiple heap creation
>> requests for the same process.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>
>> ---
>>
>>  src/skins/common/sem_heap.c |   29 ++++++++++++++++++-----------
>>  1 files changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/src/skins/common/sem_heap.c b/src/skins/common/sem_heap.c
>> index 89f325a..12b256f 100644
>> --- a/src/skins/common/sem_heap.c
>> +++ b/src/skins/common/sem_heap.c
>> @@ -1,6 +1,6 @@
>>  #include <stdio.h>
>>  #include <stdlib.h>
>> -
>> +#include <pthread.h>
>>  #include <unistd.h>
>>  #include <sys/types.h>
>>  #include <sys/stat.h>
>> @@ -65,24 +65,31 @@ static void unmap_sem_heap(unsigned long heap_addr, unsigned shared)
>>  	munmap((void *) heap_addr, hinfo.size);
>>  }
>>  
>> +static void remap_on_fork(void)
>> +{
>> +	unmap_sem_heap(xeno_sem_heap[0], 0);
>> +
>> +	if (xeno_sem_heap[0] == (unsigned long) MAP_FAILED) {
>> +		perror("Xenomai: mmap(local sem heap)");
>> +		exit(EXIT_FAILURE);
>> +	}
> 
> Looks bogus to me. Where do the remap occur ?
> Looks like your test case does not try forking.
> 

Yep, copy&paste error. Fixed.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

