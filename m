From: HAUTBOIS Flavian <Flavian.HAUTBOIS@cea.fr>
Date: Mon, 17 Jun 2013 07:54:44 +0000
Message-ID: <49E736B33FAAA645BCAB9FFEC26712E6FD0C05@EXDAG0-B0.intra.cea.fr>
Content-Language: fr-FR
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] CPU time limit exceeded
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I'm having a 'CPU time limit exceeded' error. Of course I tried to set ulim=
it to unlimted, without any success.

I am running a program that uses RTNet over Xenomai 2.6.2. The source of th=
e program can be found here: git.mech.kuleuven.be/robotics/soem.git

Here is the core dump backtrace:

    #0  0xb77b8424 in __kernel_vsyscall ()
    #1  0xb5c03c2c in __wrap_send () from /usr/xenomai/lib/libpthread_rt.so=
.1
    #2  0xb43d2a93 in ec_outframe (idx=3D1 '\001', stacknumber=3D0) at /hom=
e/alex/ros_workspace/orocos/soem/soem_core/build/soem_core/src/nicdrv.c:404
    #3  0xb43d2b28 in ec_outframe_red (idx=3D1 '\001') at /home/alex/ros_wo=
rkspace/orocos/soem/soem_core/build/soem_core/src/nicdrv.c:427
    #4  0xb43d3248 in ec_srconfirm (idx=3D1 '\001', timeout=3D20000) at /ho=
me/alex/ros_workspace/orocos/soem/soem_core/build/soem_core/src/nicdrv.c:70=
2
    #5  0xb43c9839 in ec_BRD (ADP=3D0, ADO=3D0, length=3D2, data=3D0xbffd53=
a6, timeout=3D20000) at /home/alex/ros_workspace/orocos/soem/soem_core/buil=
d/soem_core/src/ethercatbase.c:200
    #6  0xb43cc282 in ec_config_init (usetable=3D0 '\000') at /home/alex/ro=
s_workspace/orocos/soem/soem_core/build/soem_core/src/ethercatconfig.c:162
    #7  0xb4413fb1 in soem_master::SoemMasterComponent::configureHook (this=
=3D0x887d648) at /home/alex/ros_workspace/orocos/soem/soem_master/soem_mast=
er_component.cpp:73

Now the weird part. There are two libraries that are generated. The first o=
ne is soem_core, and the second one is soem_master (if you dig into the sou=
rce code you may find it's a little bit more complex).

There is one executable which uses soem_core, and it succeeds in sending an=
 EtherCAT frame through RTNet without any problems.
The soem_master library also depends on soem_core and uses _exactly_ the sa=
me functions as the above executable, _in the same order_. The only differe=
nce is that the soem_master lib is fed to Orocos (a robotic real-time middl=
eware, not sure this is very important here though) to execute a Master.con=
figure() function (if you were wondering where the configureHook came from)=
. However, it crashes when executing the "send" function (see the bt). It i=
s worth noting that Wireshark detects that one EtherCAT frame is send when =
using this method (it crashes right after). It is also worth noting that ev=
erything is built using the ROS build system.

According to the soem developpers, everything works fine on Xenomai 2.5.6, =
but I have to use Xenomai 2.6.2. Do you have any idea what could trigger th=
is error and how to fix it?

Thanks

Flavian Hautbois
