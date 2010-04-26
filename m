Message-ID: <4BD5C8C4.3040207@domain.hid>
Date: Mon, 26 Apr 2010 19:09:24 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <cover.1271600150.git.jan.kiszka@domain.hid> <4BD54515.9010101@domain.hid>
In-Reply-To: <4BD54515.9010101@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 00/23] [git pull] procfs overflow fixes
	and seq_file conversions
List-Id: Xenomai life and development <xenomai.xenomai.org>
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
> Jan Kiszka wrote:
>> The following changes since commit 113ea4d56e8b215cb56ae7673013163ea5a5987d:
>>   Gilles Chanteperdrix (1):
>>         switchtest: increase stack sizes
>>
>> are available in the git repository at:
>>
>>   git://git.xenomai.org/xenomai-jki.git queues/proc
>>
>> This series fixes some of the potential (but when they happen fatal)
>> overflows in our procfs outputs. Specifically, it fixes all issues in
>> RTDM (one of them hit us in the field) and the recently reported
>> overflow in /proc/xenomai/heap. Moreover, Wolfgang started the lengthy
>> conversion of the registry by introducing a new seq_file-based interface
>> and already moving the native skin over.
>>
>> The future belongs to seq_file, so some of the patches are strictly
>> spoken not yet required. But we better start this effort before the last
>> legacy interface user was converted and the old interface is suddenly
>> dropped from the kernel. This may not be that far away. A patch of mine
>> to improve error reporting of the old interface was rejected with
>> "->read_proc is going to be removed, so there is no point."
> 
> Did you already have a chance to look into this series?

Not yet, that is a big series. With a high potential for kernel crashes,
memory leaks and other things like that. I am trying to find a way to
test it. Maybe we can try and run it with kmemcheck?

-- 
					    Gilles.

