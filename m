Message-ID: <4C6D7CC1.3080104@domain.hid>
Date: Thu, 19 Aug 2010 20:49:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4C45539B.70204@domain.hid> <4C6AA99D.3010907@domain.hid>
	<4C6B870C.7090600@domain.hid>
	<201008181003.09206.paul_c@domain.hid>
	<4C6BA2A1.4030005@domain.hid> <4C6D4C01.2010402@domain.hid>
	<4C6D4D9F.2060200@domain.hid> <4C6D663C.9010709@domain.hid>
In-Reply-To: <4C6D663C.9010709@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] kernel 2.6.32.11 with xenomai 2.5.3 fails to
 boot on ubuntu lucid system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

Stefan Kisdaroczi wrote:
> On 19.08.2010 17:28, Gilles Chanteperdrix wrote:
>> Yes, I know that. And this makes me wonder how Roland generated the
>> patches for 2.5.4, since his script is identical to ours.
>>   
> 
> The patch generating worked without obvious problems and the patches
> apply cleanly. But the patched kernels are failing to build if
> CONFIG_XENOMAI is set on kernels 2.6.33+. As debian squeeze will ship
> with a 2.6.32 kernel he probably just tested 2.6.32 and this worked.
> 
> There is also a chance that he didn't test to build a xenomai patched
> kernel at all, as the important thing was to have 2.5.4 uploaded before
> the squeeze-freeze and that no release-critical bugs are filed until the
> package migration from unstable to testing. You released 2.5.4 the 2.8.,
> he uploaded 4.8., freeze was 6.8. and the package migrated to testing
> the 15.8. He already has a upload permission from the
> debian-release-team for a bugfix-upload of xenomai. He really is doing a
> very good job. Yes, I remember the discussion you had last winter about
> 2.4.x, but for debian the most important is to have the latest possible
> upstream version uploaded just before freeze, and he succeeded.

Oh boy, this was a genuine question, I was not attempting any critics of
any kind... I was impressed that 2.5.4 made it to squeeze.

> 
> For a bad maintaining example look at Ubuntu. I filed a bugreport the
> 22.3.2010:
> https://bugs.launchpad.net/ubuntu/+source/xenomai/+bug/544284
> No response, no upload, nothing, still xenomai 2.4.8... And Ubuntu is
> debian unstable based, so they only have to sync.
> This is probably the reason for all those 'building packages for Ubuntu
> 10.04'-questions on this list. If Ubuntu would ship a newer version the
> beginners could directly introduce themselves with the 'Why do i get
> negative latency values?'-question :-)

No comment. I had to use Ubuntu for some time, and did not like it.

> 
>>> If we move the prepare-patch.sh out of the debian/ dir (suggested by
>>> Roland), that would not be necessary.
>>>
>>> I suggest to move debian/prepare-patch.sh to
>>> scripts/prepare-debian-patch.sh.
>>> I'll create a patch if you agree.
>>>     
>> I do not understand how changing the script location or name remove the
>> duplication between this script and prepare-kernel.sh. We fixed the
>> issue with the location of ipipe.h in prepare-kernel.sh ages ago, so, as
>> far as I understand, the bug comes from this duplication.
>>
>> I really think the good idea is to implement the functionality of
>> prepare-patch.sh (i.e. being able to generate a patch without the kernel
>> sources) into prepare-kernel.sh --outpatch command, and simply make
>> prepare-patch.sh call prepare-kernel, this would end all the duplication
>> between the two scripts.
>>   
> 
> ok, as you said above it's 'non-trivial' but on the other side we are
> not in a hurry.

Ok. I will try and have a look at modifying prepare-kernel.sh, probably
this week-end. When done, I will let someone else (probably you ?)
modify prepare-patch.sh. In the meantime, I will merge the patch you
sent which fixes prepare-patch.sh, and the other one which moves
prepare-patch.sh.

-- 
					    Gilles.

