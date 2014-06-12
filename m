Message-ID: <539A12C7.3000709@xenomai.org>
Date: Thu, 12 Jun 2014 22:51:19 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5396CD6D.8060806@axelsw.it> <5397644B.9060806@xenomai.org>
 <5399AD6C.8070905@axelsw.it> <5399EA56.2050700@xenomai.org>
In-Reply-To: <5399EA56.2050700@xenomai.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Gdb freezes when stepping through rt_task_spawn.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Marco Tessore <marco.tessore@axelsw.it>, xenomai@xenomai.org

On 06/12/2014 07:58 PM, Gilles Chanteperdrix wrote:
> On 06/12/2014 03:38 PM, Marco Tessore wrote:
>> Thank you, I will try that commit.
>> But I have another question about it:
>> does the commit involve the patch to the kernel?
>> Since my kernel was patched using i-pipe git for the vanilla 3.10, but
>> applied to a customized version of 3.11,
>> if the commit involves the kernel patch, it can be difficult for me to
>> upgrade.
>
> If you kept the ipipe kernel separated from Xenomai kernel sources, the
> change is a change in xenomai sources, so the update should be painless.
> If you put the xenomai-patched kernel under source control, then it will
> be harder.
>

ENOSYS would rather be symptomatic of this bug which is ARM-specific:
http://git.xenomai.org/ipipe.git/commit/?h=ipipe-3.10&id=e410a5e77323d53277d625e5dafe166cdcd64afb

OTOH, the patch below fixes a spurious EINTR error within the task 
creation syscall, which may well end up in a lockup:
http://git.xenomai.org/xenomai-2.6.git/commit/?id=589882956280d5cb4fdc181a5fcd5ae1188ab6ed

This is one of the situations where knowing the CPU architecture 
involved would help a lot.

-- 
Philippe.

