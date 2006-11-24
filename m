Message-ID: <4566F43E.1070205@domain.hid>
Date: Fri, 24 Nov 2006 14:31:42 +0100
From: Anders Blomdell <anders.blomdell@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] What is permanent memory (rt_task_shadow)
References: <4566DB9B.5010702@domain.hid> <1164371134.4973.39.camel@domain.hid>
In-Reply-To: <1164371134.4973.39.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai@xenomai.org

Philippe Gerum wrote:
> On Fri, 2006-11-24 at 12:46 +0100, Anders Blomdell wrote:
>> The documentation for rt_task_shadow says:
>>
>>    task The address of a task descriptor Xenomai will use to store the
>>         task-related data. This descriptor must always be valid while
>>         the task is active therefore it must be allocated in permanent
>>         memory.
>>
>> Is it correct to assume that it is OK to the following:
>>
>>    void func() {
>>      RT_TASK task;
>>      int err;
>>
>>      err = rt_task_shadow(&task, ...);
>>      ...  Realtime activities ...
>>      if (err == 0) {
>>        rt_task_delete(&task);
>>      }
>>    }
> 
> Yes, even if it relies on the assumption that func() will never unwind
> its stack space before it self-destroys.
OK, good. Follow-up question:

   Is there any way to do the inverse of rt_task_shadow (since
   the answer above implies that rt_task_delete will destroy the
   linux task as well)?

Regards

Anders Blomdell

-- 
Anders Blomdell                  Email: anders.blomdell@domain.hid
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118                     Fax:      +46 46 138118
SE-221 00 Lund, Sweden

