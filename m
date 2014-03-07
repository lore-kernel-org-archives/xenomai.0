Message-ID: <531A29CC.4040201@xenomai.org>
Date: Fri, 07 Mar 2014 21:19:24 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] RTDM rework (2)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>


Hi,

here comes a second attempt at introducing a file descriptor support for
other purposes than RTDM drivers.

This time, the file descriptors are called rtdm_fd and are part of the
RTDM API, but can be used by the POSIX personality. The actual RB-tree
where they are stored is part of the xnsys_ppd structure, as this way it
can be used by one of the RTDM and POSIX personalities, even if the
current process is not bound to the other personality.

I have posted the patches to the timerbench, switchtest, rtdm, xddp,
iddp and bufp drivers to allow seeing the API changes.

Regards.

-- 
                                                                Gilles.

