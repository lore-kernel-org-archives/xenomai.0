Subject: Re: [RTnet] RTcfg: error -11
References: <20200309155830.Horde.qT5DihtwzbpuZDudGbUV2U3@webmail.b-tu.de>
 <5d6a118f-744f-a577-3e8e-dd4edbc3e371@siemens.com>
From: Benji <miethben@b-tu.de>
Message-ID: <3850b65e-1778-519b-4a06-17f34602a81c@b-tu.de>
Date: Tue, 10 Mar 2020 09:09:26 +0100
MIME-Version: 1.0
In-Reply-To: <5d6a118f-744f-a577-3e8e-dd4edbc3e371@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, xenomai@xenomai.org

On 3/9/20 7:53 PM, Jan Kiszka wrote:
> On 09.03.20 15:58, Benji via Xenomai wrote:
>> Hi,
>>
>> i try to get RTnet up and running, but there are some issues with setu=
p.
>>
>> Two system are connected via a switch. Both have 2 network interface,
>> Intel i210 and Intel 82574L. Only Intel i210 is used by Xenomai/ RTnet=
.
>> One system is configured as master in 'rtnet.conf', the other one as a
>> slave. If 'rtnet start' is executed following outputs appears.
>>
>> Master:
>>
>>> Waiting for all slaves...
>>
>> Slave:
>>
>>> Stage 1: searching for master...
>>
>> RT interface came up as 'rtifconfig' is shown, but both hang on there
>> stages.
>>
>> At master the dmesg output are floated with messages like:
>>
>>> [=C2=A0 323.903321] rt_igb: rteth0: Reset adapter
>>> [=C2=A0 323.905082] TDMA: Failed to transmit sync frame!
>>> [=C2=A0 323.910082] TDMA: Failed to transmit sync frame!
>>> [=C2=A0 323.915083] TDMA: Failed to transmit sync frame!
>>> [=C2=A0 323.920083] TDMA: Failed to transmit sync frame!
>>> [=C2=A0 323.932087] RTcfg: error -11 while sending stage 1 frame
>>
>> Anybody knows that error -11 means? I can't find any information on
>> this error code.
>=20
> EAGAIN - the tx queue is filled up, no packets go out, eventually the
> sender is out of (statically allocated) resources. Does transmission
> work fine without RTmac/TDMA? Might be that interrupt are not coming
> (/proc/xenomai/irq).
>=20
> Jan
>=20

Hi,

i doesn't try yet without TDMA.

/proc/xenomai/irq:

> cat /proc/xenomai/irq
IRQ         CPU0	[sync]
353:           0        [reschedule]
4354:          0        [timer-ipi]4355:    9995614        [timer/0]
4419:         65        [virtual]

Benji

