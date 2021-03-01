Subject: Re: [I-PIPE] ipipe-core-5.4.72-arm64-0 released
References: <E1l7tad-0004W6-Pl@xenomai.org>
 <CALLqZ8T_rQfwvDVdBGutFhvdc3OrJnPJtqLyjrkKp9vax0afbQ@mail.gmail.com>
 <868d4cd4-7990-68fa-902d-0d62ac676918@siemens.com>
 <CALLqZ8TJruq==-Lc60dBniDb6H5dyLT+MNP9rP85Bc9tufbH3w@mail.gmail.com>
 <5d54c261-61b3-7981-8143-8adea4ad2765@siemens.com>
 <1b715c75-eef9-faa6-6c0d-1ba61400bdae@siemens.com>
 <f7cf94f6-e1f8-6867-2925-43c8b8094bbb@alstefgroup.com>
 <5444427a-dc9e-6026-7580-f5e563e11c73@siemens.com>
 <CALLqZ8TaZ1vH_wouT1Pus0k-cQt=5nVgzjbwRVjeuWL3JuHQWQ@mail.gmail.com>
 <cc550fca-3d2b-921f-53a4-476c91efb6a4@siemens.com>
From: Jean-Baptiste Tredez <jean-baptiste.tredez@alstefgroup.com>
Message-ID: <22d6f4f8-3802-1a1b-a862-b9a0c7945b9a@alstefgroup.com>
Date: Mon, 1 Mar 2021 19:03:25 +0100
In-Reply-To: <cc550fca-3d2b-921f-53a4-476c91efb6a4@siemens.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>


