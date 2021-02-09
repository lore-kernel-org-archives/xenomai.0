MIME-Version: 1.0
In-Reply-To: <b05c6db1-d300-0f52-657b-d3c8513f0191@siemens.com>
References: <CAPm8-H53-z1ZGekQRHFQ667CRkSgZG7n_Z3Wya8pz9N88racAQ@mail.gmail.com>
 <b05c6db1-d300-0f52-657b-d3c8513f0191@siemens.com>
From: Laurentiu-Cristian Duca <laurentiu.duca@gmail.com>
Date: Tue, 9 Feb 2021 14:12:56 +0200
Message-ID: <CAPm8-H6pw4uKX1P1wL+amGiFNQeviE8diocbOHTv9WWOMXO_NA@mail.gmail.com>
Subject: Re: Announce RTnet on PREEMPT_RT Linux
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai <xenomai@xenomai.org>

On 2/8/21, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 08.02.21 15:45, Laurentiu-Cristian Duca via Xenomai wrote:
>> Dear friends,
>>
>>   Please let me announce the port of the RTnet core on PREEMPT_RT Linux
>> 5.9.
>>   Features:
>> - ported raspberry pi 4 (bcmgenet), orange pi one (stmmac),
>> realtek (8139too), ticpsw (beaglebone black), microchip (enc28j60)
>> - rtnet UDP socket, bind, recvmsg, sendto, recvfrom, sendmsg, select,
>> poll system calls;
>> - sockets with AF_INET (UDP) or AF_PACKET (raw) family;
>> - rtnetproxy for ssh and scp (but uses RT driver bandwidth)
>>
>>   The project is available on my github [1].
>> I've made the code available although it needs some polishing.
>>
>> Best regards,
>> L-C. Duca
>>
>> [1] https://github.com/laurentiuduca/rtnet-preempt_rt
>>
>
> Thanks for sharing!
>
> Very interesting to see this direction while people are (validly)
> concerned about maintaining the driver forks that RTnet implies. Can you
> share your motivation for and plans with this work?
>
> Jan
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>

Hi,
  I consider RTnet an interesting project and I was curious about
RTnet architecture
and wondered if its core can be ported to PREEMPT_RT because some
people asked about this.

L.-C.

