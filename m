References: <CAFUnMkmps8mXgiR1ggh1=YG7Oas_MgHCfstLFh_12zZ2T0=t6w@mail.gmail.com>
From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Message-ID: <ef082ebb-8c1c-6e40-1cd8-454f8f579482@alaxarxa.net>
Date: Wed, 18 Jul 2018 12:39:40 +0200
MIME-Version: 1.0
In-Reply-To: <CAFUnMkmps8mXgiR1ggh1=YG7Oas_MgHCfstLFh_12zZ2T0=t6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtnet , rt_e1000e is not getting loaded in kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ashok kumar <ashokkumar.bb@gmail.com>, "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 18/07/18 11:40, Ashok kumar wrote:
> Hi,
> when I start rtnet and look in to dmesg I get
> this
> 
>  e1000e 0000:01:00.0 eth0: removed PHC
> [14084.361544] e1000e: eth0 NIC Link is Down
> [14084.404356] rt_e1000e 0000:01:00.0: Disabling ASPM L0s
> [14084.519260] RTnet: registered rteth0
> [14084.519261] rt_e1000e: (PCI Express:2.5GT/s:Width x1) 68:05:ca:2d:b4:0e
> [14084.519262] rt_e1000e: Intel(R) PRO/1000 Network Connection
> [14084.519273] rt_e1000e: MAC: 3, PHY: 8, PBA No: E46981-008
> [14084.522581] initializing loopback...
> [14084.522590] RTnet: registered rtlo
> [14090.273229] e1000e: rteth0 NIC Link is Up 100 Mbps Full Duplex, Flow
> Control: None
> [14090.273231] rt_e1000e: 10/100 speed: disabling TSO
> 
> I want to load rt_e1000e :rteth0 to get loaded, instead of e1000e :rteth0
> 
> Is that rtnet , rt_e1000e correctly got loaded in kernel ?
> 

I'm sorry but I don't get you. What is the result of executing rtifconfig?

Leopold

-- 
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

