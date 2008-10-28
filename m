Message-ID: <4907728C.6090708@domain.hid>
Date: Tue, 28 Oct 2008 21:14:04 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <4905B40D.5050109@domain.hid> <49076938.6040806@domain.hid>
In-Reply-To: <49076938.6040806@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] CAN filter issues
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Sebastian Smolorz wrote:
>> Hi Wolfgang,
>>
>> we currently face an issue regarding the filtering of CAN messages since 
>> Xenomai 2.4. It was introduced in rev. 2202 (I know it is long ago but 
>> the problem popped up last week). The line in question is
>>
>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rtcan_raw_filter.c?v=2.3.5#064
>>
>> and
>>
>> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/rtcan_raw_filter.c?v=2.4.4#062
>>
>> respectively.
>>
>> What worries me is the removal of the AND-operation (can_id & can_mask). 
>>  From my POV this offends the CAN specification which says that the CAN 
>> filter mask shall indicate which bits are taken into account when 
>> comparing a CAN identifier and which shall be seen as "don't care".
>>
>>  From your Changelog entry the reason for this modification was to be up 
>> to date with the Linux Socket CAN project. So maybe there is also the 
>> need to bring up this topic on their ML, too.
> 
> No, this looks like a Xenomai-exclusive bug. If I quick-read mainline
> correctly, this line prevents that bits in can_id which should be
> ignored according to the mask can cause problems when they are set:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=net/can/af_can.c;h=7d4d2b3c137ef6b84598d9bebd50b1a69dfaf707;hb=HEAD#l340
> 
> So, unless I'm now also misled, we are basically lacking a final
> 
> recv_filter->can_id &= recv_filter->can_mask;
> 
> in rtcan_raw_mount_filter. Wolfgang, correct?

I think so. Will do a more careful cross-check tomorrow.

Wolfgang.

