Message-ID: <30755fe0479d5f098c0d48818075a12b.squirrel@127.0.0.1>
In-Reply-To: <524E7D5B.5080004@siemens.com>
References: <1380568915-32582-1-git-send-email-gilles.chanteperdrix@xenomai.org>
	<524E7D5B.5080004@siemens.com>
Date: Fri, 4 Oct 2013 10:50:07 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] [PATCH] x86/ipipe: get FPU backup area allocated for
 all threads
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org


Jan Kiszka wrote:
> On 2013-09-30 21:21, Gilles Chanteperdrix wrote:
>> In order to be able to handle FPU faults in the Xenomai domain without
>> switching to the root domain, the FPU backup area must be systematically
>> allocated for all Linux tasks. Currently, the backup area is
>> systematically
>> allocated in arch_dup_task_struct(), but gets freed upon exec by
>> flush_thread(). Stop freeing it in flush_thread(), there does not seem
>> to be any risk of leaking information, as the "used_math" flag is
>> cleared
>> by drop_init_fpui() so that upon next fault, the context is
>> reinitialized.
>
> How to reproduce the scenario? Would be good to document it in order to
> check for regressions in future kernels.

Simply shadow the main thread, and use FPU in primary mode, without having
first used it in secondary mode. You should get a kernel oops.

We can add a test to switchtest, the problem is that switchtest purposedly
avoided to use FPU in the main thread before creating the other threads
to test threads which are not created with the "used_math" flag. But we can
use FPU after the other threads creation, right before the call to sigwait.

-- 
                                              Gilles


