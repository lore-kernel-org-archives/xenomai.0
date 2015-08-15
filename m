References: <CAKC9m6f5Yc7MZHZQO2MRCf+y2nOM7P1psX4fLTeqgE4tsnv+RA@mail.gmail.com>
 <20150813191157.GG28709@hermes.click-hack.org>
 <CAKC9m6cKtcwx_tYvWVnqNrFMxxN5=0azmLcqPwzuN_ZBX1Kh8A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <55CED222.8040901@siemens.com>
Date: Sat, 15 Aug 2015 07:46:10 +0200
MIME-Version: 1.0
In-Reply-To: <CAKC9m6cKtcwx_tYvWVnqNrFMxxN5=0azmLcqPwzuN_ZBX1Kh8A@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] I-pipe's determinism in handling hardware interrupts
 when GIC implements "Security Extensions"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Hongfei Cheng <hongfei@mperpetuo.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai Mailing List <xenomai@xenomai.org>

On 2015-08-14 22:38, Hongfei Cheng wrote:
>> If, like I believe,
>> such a "privileged interrupt" is handled by the monitor behind
>> Linux/I-pipe's back, then yes, it will break determinism.
> 
> Do you have any suggestion as to how I-pipe can be improved to work
> with ARM's multiple exception levels in order to ensure determinism on
> ARMv7 (and ARMv8)?

Conceptually, this is fairly similar to the SMM on x86. But, in contrast
to that arch, we tend to have the firmware sources on ARM.

You can check if you actually need the secure monitor on our platform
(it's most often used for PSCI) and disable it (may be trickier on ARMv8
where PSCI is mandatory IIRC) or patch it or the kernel to avoid the
problematic service calls (specifically CPU power control via PSCI).

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

