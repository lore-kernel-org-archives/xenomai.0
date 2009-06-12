Message-ID: <4A325746.3060601@domain.hid>
Date: Fri, 12 Jun 2009 15:25:26 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <634c78ce0906120240t694ded8cpfa7fcd9dfb2c3b8@domain.hid>	<200906121148.37732.smolorz@domain.hid>	<4A3235BF.5090201@domain.hid>
	<4A324D3D.9060505@domain.hid> <4A325189.5060905@domain.hid>
	<4A325520.5000809@domain.hid>
In-Reply-To: <4A325520.5000809@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Running Xenomai in a virtual machine
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Johan Visser wrote:
>>> VMware runs, but gives heavy CPU load ( about 38 % ) instead of 6-8 % on
>>> a real system.
>> That's expected if your CPU actually lacks hardware virtualization.
> 
> An idle guest used to consume almost nothing on a vmware host. Only
> MS-DOS needed a special TSR to have its idle mode not consume 100%. On
> the other hand, the last time I used vmware was 5 years ago...

I meant the scale is expected: If basically the same system runs with
some non-zero load on real hw, the load that this machine inside a
code-translating hypervisor like vmware causes to its host will be
noticeably larger. But even the idle load can be noteworthy if I/O
emulation causes a lot of host activities, even with HVM.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

