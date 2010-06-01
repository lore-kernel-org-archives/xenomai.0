Message-ID: <4C051E26.8020102@domain.hid>
Date: Tue, 01 Jun 2010 16:50:14 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4C04E8D8.8030101@domain.hid> <4C04EDAF.1080800@domain.hid>
	<4C051100.7000803@domain.hid>
In-Reply-To: <4C051100.7000803@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Linux kernel 2.6.32.14 and Xenomai 2.5.2 does
	not boot
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Daniele Nicolodi wrote:
> On 01/06/10 13:23, Jan Kiszka wrote:
>> Daniele Nicolodi wrote:
>>> Hello.
>>>
>>> In the process of upgrading my data acquisition system from Xenomai
>>> 2.5.0 to Xenomai 2.5.2, I also upgraded the kernel from the 2.6.30
>>> release to 2.6.32.14.
>> Latest Xenomai is 2.5.3, latest 2.6.32 patch is
>> adeos-ipipe-2.6.32.13-x86-2.6-04.patch [1]. Make sure you have both.
> 
> This adeos patch does not apply cleanly to 2.6.32.14 kernel sources.
> Looks like a hunk in include/linux/modules.h has been applied upstream.
> However this was easy to merge.
> 
> Using the latest xenomai and adeos patch however results again in a
> kernel that does not boot on my hardware. This problem is present since
> the first time I have been trying to use xenomai on this box, as I wrote
> in an email to the list on the 17th February early this year, it is thus
> not a recent regression.
> 
> Further suggestions?

Please send an updated .config file.

Note that the configs you sent in Feb. were broken /wrt power management
setting (there should have been big fat warnings signs visible in the
Xenomai sub-menu). I don't think this should cause the lock-ups, but you
won't like the latency results (+ timing can be corrupted for the whole
system).

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

