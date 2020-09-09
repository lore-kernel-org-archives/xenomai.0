Subject: Re: Multi-slot TDMA Configuration in RTnet
References: <CAJCHRmGD3BRzEQrHBWqc8ZGg2rwuxY-ywBCidRJ651mUXBepnA@mail.gmail.com>
 <44233df8-eb85-d4c2-b0e5-77ba01149fb8@siemens.com>
 <CAJCHRmFC1aXH_7+UZiNsVKbXiBAQVCv3BuzLNoX+BqFyWGTCcQ@mail.gmail.com>
 <CAJCHRmGpsp6gxbyq0x3rbyHkG6b-YYv5a0R2x5KpwmrZc9bKuQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <effd9466-7bca-21fc-a585-822b538f3480@siemens.com>
Date: Wed, 9 Sep 2020 10:07:58 +0200
MIME-Version: 1.0
In-Reply-To: <CAJCHRmGpsp6gxbyq0x3rbyHkG6b-YYv5a0R2x5KpwmrZc9bKuQ@mail.gmail.com>
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
To: Lakshmi Dhanaraj <lakshmi.d@teclever.com>
Cc: sunshilong <sunshilong369@gmail.com>, =?UTF-8?B?OiDlrZnkuJbpvpkgc3Vuc2hpbG9uZyB2aWEgWGVub21haQ==?= <xenomai@xenomai.org>

On 07.09.20 18:54, Lakshmi Dhanaraj wrote:
> Hi Jan,
> 
> Using RTNET_RTIOC_XMITPARAMS & SOCK_XMIT_PARAMS I setted the priority
> and slot ID for Multi-slot configuration.And it is working.
> As per my understanding, the slots are used for writing out-going
> packets in the priority queue, not for incoming data.

Right.

> So for receiving data from multiple slots,the multi-slots are not
> required at the another system.Is't right? Please correct me If I am
> wrong.Is it possibe to read themulti-slot data using the single slot at
> the other end?
> 

Slots are sender slots. Receivers can read from them at any time. RTnet
does the usual dispatching of incoming frames, putting RT packets into
the target socket by protocol or tcp/udp port. Tunneled NRT packets are
forwarded to the Linux stack.

Jan

> 
> With Thanks & Regards,
> 
> Lakshmi.D
> 
> 
> On Wed, Sep 2, 2020 at 8:05 PM Lakshmi Dhanaraj <lakshmi.d@teclever.com
> <mailto:lakshmi.d@teclever.com>> wrote:
> 
>     yes I followed rtmac.txt file for slot configuration.But I have no
>     idea on how to use RTNET_RTIOC_XMITPARAMS and  SOCK_XMIT_PARAMS
>     options inside application.
> 
>     Can you share me an example code for reference?
> 
>     With Thanks & Regards,
> 
>     Lakshmi.D
> 
> 
>     On Wed, Sep 2, 2020 at 12:33 PM Jan Kiszka <jan.kiszka@siemens.com
>     <mailto:jan.kiszka@siemens.com>> wrote:
> 
>         On 01.09.20 19:08, Lakshmi Dhanaraj via Xenomai wrote:
>         > Hi,
>         >
>         > My System is configured with Xenomai-3.0.5 on Linux-4.9.38
>         kernel under
>         > Ubuntu 18.04.1 LTS. I am using I210 Ethernet Controller with
>         the capability
>         > of 1Gbps.
>         >
>         > Configured Master and Slave TDMA slot 0 with offset 0 and 400
>         respectively
>         > along with a cycle period of 1000 us. For Single-slot(Slot-0),
>         it is
>         > working fine.
>         >
>         > To configure multiple slots at the slave side, set the offsets
>         200,400 and
>         > 600 for rteth0 for slot-0,1 and 2. Monitored the data
>         transmission at
>         > Wireshark, the packet is transferred once in each cycle period
>         with size of
>         > 1470 bytes.
>         >
>         > In the calibration request frame, only slot 0 is shown. Does
>         it seem only
>         > the data transmission occurs from slot-0 only at every cycle
>         period?.How to
>         > check about slot information in the data packets? How to
>         configure multiple
>         > slots between a master and a slave?
>         >
>         >
>         > Waiting for the reply at earliest.
>         >
> 
>         Did you see
>         https://gitlab.denx.de/Xenomai/xenomai/-/blob/master/kernel/drivers/net/doc/README.rtmac
>         already?
> 
>         One thing I had to read up myself again (wrote that 15 years or so
>         ago...) is how you can address a specific slot with a
>         transmission from
>         an application. That works via setting RTNET_RTIOC_XMITPARAMS and
>         SOCK_XMIT_PARAMS, see also
>         https://gitlab.denx.de/Xenomai/xenomai/-/blob/master/include/rtdm/uapi/net.h.
> 
>         Jan
> 
>         -- 
>         Siemens AG, Corporate Technology, CT RDA IOT SES-DE
>         Corporate Competence Center Embedded Linux
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

