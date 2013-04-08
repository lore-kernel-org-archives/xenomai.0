Message-ID: <51633059.4070504@xenomai.org>
Date: Mon, 08 Apr 2013 23:02:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <515DE96F.7080508@xenomai.org>
	<515FEF85.5010801@web.de>	<5161A51C.8050606@xenomai.org>
	<5161BF47.9020007@xenomai.org>	<5161C292.3070703@web.de>
	<5161C61F.9000009@xenomai.org>
In-Reply-To: <5161C61F.9000009@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-pipe on ARM platform.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

On 04/07/2013 09:16 PM, Gilles Chanteperdrix wrote:

>>>> I also had tested a merge of the previous version with your next-x86
>>>> branch, and except a few merge conflicts and a build error without SMP,
>>>> adressed by this commit:
>>>> http://git.xenomai.org/ipipe-gch.git/?p=ipipe-gch.git;a=commitdiff;h=fae81444a0bfe12de514ac039f866c0f66abfb3c;hp=1198253580e0d5610ee886e1ff3771461a06f414
>>
>> Thanks for the fix, will pick it up as well.


I have also pushed a for-core-3.8.2-x86 branch in the ipipe-gch git,
with both the ARM and x86 changes.

> It seems registry_unexport_pnode reads an invalid object->vfilp and>
triggers registry_proc_apc whereas no vfile is currently reading the

> object, as if registry_export_pnode had not been called.
> 


Forget that, I do not really understand the vfile code, need to spend
more time on it.

-- 
                                                                Gilles.

