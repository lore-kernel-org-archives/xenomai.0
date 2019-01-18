From: "Baur, Elias" <st153286@stud.uni-stuttgart.de>
Subject: problems with rt libraries in C
Date: Fri, 18 Jan 2019 15:38:38 +0000
Message-ID: <26e9fa502d054d85a1777508a99fd762@stud.uni-stuttgart.de>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello everyone,

First of all, I've got Xenomai running on a SanCloud Beaglebone Enhanced an=
d the latency test works.
I am using Xenomai 3.0.7 on Linux kernel 4.4.

I am currently building a tiny program in C to get some UDP-messages sent a=
nd received. This works perfectly on a non-realtime beaglebone but, as I am=
 trying to rewrite the code using rt-functions provided by Xenomai, I am fa=
cing problems:

To create a socket, I am using the "rt_dev_socket ()"-function which is def=
ined in the "rtdm.h"-header-file and described in the xenomai documentation=
. But, I am not able to find and include the correct library which defines =
the correct reference. Therefore, I replaced the "rt_dev_" commands with "r=
tdm_" which I have found a couple of times in the newer xenomai documentati=
on. So my command to create a socket now is "rtdm_socket()". Nevertheless, =
I am still getting the same error code, which looks like the following:

rtt_rt.c: (.text+0x76): undefined reference to 'rtdm_socket'

My command to compile the file is provided below:

gcc rtt_rt.c -o rtt:rt -I/usr/xenomai/include/ -I/usr/xenomai/include/cobal=
t -I/usr/xenomai/include/trank/ -L/usr/xenomai/lib -ltrank -lalchemy -lcoba=
lt -lcopperplate -lmodechk

So I am already including the libraries provided by xenomai which helped to=
 solve the same problem for functions like "rt_task_create". However, I am =
not able to find the correct library which is providing reference for rtdm_=
socket or rt_dev_socket. That is why I am asking you for help. What am I do=
ing wrong?

I am looking forward to get an answer! Thank you very much!

Best, Eloa=

