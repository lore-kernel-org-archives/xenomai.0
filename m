Subject: Re: [RTnet] RTcfg: error -11
References: <20200309155830.Horde.qT5DihtwzbpuZDudGbUV2U3@webmail.b-tu.de>
 <5d6a118f-744f-a577-3e8e-dd4edbc3e371@siemens.com>
 <3850b65e-1778-519b-4a06-17f34602a81c@b-tu.de>
 <48a0a4a2-c987-80d7-eecc-c5ea0ddf2bfa@siemens.com>
From: Benji <miethben@b-tu.de>
Message-ID: <57ded5ac-481a-02a3-485b-9f8d0edb1577@b-tu.de>
Date: Wed, 6 May 2020 15:17:01 +0200
MIME-Version: 1.0
In-Reply-To: <48a0a4a2-c987-80d7-eecc-c5ea0ddf2bfa@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

On 3/10/20 10:23 AM, Jan Kiszka wrote:
> On 10.03.20 09:09, Benji wrote:
>> On 3/9/20 7:53 PM, Jan Kiszka wrote:
>>> On 09.03.20 15:58, Benji via Xenomai wrote:
>>>> Hi,
>>>>
>>>> i try to get RTnet up and running, but there are some issues with
>>>> setup.
>>>>
>>>> Two system are connected via a switch. Both have 2 network interface=
,
>>>> Intel i210 and Intel 82574L. Only Intel i210 is used by Xenomai/ RTn=
et.
>>>> One system is configured as master in 'rtnet.conf', the other one as=
 a
>>>> slave. If 'rtnet start' is executed following outputs appears.
>>>>
>>>> Master:
>>>>
>>>>> Waiting for all slaves...
>>>>
>>>> Slave:
>>>>
>>>>> Stage 1: searching for master...
>>>>
>>>> RT interface came up as 'rtifconfig' is shown, but both hang on ther=
e
>>>> stages.
>>>>
>>>> At master the dmesg output are floated with messages like:
>>>>
>>>>> [=C2=A0 323.903321] rt_igb: rteth0: Reset adapter
>>>>> [=C2=A0 323.905082] TDMA: Failed to transmit sync frame!
>>>>> [=C2=A0 323.910082] TDMA: Failed to transmit sync frame!
>>>>> [=C2=A0 323.915083] TDMA: Failed to transmit sync frame!
>>>>> [=C2=A0 323.920083] TDMA: Failed to transmit sync frame!
>>>>> [=C2=A0 323.932087] RTcfg: error -11 while sending stage 1 frame
>>>>
>>>> Anybody knows that error -11 means? I can't find any information on
>>>> this error code.
>>>
>>> EAGAIN - the tx queue is filled up, no packets go out, eventually the
>>> sender is out of (statically allocated) resources. Does transmission
>>> work fine without RTmac/TDMA? Might be that interrupt are not coming
>>> (/proc/xenomai/irq).
>>>
>>> Jan
>>>
>>
>> Hi,
>>
>> i doesn't try yet without TDMA.
>>
>> /proc/xenomai/irq:
>>
>>> cat /proc/xenomai/irq
>> IRQ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU0=C2=A0=C2=A0=C2=
=A0 [sync]
>> 353:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [reschedule]
>> 4354:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [timer-ipi]4355:=C2=A0=C2=A0=C2=A0 9995=
614=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [timer/0]
>> 4419:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 65=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 [virtual]
>>
>=20
> Either the rteth0 is down at this point, or you have an even more
> fundamental problem with the rt_igb. But I suspect the former.
>=20
> Jan
>=20

Thanks for the advice. Comment out all TDMA config option in
'rtnet.conf'. Now rtnet interface started and has configured IP address.

DMESG output:

> [615946.741951] RTnet: registered rteth0
> [615946.741953] rt_igb 0000:04:00.0: Intel(R) Gigabit Ethernet Network =
Connection
> [615946.741955] rt_igb 0000:04:00.0: rteth0: (PCIe:2.5Gb/s:Width x1) 68=
:05:ca:93:80:d7
> [615946.742120] rt_igb 0000:04:00.0: rteth0: PBA No: G65055-011
> [615946.742121] rt_igb 0000:04:00.0: Using MSI interrupts. 1 rx queue(s=
), 1 tx queue(s)
> [615946.754648] rt_loopback: initializing loopback interface...
> [615946.754671] RTnet: registered rtlo
> [615946.761782] RTcfg: init real-time configuration distribution protoc=
ol
> [615946.766091] RTmac: init realtime media access control
> [615946.770150] RTmac/TDMA: init time division multiple access control =
mechanism
> [615946.988039] RTcfg: rtcfg_do_main_event() rtdev=3D1, event=3DRTCFG_C=
MD_CLIENT, state=3DRTCFG_MAIN_OFF
> [615946.988040] RTcfg: next main state=3DRTCFG_MAIN_CLIENT_0
> [615950.657035] rt_igb: rteth0: igb: rteth0 NIC Link is Up 1000 Mbps Fu=
ll Duplex, Flow Control: RX/TX

Interface

>  sudo ./sbin/rtifconfig
> rteth0    Medium: Ethernet  Hardware address: 68:05:CA:93:80:D7
>           IP address: 10.0.0.1  Broadcast address: 10.0.0.255
>           UP BROADCAST RUNNING  MTU: 1500
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0
>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
>=20
> rtlo      Medium: Local Loopback
>           IP address: 127.0.0.1
>           UP LOOPBACK RUNNING  MTU: 1500

Interupts are working

>  cat /proc/xenomai/irq
>   IRQ         CPU0
>    31:         425         rteth0
>  4352:           0         [sync]
>  4353:           0         [reschedule]
>  4354:           0         [timer-ipi]
>  4355:   639826598         [timer/0]
>  4419:          43         [virtual]

But both systems can't be reached each other via rtping? Is there
something else i'm missing?

Thanks
Benji

