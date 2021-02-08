Subject: Re: [I-PIPE] ipipe-core-5.4.72-arm64-0 released
References: <E1l7tad-0004W6-Pl@xenomai.org>
 <CALLqZ8T_rQfwvDVdBGutFhvdc3OrJnPJtqLyjrkKp9vax0afbQ@mail.gmail.com>
 <868d4cd4-7990-68fa-902d-0d62ac676918@siemens.com>
 <CALLqZ8TJruq==-Lc60dBniDb6H5dyLT+MNP9rP85Bc9tufbH3w@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5d54c261-61b3-7981-8143-8adea4ad2765@siemens.com>
Date: Mon, 8 Feb 2021 09:24:05 +0100
MIME-Version: 1.0
In-Reply-To: <CALLqZ8TJruq==-Lc60dBniDb6H5dyLT+MNP9rP85Bc9tufbH3w@mail.gmail.com>
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
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 06.02.21 15:50, Greg Gallagher wrote:
> 
> 
> On Sat, Feb 6, 2021 at 7:23 AM Jan Kiszka <jan.kiszka@siemens.com
> <mailto:jan.kiszka@siemens.com>> wrote:
> 
>     On 05.02.21 06:24, Greg Gallagher via Xenomai wrote:
>     > On Fri, Feb 5, 2021 at 12:24 AM xenomai--- via Xenomai
>     <xenomai@xenomai.org <mailto:xenomai@xenomai.org>>
>     > wrote:
>     >
>     >> Download URL:
>     >>
>     https://xenomai.org/downloads/ipipe/v5.x/arm64/ipipe-core-5.4.72-arm64-0.patch
>     <https://xenomai.org/downloads/ipipe/v5.x/arm64/ipipe-core-5.4.72-arm64-0.patch>
>     >>
>     >> Repository: https://git.xenomai.org/ipipe-arm64
>     <https://git.xenomai.org/ipipe-arm64>
>     >> Release tag: ipipe-core-5.4.72-arm64-0
>     >>
>     >>
>     > This is a beta release, any testing is welcome
>     >
> 
>     You asked for it: ;)
> 
>     https://gitlab.denx.de/Xenomai/xenomai-images/-/jobs/218159#L638
>     <https://gitlab.denx.de/Xenomai/xenomai-images/-/jobs/218159#L638>
> 
>     Jan
> 
>     -- 
>     Siemens AG, T RDA IOT
>     Corporate Competence Center Embedded Linux
> 
> 
> Ack, I’ll look into this today. How hard is it to get a ci or something
> similar setup in a local machine? I think I may have asked this before
> but i can’t remember what we decided.
> 

The easiest option are the qemu targets, generated and run via
xenomai-images. Unfortunately, this issue does not seem to trigger in
qemu, only on the BeagleBone. But if you have that board, also that
target image can be reproduced, obviously. Follow the README in that case.

Or you just pick up the config from xenomai-images and do your own setup.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

