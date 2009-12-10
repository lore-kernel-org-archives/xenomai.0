Message-ID: <4B20C5DE.2040606@domain.hid>
Date: Thu, 10 Dec 2009 10:56:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <843773D242212C4882D4EDFFBF665F7F0155A93A9D@FW-SBS.fw.local>,
	<4B1FE230.8070702@domain.hid>	<843773D242212C4882D4EDFFBF665F7F0155A93AA7@domain.hid>,
	<4B1FEF97.9000509@domain.hid>
	<843773D242212C4882D4EDFFBF665F7F0155A93AAA@FW-SBS.fw.local>
In-Reply-To: <843773D242212C4882D4EDFFBF665F7F0155A93AAA@FW-SBS.fw.local>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai scheduling while atomic bug--debugging
	parameters
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Josh Karch <JKarch@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Josh Karch wrote:
> Hi Jan,
> 
> I did a complete make mrproper on the system and recompiled without debugging parameters, 

mrproper is not required, the kernel is supposed to detect what needs to
be rebuild based on the .config changes.

> which took a few hours on the machine because the modules take up a lot. I probably should prune all unused modules (eg video, pcmcia, sound, etc) that I'm not using.

Yep.

> 
> I guess I will have to back up my current /lib/modules/2.6.30.8 when I recompile with all debug support for that experiment, grab the data, and then get that to you once my testing (hopefully) is successful on this change without kernel debugging options.
> 

Gilles already said this: We also need your .config to check if you are
stressing an uncommon configuration or if we are even able to reproduce
it locally.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

