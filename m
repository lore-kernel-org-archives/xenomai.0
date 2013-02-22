Message-ID: <51277B66.60505@siemens.com>
Date: Fri, 22 Feb 2013 15:06:30 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <511CD2FB.7010502@gmail.com> <511DDBD5.4060505@web.de>
	<51236088.1030402@gmail.com> <51236A75.5090400@siemens.com>
	<5123C910.7090107@siemens.com> <5123DDBE.8060105@web.de>
	<512778A0.6090300@gmail.com>
In-Reply-To: <512778A0.6090300@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] (Boot)-problems with (current) ipipe patch on AMD FX
 61000 - 2.6.38.8 & 3.5.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Manuel Huber <manuel.h87@gmail.com>
Cc: xenomai@xenomai.org

On 2013-02-22 14:54, Manuel Huber wrote:
> Hey!
> 
> Great work, it booted! I appended the log file, just in
> case you want to check... Let me now if I should test
> some more patches!

Err, that is just an instrumentation that shows if that target vector is
initialized at all. Maybe the instrumentation changed the timing,
"resolving" the issue this way. I will have to look at more details why
IRQ7 is not wired up.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

