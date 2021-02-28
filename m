References: <621240.1614155458@gemini.denx.de>
 <781641.1614525295@gemini.denx.de>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [IMPORTANT] gitlab relocation / rename
In-reply-to: <781641.1614525295@gemini.denx.de>
Date: Sun, 28 Feb 2021 17:28:33 +0100
Message-ID: <87h7lw6tse.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Denk <wd@denx.de>
Cc: xenomai@xenomai.org, Jan Kiszka <jan.kiszka@siemens.com>, Harald Seiler <hws@denx.de>


Hi Wolfgang,

Wolfgang Denk <wd@denx.de> writes:

> Hi all,
>
> In message <621240.1614155458@gemini.denx.de> I wrote:
>>
>> We have to move all public projects off  gitlab.denx.de  to a new
>> gitlab instance; the new host name is then  source.denx.de .
>> We are fully aware that this will cause inconveniences, and I can
>> only assure you that we try hard to keep these as limited as
>> possible.
>>
>> # Details
>>
>> Around noon on Saturday, 2021-02-27, we will freeze all public
>> repositories on gitlab.denx.de.  They will still be readable/
>> cloneable but any attempt to push new commits after this point will
>> fail.
>>
>> We will then copy them over to the now host, source.denx.de .
>> All custodian accounts will also be transferred, the same login
>> credentials from gitlab.denx.de will work on source.denx.de .
>>
>> The URLs for the repositories will stay the same, except of course
>> for the host name.  So, for example, the U-Boot mainline repository
>> will then be hosted at
>>
>>     https://source.denx.de/u-boot/u-boot.git
>>
>> We will install redirects to forward HTTP accesses from the old
>> repository URLs to the new host.  This should make the transition
>> mostly transparent, but does not cover everything.  The following
>> needs to be taken care of manually:
>>
>> - Update the SSH URI for pushing to the repositories.  Just replace
>>   gitlab.denx.de  with  source.denx.de .  We will transfer all the
>>   SSH-keys to the new host so nothing else should be needed.
>>
>> - Make sure you're logging in on  source.denx.de .  Access to
>>   gitlab.denx.de  will no longer work!
>>
>> - CI runners connected to  gitlab.denx.de  need to be re-registered
>>   with  source.denx.de .
>>
>> The new host should hopefully be operational sometime on Sunday,
>> 2021-02-28.  We will send a further announcement once everything is
>> back up and running.
>
> As far as we were able to test it, the move has been completed and
> is fully functional again.  All public project are now on the new
> gitlab instance  source.denx.de
>
> If you should experience any problems, please do not hesitate to ask 
> Harald Seiler <hws@denx.de>, he will try to help you.
>
> Thanks for your patience!
>

Thanks to everyone involved in providing us with an even better
infrastructure. Greatly appreciated.

-- 
Philippe.

