Message-ID: <51A6F9AD.3000207@free.fr>
Date: Thu, 30 May 2013 09:03:09 +0200
From: =?ISO-8859-1?Q?St=E9phane_ANCELOT?= <sancelot@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Context switching kernel tracing
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

I have got some problems with an architecture, and 2 realtime tasks.

The realtime is not always respected.

This is a very strange problem in this architecture, since it happens 
statically almost every three reboots...

It looks like there is something in the kernel / or setted up by bios  
that is happening and locks the task switching context.

I implemented LTTNG 2.0 tracing in my target, I would need to know which 
xenomai functions/events are interesting to watch in my kernel traces  ?


Regards,
S.Ancelot


