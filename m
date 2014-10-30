Message-ID: <54523FFA.8020707@siemens.com>
Date: Thu, 30 Oct 2014 14:41:14 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <5451FFA4.5030805@ma-info.de>
 <20141030091631.GD11210@sisyphus.hd.free.fr>
In-Reply-To: <20141030091631.GD11210@sisyphus.hd.free.fr>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] i-Pipi patch 3.14
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Frede Florian <florian.frede@ma-info.de>
Cc: xenomai@xenomai.org

On 2014-10-30 10:16, Gilles Chanteperdrix wrote:
> On Thu, Oct 30, 2014 at 10:06:44AM +0100, Frede Florian wrote:
>> Hello,
>>
>> I tried to patch the Kernel 3.14.22 and there is two new lines in
>> the file fs/exec.c
>>
>> tsk->mm->vmacache_seqnum = 0;
>> vmacache_flush(tsk);
>>
>> I am not sure if the line from the iPipe patch should placed before
>> or after this lines...
>>
>> +    ipipe_mm_switch_unprotect(flags);
> 
> We do not have enough information to understand what you
> are talking about. Show us the conflict as obtained with git merge
> or with patch --merge to give us more information.

I've resolved the conflict with the vma caching that was back-ported to
3.14.x in ipipe-jki.git [1] (for-upstream/3.14 branch). Kernel works
fine so far, but I didn't look into the details, if that caching thing
affects us in the RT domain as well and requires more work.

Jan

[1] http://git.xenomai.org/ipipe-jki.git

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

