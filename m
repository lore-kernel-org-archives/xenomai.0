From: Rossier Daniel <Daniel.Rossier@heig-vd.ch>
Subject: Controlling DMA priority between GPU and CPU on x86
Date: Thu, 3 Oct 2019 15:23:01 +0000
Message-ID: <a10e8232f3104d32900617139e7033da@heig-vd.ch>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,

We are currently working on a project called OpenCN which is a framework de=
eply inspired from LinuxCNC, but with a revisited architecture.
Hence, OpenCN is related to machine control.

Our framework mainly use a AMP approach and runs the Xenomai/Cobalt kernel =
on a dedicated CPU with no I-pipe (reworked out).
(We plan to release the framework by first of November).
Our framework works well on a x86 PC, but we have to face an issue regardin=
g DMA priority between the GPU and CPU; when the user plays with the GUI,
some small latencies (O(10ms)) raise up.
Although the question is not directly related to Xenomai, I would be very i=
nterested if somebody knows if it possible to give CPU priority against the=
 GPU,
and how to manage the related DMA controller? Is it possible to configure i=
t ? Or any other hint to avoid this latency ?

Many thanks in advance for any inputs.

Daniel

