MIME-Version: 1.0
Message-ID: <trinity-3a616500-d86a-4f71-bb11-16fa1d6cf8a2-1448533977790@3capp-webde-bs12>
From: JK.Behnke@web.de
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2015 11:32:57 +0100
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] "RT throttling" issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,
=C2=A0
in my xenomai 2=2E6=2E3 application I sporadically experience very long ex=
ecution times of
a task that switches back and forth between secondary and primary mode=2E
=C2=A0
I added the following code to measure elapsed and cpu time
//------------- start code snippet ---------------
struct rusage rsgT1;
struct rusage rsgT2;
struct timeval tvT1;
struct timeval tvT2;
gettimeofday(&tvT1, NULL);
getrusage(RUSAGE_SELF, &rsgT1);
//
// code block to be measured
//
gettimeofday(&tvT2, NULL);
getrusage(RUSAGE_SELF, &rsgT2);
//------------- end code snippet ---------------

I then calculate the difference and keep the maximum values in
CpuMax (getrusage) and TimeMax (gettimeofday) variables=2E

Typically I observe CpuMax=3D20 =2E=2E 100 ms and TimeMax with similar val=
ues=2E
But sometimes I get huge CpuMax values in the range 5000 =2E=2E 50000 ms=
=2E

Now my questions
In my system logfile I sometimes observe "RT throttling activated" message=
s=2E
According to the Linux kernel 3=2E8=2E13 documentation the Linux scheduler=
 throttles
RT tasks, if they comsume too much cpu time=2E
Could the observed behaviour be related to this?

Is it a problem, if I call gettimeofday/getrusage multiple times in
a loop and the loop is executed every 10 ms?

I would expect TimeMax to always be greater or equal CpuMax=2E
But sometimes I observe CpuMax values that are significantly larger than
TimeMax during the same test session=2E
Any ideas what might be the cause?



Thanks for any comments
Jochen

