Message-ID: <558D6EBC.80300@siemens.com>
Date: Fri, 26 Jun 2015 17:24:44 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <558D5FAD.3060003@siemens.com>
 <20150626150751.GA6095@hermes.click-hack.org>
In-Reply-To: <20150626150751.GA6095@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Heads up: some race condition fixes for Xenomai 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-06-26 17:07, Gilles Chanteperdrix wrote:
> On Fri, Jun 26, 2015 at 04:20:29PM +0200, Jan Kiszka wrote:
>> Hi,
>>
>> just pushed 3 patches to git.xenomai.org/xenomai-jki.git for-forge that
>> are supposed to fix race conditions while manipulating xnthread::state
>> and info (both need to be nklock-protected). Please review if finding
>> and fixes make sense.
>>
>>       cobalt/kernel: Fix locking for xnthread info manipulations
>>       cobalt/kernel: Fix locking for setting XNFPU
>>       cobalt/kernel: Rework thread debugging helpers
>>
>> Maybe some of the issues also exist in Xenomai 2, didn't check yet.
> 
> At some point, one of info and state was supposed to be only
> modified by the current thread, but I am not sure this still holds.

I vaguely remember something like this as well. From my analysis of
today, this is no longer the case.

> 
> Anyway, instead of adding explicit nklock sections around
> xnthread_clear_info/xnthread_set_info, would not it be better to
> have xnthread_clear_info/xnthread_set_info implicitly take the lock,
> and add __xnthread_clear_info/__xnthread_set_info for the sections
> where the caller already holds the nklock?

That is an option, though we likely only have very few users of
self-locking variants.

Or we make those fields atomics, but that would affect all users.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

