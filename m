Message-ID: <45E0AF7F.1070506@domain.hid>
Date: Sat, 24 Feb 2007 22:34:55 +0100
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
References: <45D9DF65.9000300@domain.hid> <45D9E59B.8040002@domain.hid>
In-Reply-To: <45D9E59B.8040002@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: RT-Socket-CAN versioning
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

Hi Jan,

Jan Kiszka wrote:
> Wolfgang Grandegger wrote:
>> Hi Jan,
>>
>> currently the RT-Socket-CAN drivers maintains it's own version or
>> release number. As RT-Socket-CAN is part of Xenomai, I do not see the
>> need for it (and so far I did not update it). What is the intended use
>> of "driver_version" in "struct rtdm_device"?
> 
> Actually, I was thinking about this too yesterday. The idea of the
> separate versioning for RTDM drivers is to signal the users if something
> in the driver really changed. It's fairly obvious what to do with it for
> out-of-tree drivers, but for in-tree it might be worth considering the
> policy.
> 
> The current model, maintained more or less properly for the existing
> drivers, is to increment independently of Xenomai according to major or
> minor changes. One may ease this burden for the driver developer by
> simply filling in Xenomai's version here. That would just let the
> revisions increase on every Xenomai release, even if the driver remained
> untouched. The tag would still have a meaning for out-of-tree drivers,
> but for in-tree it would be fairly meaningless.
> 
> Well, whatever is commonly preferred, it should then be applied
> consistently on all RTDM drivers in Xenomai. What are the opinions on
> this list (I will comment afterwards)?

OK, no other opinions so far. Then let's keep the current versioning 
scheme. I'm going to boost the RT-Socket-CAN version number to 0.90.0 
with the next commit and to 1.0.0 for the next official release (2.4.x?).

Wolfgang.

