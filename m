Message-ID: <51B9493B.7070000@siemens.com>
Date: Thu, 13 Jun 2013 06:23:23 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <51B8120C.9080906@siemens.com> <51B8562E.6020800@xenomai.org>
	<51B948AE.6060708@siemens.com>
In-Reply-To: <51B948AE.6060708@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] posix: Skip auto-shadowing if current thread
 is already shadowed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-06-13 06:21, Jan Kiszka wrote:
> On 2013-06-12 13:06, Gilles Chanteperdrix wrote:
>> On 06/12/2013 08:15 AM, Jan Kiszka wrote:
>>
>>> While the user can also avoid double shadowing by providing the
>>> XENO_NOSHADOW environment variable, there is still no reason to attempt
>>> auto-shadowing in their absence if the current thread is already a
>>> Xenomai thread. This helps, e.g., in complex dlopen scenarios where
>>> the POSIX lib is pulled in belatedly, potentially after some other lib
>>> already shadowed the dlopen caller.
>>
>>
>> Well, last time I checked, calling __wrap_pthread_setschedparam for an
>> already shadowed threads was a nop.
> 
> I'm getting an EBUSY from xnshadow_map as called by __pthread_shadow.
> And that, of course, lets the lib init code bail out.

BTW, the test pattern is pretty simple:

main()
{
	...
	rt_task_shadow(&task, "test", 0, 0);
	handle = dlopen("libpthread_rt.so", RTLD_LAZY);
	...
}

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

