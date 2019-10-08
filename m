Subject: Re: [PATCH 1/2] cobalt: Add _CC_COBALT_DEBUG_SYNC_BP feature
References: <8271e30f-9fcf-b366-8154-922f988bf366@siemens.com>
 <a2366c15-7f1d-3721-5586-fe44d5f86b81@xenomai.org>
 <8cdf2c49-89df-be48-de2e-14d685caad59@siemens.com>
 <12773854.dYiKgG3qDd@omoikane>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <18df8bb2-52ac-105b-81da-4238f8ab8284@siemens.com>
Date: Tue, 8 Oct 2019 16:33:13 +0200
MIME-Version: 1.0
In-Reply-To: <12773854.dYiKgG3qDd@omoikane>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "steven.seeger flightsystems.net" <steven.seeger@flightsystems.net>
Cc: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 08.10.19 16:17, steven.seeger flightsystems.net wrote:
> On Tuesday, October 8, 2019 9:53:34 AM EDT Jan Kiszka wrote:
>> It remains just a debug feature, an ARM64 patch is already under test,
>> PowerPC is not in regular testing (yet) - so let's just close the only
>> more annoying issue (ARM64) and be done (for now). Anything else would
>> mean rolling out tones for new releases for something that was already
>> solved (for those).
> 
> Does this feature make debugging xenomai userspace apps more reliable with 
> gdb? I thought we already had in place a system that suspended all threads in 
> the process when a breakpoint is hit, and with set scheduler-locking on you 
> coudl step through a particular thread without interruption. What does this 
> new feature add?

This is what we do now, not before. If one thread hit the BP, it got
migrated to non-RT first. Until there was finally the chance to issue
the stop to all other threads, the RT world could continue. And similar
things could happen reversely on resume. Look at the gdb test case for
what is now addressed.

Again, this is only visible to users behind a gdb session. The
application ABI will not change. And debugging RT application will
remain an invasive step, leaving plenty of chances to break
irreversibly what you've just stopped. I'm still hearing such
complaints, we will need to dig deeper to improve that as well.

> 
> If I wasn't super swamped I'd jump on this to try and make life easier for 
> everyone. It really doesn't seem like it would be that hard if it's just a 
> couple modifications to the return from interrupt path. On PPC there are 
> several of these paths.

We "just" need a hook on return to user space in non-RT. But I'm not
familiar with PPC to tell if that is already complex enough.

> 
> I've been thinking that it may make some sense to drop older powerpc support 
> since almost everything is e500 or later these days. (Though the project we 
> flew that's on the ISS right now was a 440.)

Can't help much with that decision. But it basically boils down to
announcing such considerations, asking for feedback and then decide and
communicate. But as some parts of our community are even then silent,
you might need telepathy. ;)

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

