References: <20160709132949.GA22236@hermes.click-hack.org>
 <20160801132946.368f30eb@md1em3qc>
 <20160801123510.jxujyigrecnbpkiy@hermes.click-hack.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <64e9fed7-ae79-b7fc-04f7-0e74ef1c9239@siemens.com>
Date: Mon, 1 Aug 2016 14:58:54 +0200
MIME-Version: 1.0
In-Reply-To: <20160801123510.jxujyigrecnbpkiy@hermes.click-hack.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Announce] Xenomai 2.6.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Henning Schild <henning.schild@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 2016-08-01 14:35, Gilles Chanteperdrix wrote:
> On Mon, Aug 01, 2016 at 01:29:46PM +0200, Henning Schild wrote:
>> Hey Gilles,
>>
>> i just checked out the new release, which came as a surprise. Thanks
>> for publishing that!
>>
>> Some of the patches prepare for kernel 4.0+ but one specifically makes
>> sure the combination 4.0+ and 2.6.5 wont work.
>>
>> Am Sat, 9 Jul 2016 15:29:49 +0200
>> schrieb Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>>
>> ...
>>>       hal/x86: forbid compilation with Linux 4.0+
>> ...
>>
>> Could you please provide details on how the FPU support is broken. I am
>> successfully using xenomai 2.6 with 4.1.18 for some time now. I am not
>> sure whether the applications on top use the FPU and if so, if there
>> are multiple FPU-users per core.
> 
> The FPU support is broken in the way it detects that Linux was using
> FPU in kernel-space (for RAID, or memcpy on oldish AMD processors,
> geode, K6, etc...) when Linux gets preempted. We can no longer rely
> on checking the bit TS in CR0, and need instead to use an accessor
> that was added in the I-pipe patch to know that. For details, see
> the changes that were made to FPU support for x86 in Xenomai 3.x.
> 

Are we doing eager switching there already? Would allow to use things
as-is (i.e. without having to trap FPU accesses) on CPUs that are recent
enough to do this switching lazily in hardware.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

