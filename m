Message-ID: <44048E34.2020207@domain.hid>
Date: Tue, 28 Feb 2006 18:53:56 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <C029C732.259D%steve@domain.hid>
In-Reply-To: <C029C732.259D%steve@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] rt_task_wait_period() and overruns
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> All right, all right. I surrender. *waves the white flag*
> 
> Let's just say that I saw something different from fusion/classic RTAI and
> was reporting it as a possible bug incorrectly, all right?
> 

Right (except that fusion never exhibited the behaviour you described, though). 
Still, there is an interesting question that remains which you indirectly brought 
in, and which is the real issue to worry about: does rt_task_wait_period(), as it 
is now, behave in the best interest of users who happen to use it properly?

I mean: if the application misses several deadlines because something is going 
wild in there, wouldn't the recovery procedure be easier if one knows at once how 
many deadlines have been missed in a raw, without having to call the RTOS back. 
IOW, do we want to purge the overrun count after the first notification and make 
rt_task_wait_period return this count (e.g. ala Chorus/OS's thread pools), or 
would it be preferable to keep the things the way they are now?

Breaking the API again is also an issue, albeit we already broke it for a few 
other calls when working on v2.1 anyway.

Open question. Something like a poll, actually.

-- 

Philippe.

