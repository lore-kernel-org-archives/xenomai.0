From: Wayne Warren <wwarren@emacinc.com>
In-Reply-To: <50882DD0.3030902@xenomai.org>
References: <1349212116.21898.108.camel@ENG-09-LX.emacinc.com>
	<1349369822.3775.107.camel@ENG-09-LX.emacinc.com>
	<506DC2DA.5000105@xenomai.org> <506E9510.7090105@xenomai.org>
	<1349462858.26881.43.camel@ENG-09-LX.emacinc.com>
	<506F402A.9030102@xenomai.org>
	<1349473634.26881.221.camel@ENG-09-LX.emacinc.com>
	<506F6283.2040901@xenomai.org>
	<5afa3b9a7c7daf116f8284b4f255227e.squirrel@mail.emacinc.com>
	<506FFDDC.60104@xenomai.org>
	<1349816136.25350.426.camel@ENG-09-LX.emacinc.com>
	<50749349.5070900@xenomai.org>
	<1350681759.1282.88.camel@ENG-09-LX.emacinc.com>
	<5081FF74.4010109@xenomai.org>
	<1350933768.17153.16.camel@ENG-09-LX.emacinc.com>
	<50859D99.5040009@xenomai.org>
	<1350934476.17153.20.camel@ENG-09-LX.emacinc.com>
	<5085B6BC.8060906@xenomai.org>
	<1351006344.2975.60.camel@ENG-09-LX.emacinc.com>
	<5086FA29.6010008@xenomai.org>
	<1351099930.25888.286.camel@ENG-09-LX.emacinc.com>
	<50882782.50003@xenomai.org>
	<1351101328.25888.330.camel@ENG-09-LX.emacinc.com>
	<50882DD0.3030902@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Oct 2012 13:26:01 -0500
Message-ID: <1351103161.25888.344.camel@ENG-09-LX.emacinc.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Adeos I-Pipe patch problem on vendor-specific kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

  
> > 
> > So it looks like maybe __ipipe_tsc_get is working as expected? 
> 
> Yes, the debugger can not know what is at 0xffff0f40 because the code
> copied there is not known at compilation (though you can run disass
> *0xffff0f40, this should work). __ipipe_tsc_register does copy the
> actual code, but before __ipipe_tsc_register copies the code, the code
> there simply returns r0 and r1 set to 0.
> 
> You should try and put a breakpoint at 0xffff040 to see what address is
> invalid. Maybe the counter virtual address is invalid, or the access to
> the timer register because the timer is not enabled yet at hardware level.
> 

disass *0xffff0f40 did not work, "No function contains specified
address."

So in other words, you are saying that if __ipipe_tsc_register had not
registered the code, the exception would not occur because it would
simply set r0 and r1 to 0 then return to the calling function? Just want
to be certain I understand...

I did try to put a breakpoint at 0xffff040 (but I think you meant
0xfff0f040, i tried both) but then I get "Warning: Cannot insert
breakpoint 10. Error accessing memory address 0xffff040: Unknown error".

> >                       
> >>
> >> Or apply the following patch:
> >> http://git.xenomai.org/?p=ipipe-gch.git;a=commitdiff;h=42dd9056983cb6f65b6a336363f2f08f4426625a;hp=3b51cebda0b0d0123cb61b6ec07ecb62f293a528
> > 
> > I will try this out, thanks!
> 
> It will probably not fix this issue, but it is better to start from that
> code anyway.
> 

Okay, just to be clear are you suggesting that we start all over with
this patch, merge in the TI changes and our own code, and begin
debugging again from there?


