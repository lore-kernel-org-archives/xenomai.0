Message-ID: <4BB1D0EB.30401@domain.hid>
Date: Tue, 30 Mar 2010 12:22:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BB1C51F.4010106@domain.hid> <4BB1C5B7.7040400@domain.hid>
In-Reply-To: <4BB1C5B7.7040400@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [git pull] RTDM: Fix potential NULL pointer
	dereference
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> The following changes since commit 6b3e8f2e5c69397814cb2f4029cdfbaff16e113e:
>>   Gilles Chanteperdrix (1):
>>         doc: regenerate
>>
>> are available in the git repository at:
>>
>>   git://git.xenomai.org/xenomai-jki.git for-upstream
>>
>> Unfortunately too late for 2.5.2, fortunately only relevant if something
>> else went wrong in create_instance (ENOMEM or application error).
>>
>> Wolfgang Mauerer (1):
>>       RTDM: Fix potential NULL pointer dereference
>>
>>  ksrc/skins/rtdm/core.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
> 
> Was not there any plan to remove this code and have a more "posix
> compliant" close? I thought this had been merged?

Yes. But that requires more work than it would have been appropriate for
2.5.2.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

