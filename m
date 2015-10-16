From: Alvaro <aramos@ixion.es>
Message-ID: <5620DBC8.4080508@ixion.es>
Date: Fri, 16 Oct 2015 13:13:12 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Problem with Xenomai 3.0 Cobalt executing latency app
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Good morning,
I 'm trying Xenomai 3.0 Kernel. I have compiled and encapsulated a=20
preempt_rt_kernel from=20
https://pixhawk.org/dev/ros/px4linux#rt_preempt_kernel that contains a=20
Xenomai 3.0 with cobalt configuration on a Odroid C1 board. Afterwards,=20
I downloaded the xenomai 3-3.0 files from your repository to install the=20
libraries and the tools. I have compiled the libraries for Cobalt mode=20
(./configure --with-core=3Dcobalt --enable-smp --enable-pshared). When I=20
execute latency application the system responses as: low init():binding=20
failed: function not implemented. If I compile for Mercury mode when I=20
execute the application latency I get: WARNING: [main] failed to lock=20
memory .
BUG in xenomai_init(): [main] initialization failed, ENOMEM.

Could you help me?

Thanks in advance.
--=20
Alvaro
------------------------------------------------------------------------

http://www.ixion.es <http://www.tcpsi.com/>

=09

*=C3=81lvaro Ramos *
*Control Engineer
*

*

Ixion Industry and Aerospace
Julian Camarillo, 21B
28037 Madrid
Phone   +34 91 440 18 33
Fax        +34 91 304 54 10

*

