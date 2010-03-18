Message-ID: <4BA253EC.8050601@domain.hid>
Date: Thu, 18 Mar 2010 17:25:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B97EB5C.2090600@domain.hid> <4BA24469.1040508@domain.hid>
In-Reply-To: <4BA24469.1040508@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] proc_file_read: Apparent buffer overflow
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Stefan Kisdaroczi wrote:
> Am 10.03.2010 19:56, schrieb Stefan Kisdaroczi:
>> Hi,
>>
>> cat /proc/xenomai/heap returns the first 4096 Bytes and fails then with "Bad address".
>> On the console I see: "proc_file_read: Apparent buffer overflow!"
>>
>> xeno 2.5.1, linux 2.6.32.8, x86 32bit UP, native skin, lot of rt_queues:
>> # ls -1 /proc/xenomai/registry/native/queues/ | wc -l
>> 233
>> # ls -1 /proc/xenomai/registry/native/heaps/ | wc -l
>> 26
> 
> With some luck i get a oops doing cat /proc/xenomai/heap.
> Looking at the while() loop in heap_read_proc() in ksrc/nucleus/heap.c
> its obvious.

You mean because "count" isn't checked while the output page is filled?
Well, looks like converting the heap proc interface to the seq API is a
good idea. References can be found in ksrc/nucleus/sched.c, patches are
welcome. :)

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

