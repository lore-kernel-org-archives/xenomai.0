From: "Rothermel, Thomas" <Thomas.Rothermel@fkfs.de>
Date: Sat, 29 Aug 2015 15:23:28 +0000
Message-ID: <8655AC8285F53F42A4B1B3CAB3092C47235FD31D@IVKEX2.fkfs.de>
References: <8655AC8285F53F42A4B1B3CAB3092C47235FC2D7@IVKEX2.fkfs.de>,
 <8655AC8285F53F42A4B1B3CAB3092C47235FD2F2@IVKEX2.fkfs.de>
In-Reply-To: <8655AC8285F53F42A4B1B3CAB3092C47235FD2F2@IVKEX2.fkfs.de>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Question about priority coupling in primary and secondary
	mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear all,=0A=
=0A=
I am quite new to Xenomai and I ran into a problem. I searched the mailing =
list archives several times but I did not find any solution that works for =
me. I use Xenomai 2.6.4 and installed the patched kernel on intel I7. Laten=
cy-test as well as xeno-test give good results.=0A=
=0A=
Now my problem:=0A=
I run two periodic threads:=0A=
One high priority communication thread  handling udp communication every 1m=
s. For communication I use plain linux sockets (non-blocking) of which I kn=
ow that they are not hard-realtime capable. However, using them is sufficie=
nt with respect to timing and latency for my application. Furthermore I can=
't use RTnet, because all other network nodes don't use it.=0A=
The second thread is my medium priority worker thread, which is also period=
ic and running every 100ms.=0A=
=0A=
My problem now is that the communication thread is switching to secondary m=
ode (because of the plain linux socket) and then handeled by the linux sche=
duler. The worker thread remains in primary mode and preempts the communica=
tion thread. As a result, the communication thread gets overflows.=0A=
=0A=
Then I found out that from Xenomai v2.6.x on, the option XENO_OPT_PRIOCPL w=
as disabled by default, and I recompiled the kernel with XENO_OPT_PRIOCPL e=
nabled. Unfortunately that didn't help. As far as I understand, this option=
 should solve my problem...=0A=
=0A=
Does anyone have any hints/workaround for solving that problem?=0A=
Thanks!=0A=
=0A=
Regards, Thomas=0A=
=0A=
=0A=
=0A=

