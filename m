Subject: Re: RTNET and rtskb size
References: <1174-5fa9a600-5b-37e14c00@74917988>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c869316e-6c31-9f7b-d9f5-ef0adccfae03@siemens.com>
Date: Tue, 10 Nov 2020 19:57:05 +0100
MIME-Version: 1.0
In-Reply-To: <1174-5fa9a600-5b-37e14c00@74917988>
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
To: =?UTF-8?Q?Fran=c3=a7ois_Legal?= <devel@thom.fr.eu.org>, xenomai@xenomai.org


On 09.11.20 21:26, François Legal via Xenomai wrote:
> Hello list,
> 
> I'm working on a project with a custom MAC which is using up to 2048 ethernet frame length.
> Lately, I was having weird crash in RX interrupt code, or even sometimes in RTNET packet dispatch logic.
> It turned out that while rt_alloc_etherdev () requests the number of rtskb to allocate in the device pool (and with associated packet buffers of RTSKB_SIZE bytes), rtnetdev_alloc_rtskb (that is usually called after one packet is received to allocate a new rtskb for another packet to be received) takes a size parameter, and uses this as the rtskb buffer actual length whereas RTSKB_SIZE only is allocated.
> Because of this, I believe I might be having the MAC overwriting rtskbs that are being used.
> 
> I was wondering if it would not be a good thing to either make rtnetdev_alloc_rtskb check size against RTSKB_SIZE or even discard size parameters, or maybe add a new rt_alloc_etherdev function which would allow passing the max frame length.
> 
> Any thoughs on this ?

The RTnet core is limited to raw packets with RTSKB_SIZE, and that is so
far static. It has to fit to all cards attached in a system as buffers
may circle across them. So, dynamic control can be hard to impossible.

Fixing blind overruns would be definitely valuable, and maybe there is
also value in making that size configurable at build time. Though we do
not have a use case for larger frames in-tree so far.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

