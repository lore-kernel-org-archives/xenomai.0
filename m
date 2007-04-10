Message-ID: <461B7079.7070703@domain.hid>
Date: Tue, 10 Apr 2007 13:09:45 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060000090709000609040601"
Subject: [Xenomai-core] [ANNOUNCE] RTDM for Linux-rt
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>, ag-automation@domain.hid

This is a multi-part message in MIME format.
--------------060000090709000609040601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

we are proud to announce the first version of RTDM-native, a port of
RTDM [1] over native Linux with the real-time preemption and
high-resolution timer patch [2,3].

RTDM, the Real-Time Driver Model, is an approach to unify the interfaces
for developing device drivers and associated applications under
real-time Linux. So far it was available for the dual-kernel hard
real-time Linux extensions Xenomai [4] and RTAI [5]. This port now
permits to use RTDM drivers like RTserial, RT-Socket-CAN and soon RTnet
with Linux-rt as well. RTDM-native is actually on the road map [6] of
Xenomai 3 aiming at support for native preemption.

RTDM is also an option for OSADL's "Universal Fieldbus and Industrial
I/O Framework" [7] and we believe, that this port makes it even more
attractive as user I/O interface.

Attached you can find a README on how to install and use RTDM-native and
the current implementation status.

Special thanks go to the Open Source Automation Development Lab (OSADL)
[7] for sponsoring this project.

Wolfgang and Jan.


[1]
http://www.xenomai.org/documentation/branches/v2.3.x/pdf/RTDM-and-Applications.pdf
[2] http://people.redhat.com/mingo/realtime-preempt/
[3] http://rt.wiki.kernel.org/index.php/Main_Page
[4] http://www.xenomai.org
[5] http://www.rtai.org
[6] http://www.xenomai.org/index.php/Xenomai:Roadmap
[7] http://www.osadl.org




--------------060000090709000609040601
Content-Type: text/plain;
 name="README.rtdm-native"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README.rtdm-native"

0. Introduction
---------------

This is a first version of RTDM-native, a port of RTDM [1,2] over native
Linux with the real-time preemption and high-resolution timer patch [3,4].
RTDM, the Real-Time Driver Model, is an approach to unify the interfaces
for developing device drivers and associated applications under real-time
Linux. It is currently available for the dual-kernel hard real-time Linux
extensions Xenomai [5] and RTAI [6]. This port permits to use RTDM drivers
like RTserial, RT-Socket-CAN and soon RTnet under Linux-rt as well.
RTDM-native is on the road map [7] of Xenomai 3 aiming at support for
native preemption.


1. Installation
---------------


1.1 Downloading RTDM-native
---------------------------

RTDM-native can be downloaded from Xenomai's SVN repository [8] as shown
below:

$ svn co http://svn.gna.org/svn/xenomai/branches/rtdm-native rtdm-native
$ export RTDM_NATIVE_ROOT=$PWD/rtdm-native


1.2 Preparing the target kernel
-------------------------------

RTDM-native uses Xenomai's procedure of preparing the kernel tree [9].
The shell script "scripts/prepare-kernel.sh" sets up the target kernel
properly. The syntax is as follows:

$ cd $RTDM_NATIVE_ROOT
$ scripts/prepare-kernel.sh --rtdm-native --linux=<linux-srctree>

    --rtdm-native tells the script that the kernel should be prepared for
    RTDM-native. This requires a vanialla kernel with the real-time preemption
    and high-resolution timer patch (CONFIG_PREEMPT_RT=y and
    CONFIG_HIGH_RES_TIMERS=y).

    --linux specifies the path of the target kernel source tree. Such
    kernel tree being configured or not makes no difference and is
    valid either way.

For instance, the following command would prepare the Linux tree
located at /usr/src/linux-2.6.20-rt8 in order to include the RTDM-native
support:

$ cd RTDM_NATIVE_ROOT
$ scripts/prepare-kernel.sh --rtdm-native --linux=/usr/src/linux-2.6.20-rt8

Note: The script will infer the location of the RTDM-native kernel code
from its own location within the Xenomai source tree. In other words,
if /usr/src/rtdm-native/script/prepare-kernel.sh is executing, then
RTDM-native's kernel support available from /usr/src/rtdm-native/ksrc will
be bound to the target kernel.


1.3 Configuring and building the target kernel
----------------------------------------------

Once the target kernel has been prepared, all RTDM-native configuration
options are available from the "Real-time subsystem" toplevel menu.

There are several configure options that cause large latencies; they
should be avoided. Check Xenomai's TROUBLESHOOTING file [10] and the
Real-Time Linux Wiki [3] for futher information and help. Once configured,
the kernel should be built as usual.

If you want several different configs/builds at hand, you can reuse
the same source by adding O=../build-<target> to each make invocation.
See also section 2.2 of [9] for an example.


1.4 Building the user-space support
-----------------------------------

The user space example and utilitiy programs are currently available in
"examples/rtdm-native". To build them, just go this directory and type make:

$ cd RTDM_NATIVE_ROOT/examples/rtdm-native
$ make


2. Availability and test cases
------------------------------

This port has preliminary and experimental support for RTDM task services.
The implementation is not straight-forward, especially because of tricky
parts like periodic mode, task removal and releasing locked resources.
Nevertheless, the basic functionality is available and it should already
be enough to get RTnet working.

The RTDM-native port has been tested with the following RTDM named and
protocol drivers:

- RTserial
- RT-Socket-CAN
- irqbench (without kernel tasks)

Note: for RTnet [11] further effort is required, mainly its build system
must be adopted accordingly.


3. To-Do List
-------------

- Finalizing and testing RTDM task support.
- Implementing PROC file-system support.
- Fixing a few issues marked with "FIXME" in the source code.
- Get RTnet built and working with RTDM-native.


4. References
-------------

[1] http://www.xenomai.org/documentation/branches/v2.3.x/pdf/RTDM-and-Applications.pdf
[2] http://www.xenomai.org/documentation/trunk/html/api/group__rtdm.html
[3] http://rt.wiki.kernel.org/index.php/Main_Page
[4] http://people.redhat.com/mingo/realtime-preempt/
[5] http://www.xenomai.org
[6] http://www.rtai.org
[7] http://www.xenomai.org/index.php/Xenomai:Roadmap
[8] https://gna.org/svn/?group=xenomai
[9] http://www.rts.uni-hannover.de/xenomai/lxr/source/README.INSTALL?v=SVN-trunk
[10] http://www.rts.uni-hannover.de/xenomai/lxr/source/TROUBLESHOOTING?v=SVN-trunk
[11] http://www.rtnet.org

--------------060000090709000609040601--

