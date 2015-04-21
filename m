Message-ID: <5536751A.6080609@siemens.com>
Date: Tue, 21 Apr 2015 18:04:42 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <E1Yka0Q-00008c-Jh@sd-51317.xenomai.org>
 <20150421152715.GV7109@hermes.click-hack.org>
In-Reply-To: <20150421152715.GV7109@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Xenomai-git] Jan Kiszka : lib/cobalt: Rework minimum
 stack size enforcement
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, xenomai@xenomai.org
Cc: xenomai-git@xenomai.org

On 2015-04-21 17:27, Gilles Chanteperdrix wrote:
> On Tue, Apr 21, 2015 at 05:22:34PM +0200, git repository hosting wrote:
>> +COBALT_IMPL(int, pthread_attr_setstack, (pthread_attr_t *attr, void *stackaddr,
>> +					 size_t stacksize))
>> +{
>> +	if (stacksize < COBALT_STACKSIZE_MIN)
>> +		return -EINVAL;
>> +	return __STD(pthread_attr_setstack)(attr, stackaddr, stacksize);
>> +}
> 
> As I said, there is no reason for Xenomai to enforce a task size
> larger than PTHREAD_STACK_MIN. This breaks POSIX compliance, and is
> useless.

Then we should not use printf & Co. from any trampoline function, e.g.
vxworks/taskLib.c:task_trampoline. I only tried with a local skin, but I
bet the issue is reproducible with that one.

For that reason, I went down the conservative path.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

