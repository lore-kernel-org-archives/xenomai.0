Message-ID: <47965E88.5000106@domain.hid>
Date: Tue, 22 Jan 2008 22:22:16 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <BF58A8AFB316514587D61EADBFBF4C4101746623@domain.hid>
In-Reply-To: <BF58A8AFB316514587D61EADBFBF4C4101746623@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] x86_64 user/system process accounting
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Kyle Howell <khowell@domain.hid>
Cc: xenomai@xenomai.org

Kyle Howell wrote:
>> Kyle Howell wrote:
>>> I'm running Xenomai 2.4.1 against Linux 2.6.23.12 on an 
>> x86_64 (Core2)
>>> system. I'm finding that all of my CPU cycles are being accounted as
>>> kernel time rather than user time. The correct processes are still
>>> billed, but the system is always 0% user. I'm wondering if 
>> this problem
>>> is specific to my setup, or if it is a real bug. Can anyone else out
>>> there running x86_64 confirm or deny this behavior?
>> That bug should have been fixed by [1]. Already updated your ipipe 
>> patch? This one [2] also includes your recently posted fix.
> 
> Thanks, Jan.
> 
> I'm basing off of ipipe-2.6.23-x86_64-1.4-01, which appears to include
> that patch. I don't think I saw this problem back on 2.4-rc3, so I may

/me would be surprised if the issue was not present in that version or 
any earlier one.

> try rolling back some of the I-pipe patches since then. Also, I just
> tried a kernel with CONFIG_IPIPE turned on but CONFIG_XENOMAI turned
> off, and it didn't show this problem. I don't know if that casts doubt
> on Xenomai itself, or if I just made the pipeline too simple.
> 
> Do you think any of your recent fixes against 2.6.24-x86 would be
> related to this?

Nope, they are not related. But you could try if 2.6.24 with the latest 
patch shows that effect, too. Maybe something slipped into the backport 
of the original fix for 2.6.24-rcX. I will check with 2.6.23 tomorrow at 
work and keep you posted.

Jan

