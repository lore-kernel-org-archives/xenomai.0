Message-ID: <51029170.7070104@siemens.com>
Date: Fri, 25 Jan 2013 15:06:40 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Lacking xsave support in Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi all,

yesterday I pushed a fix to my for-upstream queue that properly disables
all xsave-dependent CPU features (AVX/AVX2 namely). However, this is no
real solution for us as it blocks a lot of acceleration potential on
current Intel CPUs.

Did anyone already look into this in more details? Is it just a matter
of implementing the necessary context switching bits? Are there known
pitfalls?

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

