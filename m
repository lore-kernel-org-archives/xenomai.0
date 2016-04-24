MIME-Version: 1.0
In-Reply-To: <20160418143032.GZ11630@csclub.uwaterloo.ca>
References: <CAJ2oMh+Bp4iFpVSN0M+SvyL9WerjxJOgMWq-JEc2_AZvbvGdPg@mail.gmail.com>
 <20160418134509.GW11630@csclub.uwaterloo.ca>
 <CAJ2oMhJEuYiJ40xw4+dL5WYS9oPVfF21eh=wcWSwQXLzn35pdQ@mail.gmail.com>
 <20160418135438.GX11630@csclub.uwaterloo.ca>
 <CAJ2oMh+edAyPTNzwq0HNFDO9Y-ZFn=_BZvJ0-zdB-8NQCBPHDg@mail.gmail.com>
 <CAJ2oMhLrcs104KGKAKx4Z1XWpwLKaVQBn6cZRP4EOLoVXtZJNw@mail.gmail.com>
 <20160418143032.GZ11630@csclub.uwaterloo.ca>
Date: Sun, 24 Apr 2016 10:21:50 +0300
Message-ID: <CAJ2oMh+vab29mm8xhMc=3KT=2mG2cO=opi5jtJtTkc_wFugU3A@mail.gmail.com>
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
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On Mon, Apr 18, 2016 at 5:30 PM, Lennart Sorensen
<lsorense@csclub.uwaterloo.ca> wrote:
> On Mon, Apr 18, 2016 at 05:28:26PM +0300, Ran Shalit wrote:
>> On Mon, Apr 18, 2016 at 4:56 PM, Ran Shalit <ranshalit@gmail.com> wrote:
>> > On Mon, Apr 18, 2016 at 4:54 PM, Lennart Sorensen
>> > <lsorense@csclub.uwaterloo.ca> wrote:
>> >> On Mon, Apr 18, 2016 at 04:47:46PM +0300, Ran Shalit wrote:
>> >>> Is there a link to that patch ? I would like to try it in my kernel.
>> >>> We can't upgrade the kernel at this point, so we must use (3.12).
>> >>
>> >> Well I put my patches on one of my web pages:
>> >>
>> >> http://csclub.uwaterloo.ca/~lsorense/xenomai-3.12/
>> >>
>> >> At least that might give you a starting point.
>> >>
>> >> That is that last version of the patch before we moved to 3.14.
>> >>
>> >> --
>> >> Len Sorensen
>> >
>>
>>
>> Hi Len,
>>
>> One more on this, if I may.
>> The kernel I am using is 3.12.0,
>> Does it mean that the patch (3.12.31) can be applied on 3.12.0 kernel
>> ( or can it only be applied on 3.12.31 kernel) ?
>
> I used 3.12.31, but it should be very minor tweaking to get it on 3.12.0.
>
> --
> Len Sorensen

Hi Lan,

We intend to use ipipe with zynq (we already have 3.12.0 kernel used with zynq).
Do you think the patch should be relevant for zynq ?
I see that xilinx have their own patch , but it is for older kernel 2.6.3
http://www.wiki.xilinx.com/Xenomai+for+Zynq#Xenomai for Zynq-7000 AP
SoC Linux--Patch

I also see that in git there is ipipe for 3.12.0
http://git.xenomai.org/ipipe-gch.git/log/?h=raw/for-ipipe-3.12.0
But again I am unsure if it is relevant for zynq too.

Thank you for the time,
Ran

