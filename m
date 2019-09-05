Message-ID: <09a04461befe7ec4cf65b9f1a46e70fe.squirrel@mail.ige-grenoble.fr>
Date: Thu, 5 Sep 2019 18:07:42 +0200
Subject: Kernel compilation error
From: davy.regneau@univ-grenoble-alpes.fr
Reply-To: davy.regneau@univ-grenoble-alpes.fr
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: frederic.cazenave@ird.fr

Hi,

we have 4.9.90 linux kernel patched with xenomai 3.0.9 and patched with
ipipe  V4.x.

When we try to compile a simple module we have lot of errors. the first
one is :
error: =91struct ipipe_threadinfo=92 has no member named =91ptd=92

As mentioned by Paolo in response to a similary issue, we tryed to set
CONFIG_IPIPE_LEGACY=3Dy in kernel config but now we are not able to compile
the kernel. we have the following message :

IPIPE_ROOT_NPTDKEYS not define in sched.h

Could you give us some clues to fix our problem?

regards

Davy




