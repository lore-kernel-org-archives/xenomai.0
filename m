Message-ID: <458925AA.6000404@domain.hid>
Date: Wed, 20 Dec 2006 12:59:38 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: [RFC] git workflow
References: <20061219213010.AF2A4352664@domain.hid>
	<45890361.7000709@domain.hid>
In-Reply-To: <45890361.7000709@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Wolfgang Denk <wd@domain.hid>, adeos-main <adeos-main@gna.org>

Jan Kiszka wrote:
> Wolfgang Denk wrote:
>> Dear Jan,
>>
>> in message <45881A69.1040704@domain.hid> you wrote:
>>> This is one of my motivations to push git forward. Having
>>> 2.6.20-rcX+ipipe already available for download and testing may help to
>>> follow the kernel development on the bleeding edge more closely.
>> Agreed.
>>
>>> The other aspect is that when you merge the kernel patches into a
>>> working ipipe tree and you get a conflict, you also directly obtain
>>> information about what change caused it and maybe what the background of
>>> that patch was. That's at least my theory which still needs to be proven
>>> in practice.
>> THis will work, but if you go this route you will sonn have the git
>> repo only, as it will become more and more difficult to extract the
>> ipipe patches which you need anyway.
>>
>> That's why I recommend to use stgit to maintain the ipipe patches. So
>> you have a clearly defined flow of information.
>>
>>> I heard about it before, but I still have to take a closer look. Does
>>> this generate also some kind of publishable git tree with history for
>>> the managed patches? ...
>> Yes, it does.
>>
>>>                  ... One problem with a stack might be that we loose
>>> information about ipipe changes themselves. ...
>> No, that's not true, as the patches itself are managed under git,  so
>> you have the full power of git for the patch history, too.
>>
>> This will be much more powerful than the  other  approach  -  if  you
>> maintain  a  patched  tree  under git, it will be pretty difficult to
>> find out which changes make up the ipipe patch, and which  are  other
>> stuff.
> 
> Might be true when you browse the log. But I guess some magic can be
> applied in that case as well, or we put a unique tag into the commit
> name ("[IPIPE] optimise IRQ fast-path").
> 
>>>                                         ... My idea is that some
>>> modification to the ipipe core stored as commit in the reference tree
>>> could directly be pulled by other arch maintainers.
>> That sounds as if you are planning  to  use  stgit  already,  without
>> knowing it yet :-)
> 
> Well, I may still oversee something, but after having a first look and
> also reading the tutorial it seems to me that there is actually no magic
> behind stgit. Means, it just works with the same mechanism plain git
> does. When you "stg pull", you remove your patches from the stack, apply
> the upstream changes, and then add your patches again - git rebase. So
> when you want to publish your stgit tree, you still need to merge your
> patches (stg commit). And at that moment you set the whole tree ordering
> in stone. Back to #1.
> 
> stgit is surely useful for managing private trees, but I don't see how
> it can help us when we want to publish our working trees.

A while ago I also played a bit with stgit and I was also not convinced, 
that it's the right tool for our purpose. Nevertheless, I could reduce 
the amount of git trees to manage (but I have to spend more time for a 
better judgment).

Currently I'm porting IPIPE v1.6 over arch/powerpc rising a few code 
management issues. I started porting with i386-1.6-01 extracting the 
common part from that patch and adapting the arch specify code for 
arch/powerpc. Now IPIPE is at v1.6-02 and I realized various 
modifications, also of the noarch part including some serious bug fixes 
(local_irq_disable_head in main.c did hang my system). But now, there is 
no easy way to update the noarch part as we deal with combined noarch + 
arch patches. From a new git based code management system, I would 
appreciate a separation of noarch and arch. This would make it easier to 
keep the archs in sync with Philippe's reference implementation (for 
x86). Any comments?

Wolfgang.


