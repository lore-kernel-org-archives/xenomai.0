Message-ID: <539AC282.7010907@xenomai.org>
Date: Fri, 13 Jun 2014 11:21:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5396CD6D.8060806@axelsw.it> <5397644B.9060806@xenomai.org>
 <5399AD6C.8070905@axelsw.it> <5399EA56.2050700@xenomai.org>
 <539A12C7.3000709@xenomai.org> <539A1F6C.8030905@xenomai.org>
 <539A8BE1.3030006@xenomai.org>
In-Reply-To: <539A8BE1.3030006@xenomai.org>
Content-Type: text/plain; charset=UTF-8
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
To: Philippe Gerum <rpm@xenomai.org>, Marco Tessore <marco.tessore@axelsw.it>, xenomai@xenomai.org

On 06/13/2014 07:28 AM, Philippe Gerum wrote:
> On 06/12/2014 11:45 PM, Gilles Chanteperdrix wrote:
>> On 06/12/2014 10:51 PM, Philippe Gerum wrote:
>>> On 06/12/2014 07:58 PM, Gilles Chanteperdrix wrote:
>>>> On 06/12/2014 03:38 PM, Marco Tessore wrote:
>>>>> Thank you, I will try that commit.
>>>>> But I have another question about it:
>>>>> does the commit involve the patch to the kernel?
>>>>> Since my kernel was patched using i-pipe git for the vanilla 3.10, but
>>>>> applied to a customized version of 3.11,
>>>>> if the commit involves the kernel patch, it can be difficult for me to
>>>>> upgrade.
>>>>
>>>> If you kept the ipipe kernel separated from Xenomai kernel sources, the
>>>> change is a change in xenomai sources, so the update should be painless.
>>>> If you put the xenomai-patched kernel under source control, then it will
>>>> be harder.
>>>>
>>>
>>> ENOSYS would rather be symptomatic of this bug which is ARM-specific:
>>> http://git.xenomai.org/ipipe.git/commit/?h=ipipe-3.10&id=e410a5e77323d53277d625e5dafe166cdcd64afb
>>
>> Indeed. This fix for 3.10 does not seem right though. The real fix is
>> to move the local_restart jump label, as in:
>>
>> http://git.xenomai.org/ipipe.git/commit/?h=ipipe-3.14&id=d7a5e4762535f55bfff8eafbf1c1dde214d09bd6
> 
> Will you issue a supplemental patch?
> 
Done, I have pushed my branch which has other changes, merged with the
current state of the ipipe-3.10 branch.

-- 
                                                                Gilles.

