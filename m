Message-ID: <46F9167F.20008@domain.hid>
Date: Tue, 25 Sep 2007 16:09:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Non-APIC setup broken for 2.4-SVN?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

to make it short has anyone or could anyone try latest SVN over kernel 
2.6.20 (i-pipe for 2.6.22 is instable) _without_ LAPIC? It works for me, 
but exposes milliseconds of latencies. Same setup with LAPIC enabled is 
fine and obviously stable. Before digging into this (time is short 
anyway), I would like to exclude problems of my notebook hardware.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

