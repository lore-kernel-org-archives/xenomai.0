Subject: Re: rtnet rt_igb I210 not working with ARM
References: <AS8PR09MB53544DAD9617B02126202C6381699@AS8PR09MB5354.eurprd09.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ff8025f0-bdac-a99d-a69f-9fb77c824db5@siemens.com>
Date: Thu, 2 Dec 2021 19:25:23 +0100
MIME-Version: 1.0
In-Reply-To: <AS8PR09MB53544DAD9617B02126202C6381699@AS8PR09MB5354.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
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
To: Yann Le Chevoir <yann.lechevoir@cae.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02.12.21 15:35, Yann Le Chevoir via Xenomai wrote:
> Hello,
> 
> I have an issue with rt_igb not working with an Intel I210 on ARM (see
> system configuration below).
> With Wireshark, looks like rtping is sending garbage on the network (see
> below).
> I notice there is no interrupt in /proc/xenomai/irq (see below).
> Looks like other people got issues with I210 in the past but I am not sure
> if they were similar and I am not able to find any conclusion.
> 
> Below, I show you how I am inserting the kernel module + how I am able to
> have it working with igb (no realtime) and rt_fec (different driver for the
> other Ethernet controller on the same board).
> 
> What can I do to solve this issue?
> Is there anything else I can try to give you more data?
> 

Could you check if that card works in a standard PC (x86-64) with RTnet?
Could you also check if latest 3.2.1 makes any difference? Not all fixes
on RTnet have been backported to very-old-stable.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

