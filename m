From: Bruce Director <bruce@vytronus.com>
Date: Thu, 19 Jul 2012 22:36:09 +0000
Message-ID: <C1A3774592D24248BC23BD4FA9550B9AB1811C@VYTRONUS-SBS.vytronus.local>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Intel MKL library fault when running as a xenomai task.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I'm trying to get a library I wrote to run as part of a xenomai task.  The =
library  uses the Intel MKL (math kernel) library.  MKL  uses the SSE instr=
uction set.  Whenever an MKL function is called,  I get a segmentation faul=
t.  The fault always occurs in the MKL function, get_N_Cores.  I created a =
small test program that consists of a main and one function.  The function =
makes one MKL call.   It runs without crashing as a linux program (call the=
 function directly), and crashes in get_N_cores when run as a xenomai task =
(function called via rt_task_start).  The xenomai task is running in user s=
pace.

Intel support said "Just my guess however, MKL_get_N_Cores function tries t=
o recognize CPU topology, but if Xenomai framework changes it via shadowing=
 some CPU parameters (for example, CPU affinity) then MKL might be confused=
".  Is his guess correct?  Is there a fix to this problem?

Thanks,

Bruce
