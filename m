MIME-Version: 1.0
Date: Wed, 26 Nov 2014 12:38:37 +0000
Message-ID: <CAKJ14NeCDLLd_0_ksJWVw6+qPgBAjU8rWjPcyH9QGCDxXYoeQg@mail.gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Xenomai 2.6.4 on i.MX6 Quad
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,

I recently installed the recent xenomai on an i.MX6 Quad SOC from
PHYTEC (for details see end of this Email). The base system was
created with the instructions in [1]. Then I pulled in the changes
from the ipipe 3.14 tree and installed the new kernel. It boots and I
can start the basic xeno-regression-test (see log attached). However,
at the end you can see:

RTD|           1|           0|           0
RTD|           2|           0|           0
ioctl(RTTST_RTIOC_SWTEST_
CREATE_KTASK): Cannot allocate memory
=3D=3D Threads: sleeper_ufps0-0 rtk0-1 rtk0-2 rtk_fp0-3 rtk_fp0-4 rtk_fp_uf=
pp0-5 ...

and xeno-regression-test stops.

However, starting switchtest and latency separately on the console
doesn't produce this error. Do you have any clues what is wrong there?

Thanks.

Andreas


[1] http://phytec.com/wiki/index.php?title=3DPhyFLEX-i.MX6_Linux_Quickstart=
_PD14.1.0_EA2_Yocto

-----
root@imx6q-pbab01:~# cat /proc/version /proc/ipipe/version /proc/xenomai/ve=
rsion
Linux version 3.14.17-fslc+g6c6f90b (andreas@gorse) (gcc version 4.8.2
(GCC) ) #2 SMP PREEMPT Mon Nov 24 13:25:59 GMT 2014
4
2.6.4

root@imx6q-pbab01:~# lsmod
Module                  Size  Used by
xeno_klat               3547  0
xeno_timerbench         5826  0
xeno_rtdmtest           2192  0
xeno_irqbench           4208  0
xeno_switchtest         7520  0
-------------- next part --------------
A non-text attachment was scrubbed...
Name: xeno-regression-test.log
Type: application/octet-stream
Size: 74547 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141126/34d9375=
2/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: latency.log
Type: application/octet-stream
Size: 1942 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141126/34d9375=
2/attachment-0001.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: switchtest.log
Type: application/octet-stream
Size: 3444 bytes
Desc: not available
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20141126/34d9375=
2/attachment-0002.obj>
