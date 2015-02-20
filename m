Date: Fri, 20 Feb 2015 19:57:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150220185710.GC2356@hermes.click-hack.org>
References: <CAAg8yo2U6Djk+myWxLJ+rBqEfoy0z3pZhZQMbPDUyi17jH-B+w@mail.gmail.com>
 <20150208174239.GB2014@hermes.click-hack.org>
 <CAAg8yo2Nx-PFM3Fm5bjeCfROrNq5yaicx-ewcQnj9qfVNHFErA@mail.gmail.com>
 <20150220052215.GB16978@hermes.click-hack.org>
 <CAAg8yo2nAj1Bk+J15jms8goZqFP7SASoo-h9kzORZwZM_5snEw@mail.gmail.com>
 <20150220062947.GC16978@hermes.click-hack.org>
 <4E57A2CE-DBB7-49DD-B0A3-78312F35C9DA@gmail.com>
 <20150220064229.GD16978@hermes.click-hack.org>
 <CAAg8yo2tTFE_SoAUEJN9bxJJDSQ0jHmwpQKcya9T2KXyTkvPYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAg8yo2tTFE_SoAUEJN9bxJJDSQ0jHmwpQKcya9T2KXyTkvPYg@mail.gmail.com>
Subject: Re: [Xenomai] Compatibility of PCAN PCI Express Four Channel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Zhe Su <szhe.bme@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, Feb 20, 2015 at 05:33:15AM -0800, Zhe Su wrote:
> Sorry about that. If I used command cat /proc/rtcan/devices on my 2-channel
> PCI express board, I got following results Name___________ _Baudrate
> State___ TX_Counter RX_Counter ____Errors
> 
>   rtcan0             100000 active            0          0          0
>   rtcan1             100000 active            0          0          0
> 
> When I used the same command on the 4-channel PCI express board, I got
> nothing like above results.
> 
> Also when I used command lspci -v. The results didn't show any Kernel
> driver in use and kernel modules. As shown in the results of between
> 2-channel board vs 4-channel board.
> 
> *2- channel: *
> 02:00.0 Network controller: PEAK-System Technik GmbH PCAN-PCI CAN-Bus
> controller (rev 02)
>     Subsystem: PEAK-System Technik GmbH 2 Channel CAN Bus SJC1000
> (Optically Isolated)
>     Flags: medium devsel, IRQ 28
>     Memory at f3ee0000 (32-bit, non-prefetchable) [size=64K]
>     Memory at f3ef0000 (32-bit, non-prefetchable) [size=64K]
>     Kernel driver in use: PEAK-PCI-CAN
>     Kernel modules: xeno_can_peak_pci
> 
> *4-channel: *
> 22:00.0 Network controller: PEAK-System Technik GmbH Device 0003 (rev 02)
>     Subsystem: PEAK-System Technik GmbH Device 0014
>     Flags: bus master, fast devsel, latency 0, IRQ 11
>     Memory at dffe0000 (32-bit, non-prefetchable) [size=64K]
>     Memory at dfff0000 (32-bit, non-prefetchable) [size=64K]
>     Expansion ROM at <unassigned>
>     Capabilities: <access denied>

Well, it would seem the driver does not match your board. Is the
matching done only on vendor id/product id, or are the other ids
used in the driver table ?

-- 
					    Gilles.

