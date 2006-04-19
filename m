Message-ID: <4446063A.30609@domain.hid>
Date: Wed, 19 Apr 2006 11:43:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATH] fix pthread.h include
References: <44455949.4030403@domain.hid> <4445F98F.3070106@domain.hid>
In-Reply-To: <4445F98F.3070106@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> --- include/posix/pthread.h     (revision 946)
>> +++ include/posix/pthread.h     (working copy)
>> @@ -137,6 +137,7 @@ typedef struct
>>
>>  #include <sched.h>
>>  #include_next <pthread.h>
>> +#include <nucleus/thread.h>
>>
>>  struct timespec;
>>
>>
>> [In order to use PTHREAD_WARNSW in userspace.]
>>
> 
> Applied, thanks.
> 

I fixed your typo (#include_next -> #include).

Jan

