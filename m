References: <91652cf8-9e03-50c0-bee0-06d0bc315a91@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <11012cd3-f1fb-b326-b396-5a71649f01f6@siemens.com>
Date: Mon, 17 Sep 2018 07:02:44 +0200
MIME-Version: 1.0
In-Reply-To: <91652cf8-9e03-50c0-bee0-06d0bc315a91@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTSKB_SIZE
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Edouard Tisserant <edouard.tisserant@gmail.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 15.09.18 15:02, Edouard Tisserant wrote:
> Hi all.
> 
> I'd like to send proper patches to fix RTNet's rt_fec, but I can't
> decide if this change of RTSKB_SIZE is acceptable.
> 
> RTSKB_SIZE=1533 was having a nasty influence on RX ring
> allocation/handling. With RTSKB_SIZE set to the next power of 2 (2048),
> it works better. It might simply be another bug in rt_fec, but I stopped
> searching for now.

What does "better" mean? "Crashes less frequently"? ;)

> 
> In rtskb.h RTSKB_SIZE is hard-coded to 1533. Why such value ?

You mean 1544?

RTSKBs are preallocated in RTnet, therefore their static size. The larger you 
make them, the more you may waste with drivers that do not use that extra space.

> 
> Should RTSKB_SIZE be defined with KConfig, and then depend on what
> driver is selected ?

If there are good reasons for making the buffer larger here (that should be 
understood, though), we could make it a configurable, or select the maximum of 
all enabled drivers (though I don't think the latter is expressible via kconfig).

In fact, there might be good reasons once someone starts working on jumbo frames...

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

