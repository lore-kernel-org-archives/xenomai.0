Subject: Re: rt_e1000e on i.mx6 platform
References: <CAKJ14Nf8jYKHALn397GPNewqh+sHUpfME3jinhSe33K3Y2Y-DQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <10cec31a-7400-9a96-37a7-432dc33d3269@siemens.com>
Date: Mon, 30 Sep 2019 14:23:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAKJ14Nf8jYKHALn397GPNewqh+sHUpfME3jinhSe33K3Y2Y-DQ@mail.gmail.com>
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
To: Andreas Glatz <andi.glatz@gmail.com>, xenomai@xenomai.org

On 30.09.19 12:24, Andreas Glatz via Xenomai wrote:
> Hi
> 
> I've been trying to get an Intel PCIE network card working under Xenomai on
> the phyflex i.mx6 platform (phyflex i.mx6 SOM in the phyflex eval board).
> 
> The network card works well with the Linux e1000e driver (legacy
> interrupts) on this hardware. However, when I switch to the rt_e1000e
> driver (legacy interrupts) it does not work so well.
> 
> I looked at the Ethernet frames that are being sent out from the network
> card with Wireshark on a different PC and can see that all the frames are
> have additional bytes (typically 2 bytes) inserted at the front of the
> Ethernet frame. Obviously, then the Ethernet frames are messed up and never
> received on the other end.
> 
> I tested the rt_e1000e driver on an Intel box (MSI-X interrupts), and again
> it works quite well.
> 
> So I think it might have something to do with the PCIE bus on i.mx6....
> 
> My legacy configuration is: Linux 3.0.43, Xenomai 2.6.4, ipipe 1.18-13,
> rtnet 0.9.1
> 
> I also tried it with Linux 4.9 and latest Xenomai 3 & ipipe - with the same
> results.
> 
> Any clues how to get rt_e1000e driver working on my i.mx6 platform?
> 

I would recommend to do register dumps of working and non-working setups and 
compare them.

Leading bytes... VLAN tags? Maybe have a specific look at related registers.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

