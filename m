Subject: Re: rt_e1000e: Detected Hardware Unit Hang
References: <CALUpYNbg342eACKbNoxZkKV-ykGjRxJhS_xz0oJxzyeSKgxh6Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <07cfdeae-695f-127d-c38f-f3b6503946d2@siemens.com>
Date: Tue, 20 Nov 2018 10:42:57 +0100
MIME-Version: 1.0
In-Reply-To: <CALUpYNbg342eACKbNoxZkKV-ykGjRxJhS_xz0oJxzyeSKgxh6Q@mail.gmail.com>
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
To: Means Lee <leemeaner@gmail.com>, xenomai@xenomai.org

On 19.11.18 22:57, Means Lee via Xenomai wrote:
> I am porting newer e1000e driver to Xenomai 3.0.7. When I using my ported
> driver to setup an
> RTnet connection, something goes wrong. What I got is an Hardware Unit hang:

Can you share the diff to/patch of the existing one?

Jan

> 
> [ 1598.783133] rt_e1000e: Detected Hardware Unit Hang:
>                   TDH                  <f5>
>                   TDT                  <1e>
>                   next_to_use          <1e>
>                   next_to_clean        <f5>
>                 buffer_info[next_to_clean]:
>                   time_stamp           <10004ea14>
>                   next_to_watch        <f5>
>                   jiffies              <10004f458>
>                   next_to_watch.status <0>
>                 MAC Status             <40080083>
>                 PHY Status             <796d>
>                 PHY 1000BASE-T Status  <3800>
>                 PHY Extended Status    <3000>
>                 PCI Status             <10>
> 
> I'm sure that transmit and receive function works fine for I can send TDMA
> sync frame normally.
> But this message shown during the end of RTcfg ready stage. Is anybody has
> any clue about how to fix this bug?
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

