MIME-Version: 1.0
References: <20210127054348.2128285-1-greg@embeddedgreg.com>
 <e577f54b-43c8-0291-ef3a-e48b77d2ebdf@siemens.com>
 <4a14a81e-207e-76a4-cfa4-c2b94b0fb3d1@siemens.com>
 <CALLqZ8SshX0=ZJgdUjj9a2XBVsFfz6C5MXz-ysig8Tah3AD0+Q@mail.gmail.com>
In-Reply-To: <CALLqZ8SshX0=ZJgdUjj9a2XBVsFfz6C5MXz-ysig8Tah3AD0+Q@mail.gmail.com>
From: Greg Gallagher <greg@embeddedgreg.com>
Date: Mon, 1 Feb 2021 14:15:55 -0500
Message-ID: <CALLqZ8RKgSWYmiAPcezb3m4KfKnJE2PFTruFz6nmn7f3ptxq6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] kernel: cobalt: Fix up elf_hwcap
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Jan 27, 2021 at 9:26 AM Greg Gallagher <greg@embeddedgreg.com>
wrote:

>
>
> On Wed, Jan 27, 2021 at 1:15 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
>> On 27.01.21 07:13, Jan Kiszka via Xenomai wrote:
>> > On 27.01.21 06:43, Greg Gallagher via Xenomai wrote:
>> >> Update elf_hwcap to ELF_HWCAP, this will work for newer 5.4 kernels
>> >>
>> >
>> > I assume you mean "also work" - or does it break on certain older
>> > kernels? Just asking before consulting our CI. ;)
>> >
>>
>> ...and the same pattern exists on ARM.
>>
>> Jan
>>
>> >> Signen-off-by: Greg Gallagher <greg@embeddedgreg.com>
>> >> ---
>> >>  kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
>> b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
>> >> index b7e3f52f2..291c9e5f0 100644
>> >> --- a/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
>> >> +++ b/kernel/cobalt/arch/arm64/include/asm/xenomai/fptest.h
>> >> @@ -23,7 +23,7 @@
>> >>  #include <asm/xenomai/uapi/fptest.h>
>> >>  #include <asm/hwcap.h>
>> >>
>> >> -#define have_fp (elf_hwcap & HWCAP_FP)
>> >> +#define have_fp (ELF_HWCAP & HWCAP_FP)
>> >>
>> >>  static inline int fp_kernel_supported(void)
>> >>  {
>> >>
>> >
>> > Jan
>> >
>>
>> --
>> Siemens AG, T RDA IOT
>> Corporate Competence Center Embedded Linux
>>
>
> No problem, ACK.  I'll put a more meaningful commit message as well.  I
> thought I changed that before I sent the patch.
>
> -Greg
>

These don't need to be updated on the arm (aarch32) side of things.  I have
that port running now and should have testing done this evening.  I will
update this patch with a better commit message.

-Greg
