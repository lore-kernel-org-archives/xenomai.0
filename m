Subject: Re: [Xenomai] ipipe-4.14: planned release date
References: <CAA3JOdZuwus7K4kNBWkQiEWGRMQ6YGwYVEsDwX+W0xoV0SWinA@mail.gmail.com>
 <c09c2b4d-e3ab-177f-c61e-589dc1931f3b@siemens.com>
 <322489d1-78c0-25f9-7831-eb372b25abe6@siemens.com>
 <CAA3JOdaOn60xgw3J3JKxh9p43Gmri7dwyy_aSOXWwbTEL0Fb8A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <80c3df6c-7edf-38f6-5fbb-6333e41c3859@siemens.com>
Date: Thu, 28 Mar 2019 11:19:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAA3JOdaOn60xgw3J3JKxh9p43Gmri7dwyy_aSOXWwbTEL0Fb8A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
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
To: Virendra Kate <virendrakate@gmail.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>, henning.schild@siemens.com

On 28.03.19 01:32, Virendra Kate wrote:
> 
>  >>> Did you all get an update on this issue ? Was it resolved after all? I have
>  >>> the exact same hardware with the exact same issue. The board keeps resetting
>  >>> after "Loading initial ramdisk..."
>  >>>
>  >>> My Setup is as follows:
>  >>> ipipe version: ipipe-core-4.14.89-x86-2
>  >>> Linux-kernel version: linux-4.14.89
>  >>> xenomai version: xenomai-3.0.8
>  >>> Hardware: AMD® Ryzen embedded v1756b
>  >>>
>  >>> The board works fine with Linux kernel 3.9.146 patched with the appropriate
>  >>> xenomai-ipipe files. I would like to move to linux-kernel_4.14 as the GPU
>  >>> driver is officially supported by AMD for linux-kernel_4.14.
>  >>>
>  >>
>  >> No direct progress regarding Ryzen, but I will try to glue together a new 4.14
>  >> version if pending patches soon so that you can try if that happens to help.
>  >> Will let you know.
>  >>
>  >
>  >Just done, see https://gitlab.denx.de/Xenomai/ipipe-x86/
> 
> The same issue persists.
> 
> 1. I downloaded the kernel-patched with ipipe from the above link.
> 2. Added the co-kernel using: ../xenomai-3.0.8/scripts/prepare-kernel.sh 
> --arch=x86_64
> 3. Made the appropriate kernel config changes.
> 
> I have attached my .config file.

To exclude or narow-down config-related issues, you could try starting of with 
the x86_64_defconfig, only adding essential Xenomai and board-related switches.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

