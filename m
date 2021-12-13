Subject: Re: [xenomai-images] [PATCH 1/1] Changes to support sbuild-based Isar
References: <20211209073619.17698-1-ubely@ilbers.de>
 <20211209073619.17698-2-ubely@ilbers.de>
 <094d5cdf-0528-009b-28ba-0241116f3d86@siemens.com> <5330380.rdbgypaU67@hp>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <be988d7f-a605-45e7-e0cc-af88c9d74dcc@siemens.com>
Date: Mon, 13 Dec 2021 08:44:59 +0100
MIME-Version: 1.0
In-Reply-To: <5330380.rdbgypaU67@hp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Uladzimir Bely <ubely@ilbers.de>, xenomai@xenomai.org, Baurzhan Ismagulov <ibr@ilbers.de>

On 13.12.21 06:41, Uladzimir Bely wrote:
> In mail from четверг, 9 декабря 2021 г. 12:35:16 +03 user Jan Kiszka wrote:
>> On 09.12.21 08:36, Uladzimir Bely via Xenomai wrote:
>>>
>>> diff --git a/recipes-xenomai/xenomai/xenomai.inc
>>> b/recipes-xenomai/xenomai/xenomai.inc index 8f13767..454dd7b 100644
>>> --- a/recipes-xenomai/xenomai/xenomai.inc
>>> +++ b/recipes-xenomai/xenomai/xenomai.inc
>>> @@ -41,7 +41,5 @@ do_prepare_build() {
>>>
>>>  dpkg_runbuild_prepend() {
>>>  
>>>      bbplain $(printf "xenomai-%s: Building revision %.20s\n" \
>>>      
>>>                       ${PV} ${COMMIT})
>>>
>>> -
>>> -    sudo chroot --userspec=$( id -u ):$( id -g ) ${BUILDCHROOT_DIR} \
>>> -        sh -c "cd ${PP}/${PPS}; scripts/bootstrap"
>>> +    SBUILD_PREBUILD="cd %p; scripts/bootstrap"
>>
>> Could we rather provide an abstract interface to users, not carrying
>> SBUILD in its name? I'm concerned that the current will make it hard to
>> switch builders in the future if we may have to.
>>
>> Jan
> 
> Hello.
> 
> With current approach it doesn't look easy enough. With buildchroot, it's 
> possible to do anything we want in 'dpkg_runbuild_prepend' or 'prepare_build' 
> task. When the actual build is started, all preparations are here and can be 
> used.
> 
> Sbuild is an isolated environment, so similar things can only be somehow 
> passed to the build environment. Here we use SBUILD_PREBUILD to do it, so all 
> preparations are 'postponed' until real build starts and all dependencies 
> installed.
> 
> If we want to unify the approach, we have 2 possible ways:
> 1) use something like SBUILD_PREBUILD (we can call it BUILD_PREBUILD) - so, 
> the preparations won't be done in some prebuild tasks, but they will be 
> postponed (with buildchroot, too) and executed during the actual build.
> 2) place the stuff into debian/rules, using patches or somehow else. So, the 
> preparations will be done in Debian style at the correct time.

The latter is likely better than adding an Isar-specific interface.
However, we may need to add hooks to complex Isar-provided rules like in
the kernel case. You don't want to fork them, just to add a statement.

> 
> Q:
> Also, there is a question regarding 'xenomai.inc' quoted above. Why 'scripts/
> bootstrap' is executed manually here, before the build? There is `bootstrap` 
> make target that does exactly the same, but at the build stage.
> I'm simply removing 'dpkg_runbuild_prepend()' from xenomai.inc and it is still 
> working for me.

Indeed, I probably missed that back then when adding the recipe - or
something broke things that was fixed meanwhile. Feel free to propose a
patch that removes the bootstrap call.

Thanks,
Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