Le 01/03/2021 à 17:45, Jan Kiszka a écrit :
> On 01.03.21 17:28, Greg Gallagher wrote:
>>
>> On Mon, Mar 1, 2021 at 11:25 AM Jan Kiszka <jan.kiszka@siemens.com
>> <mailto:jan.kiszka@siemens.com>> wrote:
>>
>>      On 25.02.21 11:50, Jean-Baptiste Tredez via Xenomai wrote:
>>      > Hi all,
>>      >
>>      > I had some compilation issues with ipipe-core-5.4.72 and xenomai
>>      3.1 on
>>      > arm64 target.
>>      >
>>      > With some minor changes (see attached patch), the kernel boot on
>>      target.
>>      >
>>
>>      Thanks for the patches. Just note that those can easily get lost when
>>      not sent separately and inline (this list has some funny settings /wrt
>>      attachments, making them hard to read and impossible to comment on).
>>
>>      I think you patches should be related to
>>      https://source.denx.de/Xenomai/xenomai/-/commit/2cc905236c7208f37f128bb389214a39d777465a
>>      <https://source.denx.de/Xenomai/xenomai/-/commit/2cc905236c7208f37f128bb389214a39d777465a>
>>      which is not in stable yet. Greg, can you help sorting out what we need
>>      where?
>>
>>      Thanks,
>>      Jan
>>
>>      > Jean-Baptiste
>>      >
>>      >
>>      >
>>      > Le 08/02/2021 à 09:26, Jan Kiszka via Xenomai a écrit :
>>      >> On 08.02.21 09:24, Jan Kiszka via Xenomai wrote:
>>      >>> On 06.02.21 15:50, Greg Gallagher wrote:
>>      >>>> On Sat, Feb 6, 2021 at 7:23 AM Jan Kiszka
>>      <jan.kiszka@siemens.com <mailto:jan.kiszka@siemens.com>
>>      >>>> <mailto:jan.kiszka@siemens.com
>>      <mailto:jan.kiszka@siemens.com>>> wrote:
>>      >>>>
>>      >>>>      On 05.02.21 06:24, Greg Gallagher via Xenomai wrote:
>>      >>>>      > On Fri, Feb 5, 2021 at 12:24 AM xenomai--- via Xenomai
>>      >>>>      <xenomai@xenomai.org <mailto:xenomai@xenomai.org>
>>      <mailto:xenomai@xenomai.org <mailto:xenomai@xenomai.org>>>
>>      >>>>      > wrote:
>>      >>>>      >
>>      >>>>      >> Download URL:
>>      >>>>      >>
>>      >>>>
>>      >>>>
>>      https://xenomai.org/downloads/ipipe/v5.x/arm64/ipipe-core-5.4.72-arm64-0.patch
>>      <https://xenomai.org/downloads/ipipe/v5.x/arm64/ipipe-core-5.4.72-arm64-0.patch>
>>      >>>>
>>      >>>>
>>      >>>>
>>      <https://xenomai.org/downloads/ipipe/v5.x/arm64/ipipe-core-5.4.72-arm64-0.patch
>>      <https://xenomai.org/downloads/ipipe/v5.x/arm64/ipipe-core-5.4.72-arm64-0.patch>>
>>      >>>>
>>      >>>>      >>
>>      >>>>      >> Repository:https://git.xenomai.org/ipipe-arm64
>>      <https://git.xenomai.org/ipipe-arm64>
>>      >>>>      <https://git.xenomai.org/ipipe-arm64
>>      <https://git.xenomai.org/ipipe-arm64>>
>>      >>>>      >> Release tag: ipipe-core-5.4.72-arm64-0
>>      >>>>      >>
>>      >>>>      >>
>>      >>>>      > This is a beta release, any testing is welcome
>>      >>>>      >
>>      >>>>
>>      >>>>      You asked for it: ;)
>>      >>>>
>>      >>>>
>>      https://gitlab.denx.de/Xenomai/xenomai-images/-/jobs/218159#L638
>>      <https://gitlab.denx.de/Xenomai/xenomai-images/-/jobs/218159#L638>
>>      >>>>
>>      <https://gitlab.denx.de/Xenomai/xenomai-images/-/jobs/218159#L638
>>      <https://gitlab.denx.de/Xenomai/xenomai-images/-/jobs/218159#L638>>
>>      >>>>
>>      >>>>      Jan
>>      >>>>
>>      >>>>      --
>>      >>>>      Siemens AG, T RDA IOT
>>      >>>>      Corporate Competence Center Embedded Linux
>>      >>>>
>>      >>>>
>>      >>>> Ack, I’ll look into this today. How hard is it to get a ci or
>>      something
>>      >>>> similar setup in a local machine? I think I may have asked this
>>      before
>>      >>>> but i can’t remember what we decided.
>>      >>>>
>>      >>> The easiest option are the qemu targets, generated and run via
>>      >>> xenomai-images. Unfortunately, this issue does not seem to
>>      trigger in
>>      >>> qemu, only on the BeagleBone. But if you have that board, also that
>>      >>> target image can be reproduced, obviously. Follow the README in that
>>      >>> case.
>>      >>>
>>      >>> Or you just pick up the config from xenomai-images and do your own
>>      >>> setup.
>>      >>>
>>      >> Err, wrong context, this is arm64. Here it's the hikey, and only the
>>      >> hikey board. For the arm issue, both qemu and bbb expose the problem.
>>      >>
>>      >> Jan
>>      >>
>>      > -------------- next part --------------
>>      > A non-text attachment was scrubbed...
>>      > Name: 0001-cobalt-arm64-Remove-include-of-compiler.h.patch
>>      > Type: text/x-patch
>>      > Size: 1103 bytes
>>      > Desc: not available
>>      > URL:
>>      >
>>      <http://xenomai.org/pipermail/xenomai/attachments/20210225/2339e8e4/attachment.bin
>>      <http://xenomai.org/pipermail/xenomai/attachments/20210225/2339e8e4/attachment.bin>>
>>      >
>>      > -------------- next part --------------
>>      > A non-text attachment was scrubbed...
>>      > Name: 0002-cobalt-arm64-Fix-elf_hwcap-acces.patch
>>      > Type: text/x-patch
>>      > Size: 1124 bytes
>>      > Desc: not available
>>      > URL:
>>      >
>>      <http://xenomai.org/pipermail/xenomai/attachments/20210225/2339e8e4/attachment-0001.bin
>>      <http://xenomai.org/pipermail/xenomai/attachments/20210225/2339e8e4/attachment-0001.bin>>
>>      >
>>
>>      --
>>      Siemens AG, T RDA IOT
>>      Corporate Competence Center Embedded Linux
>>
>>
>> Yes, I believe all the needed patches are currently in next, but I will
>> confirm.
> I'm seeing cpu_get_elf_hwcap() in Jean-Baptiste's patch - is that a
> better way to access it?
>
> And, Jean-Baptiste, can you confirm that using Greg's patch from next in
> 3.1-stable also works for you? Then I would pull it over.
>
> Jan
>
It is working well with stable/v3.1.x and Greg's patch 
(2cc905236c7208f37f128bb389214a39d777465a and 
6faffb4fc7806f7442ec548a97157922523f5440 applied on previous location of 
files).

Jean-Baptiste



