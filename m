Subject: Re: rt_e1000e: Detected Hardware Unit Hang
References: <CALUpYNbg342eACKbNoxZkKV-ykGjRxJhS_xz0oJxzyeSKgxh6Q@mail.gmail.com>
 <07cfdeae-695f-127d-c38f-f3b6503946d2@siemens.com>
 <CALUpYNYPdbVMJ0Yc5kQV8SzhxWJwRKByyJhWYyUJSgpajZjCLA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8d5abaed-466d-cdf7-a933-0973e4174932@siemens.com>
Date: Fri, 23 Nov 2018 12:59:41 +0100
MIME-Version: 1.0
In-Reply-To: <CALUpYNYPdbVMJ0Yc5kQV8SzhxWJwRKByyJhWYyUJSgpajZjCLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Means Lee <leemeaner@gmail.com>
Cc: xenomai@xenomai.org

On 21.11.18 02:36, Means Lee via Xenomai wrote:
> Sure thing. As I ported e1000e-rt driver from mainline kernel e1000e
> driver, which
> the commit id is 089d7720383d7bc9ca6b8824a05dfa66f80d1f41, the patch file is
>   kind of huge so I attach them here in this mail.
> diff-with-nrt.diff is the diff file of mainline driver e1000e and my ported
> driver.
> diff-with-old-rt-e1000e.diff is the diff file of xenomai v3.0.7 driver and
> my ported driver.
> 

Unified diff ("diff -u"), please. I got that offlist, which is more readable, 
but it remains huge.

So, let's analyze systematically:
  - the upstream Linux driver you ported over works fine with your
    hardware, correct?
  - hardware unit hand may mean that no TX completion interrupt arrived -
    can you confirm this based on /proc/xenomai/irq?
  - did you enable CONFIG_IPIPE_DEBUG_CONTEXT? It can reveal invalid lock
    usage (common mistake when porting linux drivers over)
  - then look into the TX path
     - is the interrupt registered properly?
     - is packet submission happening?
     - is any interrupt arriving?
     - compare event flow to vanilla Linux driver (add instrumentation to
       both)

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

