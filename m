MIME-Version: 1.0
From: Tracy Smith <tsmithdsc99@gmail.com>
Date: Wed, 27 Jul 2016 09:23:22 -0500
Message-ID: <CAL7Yi3Q+zWjueMj84vxOv4J633nBe_JmENnW=Pi8e_nnwth-QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Xenomai ported to ARMv8 NXP QorIQ SDK?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai@xenomai.org

 Has Xenomai been ported to ARMv8?  Or, in particular the NXP/Freescale
QorIQ family of products SDK 1.0 or 2.0, for example the LS1021?

We are using the LS1043 SDK 2.0, which is a new product and wanted to see
if we could download, compile, and bring-up xenomai for evaluation
alongside the 4.1.8 PREEMPT_RT kernel in the NXP SDK 2.0.   Or, will this
require porting it over?



The kernel comes from 4.1.8 stable branch in the community with AArch64 and
ARM extensions. Four core 64 bit ARMv8 Cortex-A53 1.6 GHz.  I didn=E2=80=99=
t see
any indication for this family nor the ARMv8 on the Xenomai website below.
thx, Tracy
