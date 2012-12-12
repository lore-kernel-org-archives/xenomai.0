MIME-Version: 1.0
From: dave.joynson@alstom.com
Message-ID: <OF8BDEF87A.CA8542D0-ON80257AD2.00581CFA-80257AD2.005A5994@test.alstom.com>
Date: Wed, 12 Dec 2012 16:26:52 +0000
Content-Type: text/plain; charset="US-ASCII"
Subject: [Xenomai] Timer support in user-space
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,
I have recently started to use Xenomai on Raspberry Pi. My experience with 
Linux Kernel building etc. is zero so I downloaded the pre-built image 
from powet.eu. I have successfully created a cross compile environment to 
create user-space applications using the Posix skin. While tracking down 
some mode changes I came across the limitation of Posix skin Timers in 
that the timer expiry creates a signal which causes a mode switch.
I have considered creating an application layer timer module using a pool 
of threads that use nanosleep and a callback function on expiry. Careful 
management of these threads using a custom timer API could fulfill my 
requirements.
While exploring the documentation for alternatives, I noticed that the 
RTDM Driver Development API provides access to native timers that would 
seem to perform the functionality that I need, On trying to use them in a 
user-space application, however, it seems that they may only be used in 
kernel-space. This leads me to the following question:

        Is the documentation incorrect for rtdm_timer_init() when it says 
it may be used in user-space tasks?

Dave Joynson
Alstom Grid | Research & Technology | Senior Research Technologist
Phone: +44 (0)1785 223 251 ext. 6577 | E-mail: dave.joynson@alstom.com
Office address: St Leonard Avenue - Stafford ST17 4LX - England
Site: www.alstom.com
** Please consider the environment before printing this e-mail **

P Before printing, please consider the environment!
ALSTOM Grid UK Limited, Registered in England and Wales No. 4955841. 
Registered Office St Leonards Avenue, Stafford, ST17 4LX

:._______________
CONFIDENTIALITY : This  e-mail  and  any attachments are confidential and 
may be privileged. If  you are not a named recipient, please notify the 
sender immediately and do not disclose the contents to another person, use 
it for any purpose or store or copy the information in any medium.
