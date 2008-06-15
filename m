Message-ID: <e4ef24880806151540r477dbe2bq6162a7b781c60f7e@domain.hid>
Date: Sun, 15 Jun 2008 15:40:09 -0700
From: "Rob Gubler" <rgubler@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_22286_30652198.1213569609905"
Subject: [Xenomai-help] CPU affinity on a per thread basis
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

------=_Part_22286_30652198.1213569609905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I am using Xenomai 2.4.  I'd like to explicitly control which CPU a
particular thread executes on.  The Xenomai POSIX skin documentation says to
achieve this with
pthread_attr_setaffinity_np(...)<%28http://www.xenomai.org/documentation/trunk/html/api/group__posix__threadattr.html#gc79718c596b9cb0fdff961eede1f5995%29>my
thread needs to be created in the kernel space. I just want to verify
that this can not be accomplished in a user space thread?

I found a post<https://mail.gna.org/public/xenomai-help/2007-05/msg00300.html>a
year or so ago about this that mentions CPU affinity using
sched_setaffinity(...).  My understanding though is that this particular
call sets the affinity for the entire process/task and doesn't allow thread
specific CPU affinity control.  Is this true?

Lastly, is it possible to limit the Linux kernel to run on only a single CPU
to free all other CPUs for Xenomai specific tasks?

Thanks,

Rob

------=_Part_22286_30652198.1213569609905
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br><br>I am using Xenomai 2.4.&nbsp; I&#39;d like to explicitly control which CPU a particular thread executes on.&nbsp; The Xenomai POSIX skin documentation says to achieve this with <a href="%28http://www.xenomai.org/documentation/trunk/html/api/group__posix__threadattr.html#gc79718c596b9cb0fdff961eede1f5995%29">pthread_attr_setaffinity_np(...)</a> my thread needs to be created in the kernel space. I just want to verify that this can not be accomplished in a user space thread?<br>
<br>I found a <a href="https://mail.gna.org/public/xenomai-help/2007-05/msg00300.html">post</a> a year or so ago about this that mentions CPU affinity using sched_setaffinity(...).&nbsp; My understanding though is that this particular call sets the affinity for the entire process/task and doesn&#39;t allow thread specific CPU affinity control.&nbsp; Is this true?<br>
<br>Lastly, is it possible to limit the Linux kernel to run on only a single CPU to free all other CPUs for Xenomai specific tasks?<br><br>Thanks,<br><br>Rob<br>

------=_Part_22286_30652198.1213569609905--

