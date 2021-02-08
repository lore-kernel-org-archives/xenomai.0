Subject: Re: Announce RTnet on PREEMPT_RT Linux
References: <CAPm8-H53-z1ZGekQRHFQ667CRkSgZG7n_Z3Wya8pz9N88racAQ@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <b05c6db1-d300-0f52-657b-d3c8513f0191@siemens.com>
Date: Mon, 8 Feb 2021 19:41:44 +0100
MIME-Version: 1.0
In-Reply-To: <CAPm8-H53-z1ZGekQRHFQ667CRkSgZG7n_Z3Wya8pz9N88racAQ@mail.gmail.com>
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
To: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>, xenomai <xenomai@xenomai.org>

On 08.02.21 15:45, Laurentiu-Cristian Duca via Xenomai wrote:
> Dear friends,
> 
>   Please let me announce the port of the RTnet core on PREEMPT_RT Linux 5.9.
>   Features:
> - ported raspberry pi 4 (bcmgenet), orange pi one (stmmac),
> realtek (8139too), ticpsw (beaglebone black), microchip (enc28j60)
> - rtnet UDP socket, bind, recvmsg, sendto, recvfrom, sendmsg, select,
> poll system calls;
> - sockets with AF_INET (UDP) or AF_PACKET (raw) family;
> - rtnetproxy for ssh and scp (but uses RT driver bandwidth)
> 
>   The project is available on my github [1].
> I've made the code available although it needs some polishing.
> 
> Best regards,
> L-C. Duca
> 
> [1] https://github.com/laurentiuduca/rtnet-preempt_rt
> 

Thanks for sharing!

Very interesting to see this direction while people are (validly)
concerned about maintaining the driver forks that RTnet implies. Can you
share your motivation for and plans with this work?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

