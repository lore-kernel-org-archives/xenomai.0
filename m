From: Gowtham Garimella <ggarime1@jhu.edu>
Date: Tue, 14 Jul 2015 00:57:10 +0000
Message-ID: <CO1PR01MB256AC4CE16186B5C49AEABD949B0@CO1PR01MB256.prod.exchangelabs.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] xenomai latency test hangs due to kernel paging request
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

  =

Hi Everyone,

I have installed xenomai 2.6.4 on ubuntu 14.04 with the latest kernel=A0  3=
.14.17. My hardware is a NUC i5 computer (NUC5i5MYHE model) with x86  archi=
tecture 64 bit computer. I am able=A0 to successfully install xenomai  and =
am able to reboot the system=A0 normally. I checked that Xenomai is enabled=
 correctly=A0 as seen in /var/log/syslog

The issue I am facing is that, when I run xeno latency it hangs and  does=
=A0 not print any latencies. I have seen some posts before on similar=A0  i=
ssues but they did not help much. I enabled ipipe tracing and am=A0  attach=
ing the trace. The main part of the log files=A0 that=A0 I think is the iss=
ue is these lines:


[=A0 643.881016] BUG: unable to handle kernel paging request at 00007fff0d5=
73ea0
[=A0 643.881049] IP: [<ffffffff8163c181>] rthal_strncpy_from_user+0x11/0x30
[=A0 643.881077] PGD 3f78f8067 PUD 3e5e37067 PMD 3ff7b5067 PTE 80000003cf16=
c067
[=A0 643.881108] Oops: 0001 [#1] SMP
[=A0 643.881124] Modules linked in: x86_pkg_temp_thermal i915 drm_kms_helper

Output from xeno-latency:
=A0xeno latency
=3D=3D Sampling period: 100 us
=3D=3D Test mode: periodic user-mode task
=3D=3D All results in microseconds

xeno-test itself runs fine until it hits the latency test. I am=A0  attachi=
ng the trace and kernel config file with this mail. Please let  me=A0 know =
if this is a kernel configuration issue or a hardware issue  etc. I=A0 can =
send more information needed to debug this issue.=A0 Any help is appreciate=
d ...

Regards,
Gowtham Garimella.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config_current
Type: application/octet-stream
Size: 97142 bytes
Desc: config_current
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150714/28c5e2ed/at=
tachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: trace
Type: application/octet-stream
Size: 12330 bytes
Desc: trace
URL: <http://xenomai.org/pipermail/xenomai/attachments/20150714/28c5e2ed/at=
tachment-0001.obj>
