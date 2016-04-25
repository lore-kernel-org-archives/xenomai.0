MIME-Version: 1.0
In-Reply-To: <20160425195054.GH1881@hermes.click-hack.org>
References: <CAJ2oMh+Bp4iFpVSN0M+SvyL9WerjxJOgMWq-JEc2_AZvbvGdPg@mail.gmail.com>
 <20160418134509.GW11630@csclub.uwaterloo.ca>
 <CAJ2oMhJEuYiJ40xw4+dL5WYS9oPVfF21eh=wcWSwQXLzn35pdQ@mail.gmail.com>
 <20160418135438.GX11630@csclub.uwaterloo.ca>
 <CAJ2oMh+edAyPTNzwq0HNFDO9Y-ZFn=_BZvJ0-zdB-8NQCBPHDg@mail.gmail.com>
 <CAJ2oMhLrcs104KGKAKx4Z1XWpwLKaVQBn6cZRP4EOLoVXtZJNw@mail.gmail.com>
 <20160418143032.GZ11630@csclub.uwaterloo.ca>
 <CAJ2oMh+vab29mm8xhMc=3KT=2mG2cO=opi5jtJtTkc_wFugU3A@mail.gmail.com>
 <20160425143644.GI11630@csclub.uwaterloo.ca>
 <CAJ2oMhK+xcdxtkXY+1koTvnmXVVHFDBFzPWO3xGXq9KBmsTdnA@mail.gmail.com>
 <20160425195054.GH1881@hermes.click-hack.org>
Date: Mon, 25 Apr 2016 23:01:40 +0300
Message-ID: <CAJ2oMhKccwbyCsOyi_JN-EybDmdttotajqKh6nK=zz=-Ay33gA@mail.gmail.com>
From: Ran Shalit <ranshalit@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] kernel 3.12
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Mon, Apr 25, 2016 at 10:50 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On Mon, Apr 25, 2016 at 07:38:45PM +0300, Ran Shalit wrote:
>> On Mon, Apr 25, 2016 at 5:36 PM, Lennart Sorensen
>> <lsorense@csclub.uwaterloo.ca> wrote:
>> > On Sun, Apr 24, 2016 at 10:21:50AM +0300, Ran Shalit wrote:
>> >> We intend to use ipipe with zynq (we already have 3.12.0 kernel used with zynq).
>> >> Do you think the patch should be relevant for zynq ?
>> >> I see that xilinx have their own patch , but it is for older kernel 2.6.3
>> >> http://www.wiki.xilinx.com/Xenomai+for+Zynq#Xenomai for Zynq-7000 AP
>> >> SoC Linux--Patch
>> >
>> > You can give it a try.  The zynq does have a Cortex-A9 as far as I recall,
>> > so it ought to work.  Doesn't mean there aren't other bits that need
>> > fixing in the zynq specific code.  But maybe there isn't.
>> >
>> > Just remember it was never an officially supported kernel version.
>> > It worked for us, it was given a once over by a proper xenomai developer
>> > who did not seem to think it was wrong, but if it doesn't work I wouldn't
>> > expect the xenomai developers to be excited to help fix it.
>> >
>> >> I also see that in git there is ipipe for 3.12.0
>> >> http://git.xenomai.org/ipipe-gch.git/log/?h=raw/for-ipipe-3.12.0
>> >> But again I am unsure if it is relevant for zynq too.
>> >
>> > Well that was a work in progress I believe and never officially released
>> > as far as I recall.  I started from that one, but the one I posted is
>> > actually based on the 3.14 patch and backported as far as I recall.
>> > It has been a while since we moved to 3.14.
>> >
>> > --
>> > Len Sorensen
>>
>> Hi Len,
>>
>> We've first tried to apply the patch for 3.12.0 but there were too many errors,
>> so we eventually used
>> http://git.xenomai.org/ipipe-gch.git/log/?h=raw/for-ipipe-3.12.0
>> latest commit.
>> I hope the ipipe should work without any issues wuth this tree.
>> Is there a way to check if ipipe is OK with our version based on this commit ?
>
> Bad idea, this branch corresponds to some intermediate state. I
> removed it.
>
> --
>                                             Gilles.

Hi Gilles,

Is there any better way to apply ipipe on 3.12.0 ?

Thanks,
Ran

