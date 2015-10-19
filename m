From: Alvaro <aramos@ixion.es>
Message-ID: <5624A36D.4070002@ixion.es>
Date: Mon, 19 Oct 2015 10:01:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Problem in Xenomai 3 Cobalt when running some tools
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,
I 'm trying Xenomai 3.0 Cobalt Kernel. I have compiled and encapsulated=20
a preempt_rt_kernel from=20
https://github.com/Clouded/linux-rt-odroid-c1/tree/odroidc-3.10.67-rt71=20
that contains a Xenomai 3.0 with cobalt configuration on a Odroid C1=20
board. Afterwards, I downloaded the xenomai 3-3.0 files from=20
http://git.xenomai.org/xenomai-3.git/xenomai-3-3.0.tar.bz2  to install=20
the libraries and the tools. I have compiled the libraries for Cobalt=20
mode on Odriod board (./configure --with-core=3Dcobalt --enable-smp=20
--enable-pshared). When I execute latency application the system=20
responses as: low init():binding failed: function not implemented. If I=20
compile for Mercury mode when I execute the application latency I get:=20
WARNING: [main] failed to lock memory .
BUG in xenomai_init(): [main] initialization failed, ENOMEM.

Any helping hand?

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

