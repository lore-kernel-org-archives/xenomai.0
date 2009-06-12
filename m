Message-ID: <4A325520.5000809@domain.hid>
Date: Fri, 12 Jun 2009 15:16:16 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <634c78ce0906120240t694ded8cpfa7fcd9dfb2c3b8@domain.hid>	<200906121148.37732.smolorz@domain.hid>	<4A3235BF.5090201@domain.hid>
	<4A324D3D.9060505@domain.hid> <4A325189.5060905@domain.hid>
In-Reply-To: <4A325189.5060905@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
> Johan Visser wrote:
>> VMware runs, but gives heavy CPU load ( about 38 % ) instead of 6-8 % on
>> a real system.
> 
> That's expected if your CPU actually lacks hardware virtualization.

An idle guest used to consume almost nothing on a vmware host. Only
MS-DOS needed a special TSR to have its idle mode not consume 100%. On
the other hand, the last time I used vmware was 5 years ago...

-- 
                                          Gilles


