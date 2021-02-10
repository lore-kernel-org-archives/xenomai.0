Subject: Re: [I-PIPE] ipipe-core-4.19.165-cip41-arm64-09 released
References: <E1l9itV-000402-99@xenomai.org>
 <7c43aa40-9754-2529-8bc7-7df8c7124a96@siemens.com>
 <126b2b25b43ff4acbc3e5ffb902239e69fc67bfe.camel@siemens.com>
 <bddc49db-2dbd-af33-1ebe-473bcf403e91@siemens.com>
 <CALLqZ8QAitq3mTQgT156BBEC5pHzQfM_v+CPZMmW4+EXpkmDDQ@mail.gmail.com>
 <CALLqZ8T3hkDEt2TKZUaF_t8tfVYbsKhwj69T=0d6eUpR=gT=sQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c7327c6a-4c7e-6158-d189-adc8e71fb5c9@siemens.com>
Date: Wed, 10 Feb 2021 16:00:23 +0100
MIME-Version: 1.0
In-Reply-To: <CALLqZ8T3hkDEt2TKZUaF_t8tfVYbsKhwj69T=0d6eUpR=gT=sQ@mail.gmail.com>
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
To: Greg Gallagher <greg@embeddedgreg.com>
Cc: "Bezdeka, Florian (T RDA IOT SES-DE)" <florian.bezdeka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 10.02.21 15:58, Greg Gallagher wrote:
> 
> 
> On Wed, Feb 10, 2021 at 7:41 AM Greg Gallagher <greg@embeddedgreg.com
> <mailto:greg@embeddedgreg.com>> wrote:
> 
> 
> 
>     On Wed, Feb 10, 2021 at 6:08 AM Jan Kiszka <jan.kiszka@siemens.com
>     <mailto:jan.kiszka@siemens.com>> wrote:
> 
>         On 10.02.21 11:07, Bezdeka, Florian (T RDA IOT SES-DE) wrote:
>         > On Wed, 2021-02-10 at 09:15 +0100, Jan Kiszka via Xenomai wrote:
>         >> On 10.02.21 07:22, xenomai--- via Xenomai wrote:
>         >>> Download URL:
>         https://xenomai.org/downloads/ipipe/v4.x/arm64/ipipe-core-4.19.165-cip41-arm64-09.patch
>         <https://xenomai.org/downloads/ipipe/v4.x/arm64/ipipe-core-4.19.165-cip41-arm64-09.patch>
>         >>>
>         >>> Repository: https://git.xenomai.org/ipipe-arm64
>         <https://git.xenomai.org/ipipe-arm64>
>         >>> Release tag: ipipe-core-4.19.165-cip41-arm64-09
>         >>>
>         >>
>         >> Hmm, now we have the 5.4-arm64 issue also on 4.19:
>         >> https://gitlab.denx.de/Xenomai/xenomai-images/-/jobs/219984
>         <https://gitlab.denx.de/Xenomai/xenomai-images/-/jobs/219984>
>         >>
>         >
>         > I don't know much about the things going on here, but found
>         this line
>         > in the log. Maybe a starting point...
>         >
>         > 2021-02-10T07:51:47 setsched.c:120, assertion failed:
>         stats.msw == msw
>         >
> 
>         Exactly, that is causing the overall failure. And it was first
>         seen with
>         the newly added 5.4 kernel.
> 
>         Jan
> 
>         >
>         >> Guess we need to understand this next now, specifically as it
>         "spreads".
>         >>
>         >> Jan
>         >>
>         >
> 
>         -- 
>         Siemens AG, T RDA IOT
>         Corporate Competence Center Embedded Linux
> 
> 
>     I’ll look into this today, seems to be the same issue I’m looking at
>     for 5.4
> 
>     Greg
> 
> 
> 
> Based on the log I assume this is coming from the setsched test.  This
> test passes on my ultra96 board and zynq 7000, I'll build beagleboard
> black and qemu to continue to investigate. 
> 

Please check if our kernel configs deviate in any suspicious way - or
try them instead [1].

Jan

[1]
https://gitlab.denx.de/Xenomai/xenomai-images/-/tree/master/recipes-kernel/linux/files

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

