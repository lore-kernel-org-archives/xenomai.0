Subject: Re: Multi-slot TDMA Configuration in RTnet
References: <CAJCHRmGD3BRzEQrHBWqc8ZGg2rwuxY-ywBCidRJ651mUXBepnA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <44233df8-eb85-d4c2-b0e5-77ba01149fb8@siemens.com>
Date: Wed, 2 Sep 2020 09:03:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAJCHRmGD3BRzEQrHBWqc8ZGg2rwuxY-ywBCidRJ651mUXBepnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Lakshmi Dhanaraj <lakshmi.d@teclever.com>, sunshilong <sunshilong369@gmail.com>, =?UTF-8?B?OiDlrZnkuJbpvpkgc3Vuc2hpbG9uZyB2aWEgWGVub21haQ==?= <xenomai@xenomai.org>

On 01.09.20 19:08, Lakshmi Dhanaraj via Xenomai wrote:
> Hi,
> 
> My System is configured with Xenomai-3.0.5 on Linux-4.9.38 kernel under
> Ubuntu 18.04.1 LTS. I am using I210 Ethernet Controller with the capability
> of 1Gbps.
> 
> Configured Master and Slave TDMA slot 0 with offset 0 and 400 respectively
> along with a cycle period of 1000 us. For Single-slot(Slot-0), it is
> working fine.
> 
> To configure multiple slots at the slave side, set the offsets 200,400 and
> 600 for rteth0 for slot-0,1 and 2. Monitored the data transmission at
> Wireshark, the packet is transferred once in each cycle period with size of
> 1470 bytes.
> 
> In the calibration request frame, only slot 0 is shown. Does it seem only
> the data transmission occurs from slot-0 only at every cycle period?.How to
> check about slot information in the data packets? How to configure multiple
> slots between a master and a slave?
> 
> 
> Waiting for the reply at earliest.
> 

Did you see
https://gitlab.denx.de/Xenomai/xenomai/-/blob/master/kernel/drivers/net/doc/README.rtmac
already?

One thing I had to read up myself again (wrote that 15 years or so
ago...) is how you can address a specific slot with a transmission from
an application. That works via setting RTNET_RTIOC_XMITPARAMS and
SOCK_XMIT_PARAMS, see also
https://gitlab.denx.de/Xenomai/xenomai/-/blob/master/include/rtdm/uapi/net.h.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

