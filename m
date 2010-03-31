Message-ID: <4BB34D0E.3010300@domain.hid>
Date: Wed, 31 Mar 2010 09:24:30 -0400
From: "Steven A. Falco" <sfalco@domain.hid>
MIME-Version: 1.0
References: <horvm4$cil$1@domain.hid>
	<20100330200529.BEBFEE73028@domain.hid>
In-Reply-To: <20100330200529.BEBFEE73028@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] find bits and pieces for Denx PPC/ipipe/xenomai?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Denk <wd@domain.hid>
Cc: Robert Berger <gmane@domain.hid>, xenomai@xenomai.org

Wolfgang Denk wrote:
> Dear Robert,
> 
> In message <horvm4$cil$1@domain.hid> you wrote:
>> Does this mean, that the patches are not anymore against the DENX git
>> repository, but against mainline?
> 
> This is not a contradiction - our linux-2.6-denx repository is based
> on the kernel.org tree and fully includes it.

Perhaps Robert's concern is whether the IPIPE patch will cleanly
apply to the DENX branch, since DENX has additional drivers,
changes, etc. relative to the mainline.  And I guess the answer
is "it depends".

	Steve

> 
> The "kernel.org" branch in our "linux-2.6-denx" repository is
> directly tracking the mainline kernel tree.
> 
>> What I would do up to now is to find in the denx git repository the
>> corresponding commit or similar;)
> 
> Just refer to the git commit ID, and you will find it happens to be
> there.
> 
>> There seems to be an 2.6.33 ipipe patch:
>>
>> http://git.xenomai.org/?p=xenomai-head.git;a=blob;f=ksrc/arch/powerpc/patches/adeos-ipipe-2.6.33-powerpc-2.9-00.patch;h=7b84ba91606e7873227ef70d99aa077362248f4a;hb=master
>>
>> So I would apply this on:
>> http://git.denx.de/?p=linux-2.6-denx.git;a=shortlog;h=refs/heads/DENX-v2.6.33-stable
> 
> Of course not. You do not use the web interface to actually work with
> git.  And "v2.6.33" in mainline is something different than our
> DENX-v2.6.33-stable branch (which BTW is a branch, i. e. not a
> specific commit).
> 
>> Or something completely different?
> 
> If you want to get "v2.6.33", you check out this version: You would
> initially run "git clone" to clone either the kernel.org mainline
> repository, or, if you like, our "linux-2.6-denx" repository. Then
> you would run the command
> 
> 	git checkout v2.6.33
> 
> to get the exact state of sources these patches were created against.
> 
>> I'm confused what's the recommended way to get the latest and greatest
>> ipipe/kernel/xenomai combination based on a DENX ppc kernel tree.
> 
> See above: "git clone" followed by "git checkout" - as usual.
> 
> Best regards,
> 
> Wolfgang Denk
> 


