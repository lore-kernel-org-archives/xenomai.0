From: Alex Plits <alex_plits@radwin.com>
Date: Sun, 20 Mar 2016 07:15:42 +0000
Message-ID: <DB5PR06MB1109ECFBDA54A3B1A11457608F8E0@DB5PR06MB1109.eurprd06.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Suggested approach to schedule N-RT work in kernel on a
 specific CPU core
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

We have a requirement to schedule N-RT linux kernel specific work  (e.g. wo=
rkQ) on a dedicated core from an RTDM driver running
In Xenomai "context".
The current RTDM API does in fact provide an API to schedule a N-RT workQ b=
ut this does not meet our needs as we need the N-RT job to run on
A dedicated CPU. Current API implementation will run this special workQ on =
the CPU where the RT scheduling call occurred, so I have 2 queries we need =
help with -

1.       Is there an API/example/configuration that will achieve our needs?

2.       In case there isn't what would be the best approach to implement s=
uch a mechanism - I can think of solutions but it seems excessive:

a.       Run another Xenomai thread that has CPU affinity on the target cpu=
 Core which will call a dedicated RTDM blocking call (e.g. IOCTL with semTa=
ke) and then the scheduling RTDM driver will release that semaphore - which=
 will re-schedule the thread on the core we need and now it can call a N-RT=
 IOCTL for example.

b.      Initialize a new WorkQ on I-Pipe init which will be binded on the t=
arget cpu Core only then add new RTDM api to schedule work on that WorkQ - =
although I'm not sure this will work as it will use the VIRQ  mechanism whi=
ch will somehow need to change cores.

Thanks,
Alex P.
