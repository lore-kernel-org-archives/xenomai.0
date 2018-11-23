Subject: Re: rtping differences between master and slaves
References: <1542970266.2348.3.camel@smigroup.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <043f0216-fb11-e022-66b8-738f5cd93aee@siemens.com>
Date: Fri, 23 Nov 2018 12:49:28 +0100
MIME-Version: 1.0
In-Reply-To: <1542970266.2348.3.camel@smigroup.net>
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
To: Mauro Salvini <mauro.salvini@smigroup.net>, xenomai <xenomai@xenomai.org>

On 23.11.18 11:51, Mauro Salvini via Xenomai wrote:
> Hi all,
> 
> I'm trying RTNet (an old version: 0.9.13) on Xenomai (yet another old
> version, 2.5.6: unluckily I cannot move to newer versions).
> 
> My setup has 3 identical nodes on isolated RT network: cycle time of
> 5000us, master with slot offset 0, slave A with slot offset 200us and
> slave B with slot offset 400us; network is configured using rtnet
> utility script.
> 
> Using rtping I observe two different behaviors on slaves and master.
> 
> For example, pinging slave A from B:
> 
> ...
> 64 bytes from 10.0.43.91: icmp_seq=1 time=7777.7 us
> 64 bytes from 10.0.43.91: icmp_seq=2 time=7846.3 us
> 64 bytes from 10.0.43.91: icmp_seq=3 time=7966.6 us
> 64 bytes from 10.0.43.91: icmp_seq=4 time=8096.6 us
> ...
> 64 bytes from 10.0.43.91: icmp_seq=15 time=9461.7 us
> 64 bytes from 10.0.43.91: icmp_seq=16 time=9604.2 us
> 64 bytes from 10.0.43.91: icmp_seq=17 time=4719.5 us
> 64 bytes from 10.0.43.91: icmp_seq=18 time=4844.7 us
> 64 bytes from 10.0.43.91: icmp_seq=19 time=4968.3 us
> 64 bytes from 10.0.43.91: icmp_seq=20 time=5124.4 us
> ...
> 64 bytes from 10.0.43.91: icmp_seq=53 time=9215.4 us
> 64 bytes from 10.0.43.91: icmp_seq=54 time=9331.5 us
> 64 bytes from 10.0.43.91: icmp_seq=55 time=9461.0 us
> 64 bytes from 10.0.43.91: icmp_seq=56 time=9585.3 us
> 64 bytes from 10.0.43.91: icmp_seq=57 time=4712.5 us
> 64 bytes from 10.0.43.91: icmp_seq=58 time=4847.0 us
> 64 bytes from 10.0.43.91: icmp_seq=59 time=4967.2 us
> ...
> 
> so time varies between a minimum equal to time distance between two
> slots and a maximum equal to this time plus cycle duration. This can
> makes sense supposing that Linux timer used to generate ping request in
> rtping.c slowly drifts from real-time timer that governs tx slot, so
> the duration changes between requests depending on when request happens
> into the TDMA cycle. Same behavior if I ping A from B or if I ping
> master from A or B.
> 
> On master I instead observe this (pinging slave A or B equally):
> 
> ...
> 64 bytes from 10.0.43.89: icmp_seq=1 time=2434.1 us
> 64 bytes from 10.0.43.89: icmp_seq=2 time=2443.1 us
> 64 bytes from 10.0.43.89: icmp_seq=3 time=2438.7 us
> 64 bytes from 10.0.43.89: icmp_seq=4 time=2450.0 us
> 64 bytes from 10.0.43.89: icmp_seq=5 time=2447.9 us
> 64 bytes from 10.0.43.89: icmp_seq=6 time=2450.6 us
> 64 bytes from 10.0.43.89: icmp_seq=7 time=2428.5 us
> 64 bytes from 10.0.43.89: icmp_seq=8 time=2442.8 us
> 64 bytes from 10.0.43.89: icmp_seq=9 time=2442.3 us
> ...
> 
> ping duration is constant into a rtping execution (changes between
> different executions).
> 
> So I'm puzzling about this difference and I wonder if this is normal or
> if there could be problems.
> 

As you are running RTmac/TDMA: The latency is affected by when during some cycle 
you issue the ICMP request. This is not synchronized with the cycle, so you will 
see random shifts there already. Furthermore, if station A has a time slot 
before station B and A issues the ping, B may have a change to reply in the same 
cycle. If you change roles, this is surely not possible, thus you get different 
round trip times.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

