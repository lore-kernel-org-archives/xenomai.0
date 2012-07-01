Message-ID: <4FF057F2.7040109@xenomai.org>
Date: Sun, 01 Jul 2012 16:00:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <009c01cd539e$e9f81420$bde83c60$@com>
In-Reply-To: <009c01cd539e$e9f81420$bde83c60$@com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ARM, exception #0 ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: George Pontis <GPontis@z9.com>
Cc: xenomai@xenomai.org

On 06/26/2012 03:23 PM, George Pontis wrote:
> Running Xenomai 2.6.0 on an ARM at91sam9g45. I recently updated from Adeos
> patch adeos-ipipe-3.0.13-arm-1.18-05 to adeos-ipipe-3.0.13-arm-1.18-09. Then
> built a new kernel and gave it to the application developers for a test.
> There were other changes in the root FS and a few tweaks in the kernel, but
> none that looked (to me) like they would affect Xenomai. They report this
> new error:
> 
>> Xenomai: Switching ADC Task to secondary mode after exception #0 from 
>> user-space at 0xffff0fbc (pid 723)
> 
> And then nothing about the app works any more. What does this mean ?

Ok. I was able to reproduce the same message with the following test
application:

#include <sys/mman.h>

#include <native/task.h>
#include <native/mutex.h>

RT_MUTEX mx;

int main(void)
{
	RT_TASK t;

	mlockall(MCL_CURRENT | MCL_FUTURE);

	rt_task_shadow(&t, "test_fault", 1, 0);

	rt_mutex_acquire(&mx, TM_INFINITE);
}

Namely: trying to acquire a mutex which is not initialized. The address
0xffff0fbc is off-by 4, the real fault address is 0xffff0fc0, the kernel
helper used by the mutex implementation for the
atomic-compare-and-exchange operation.

-- 
                                                                Gilles.

