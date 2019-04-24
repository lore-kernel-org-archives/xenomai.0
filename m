From: Alexander Sharabanov <sharabanov.a@tecomgroup.ru>
Subject: Upgrade Xenomai in userspace from 2.x.x to 3.x.x
Date: Wed, 24 Apr 2019 22:08:28 +0000
Message-ID: <BB5C4F5E3633C64999D0577F81995AE7028702F9@XMAIL.tecom.nnov.ru>
Content-Language: ru-RU
MIME-Version: 1.0
Content-Type: text/plain; charset="koi8-r"
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

Hello All,

I have already asked you about "Xenomai: native skin or CONFIG_XENO_OPT_PER=
VASIVE disabled". Thank you, after your answer, I found that SW (userspace)=
 still use Xenomai 2.4.10 instead new. Could you please help me to resolve =
some additional issues.
I will explain: the previous version of project used denx-kernel 2.6.30.3 w=
ith Xenomai 2.4.10. And SW (userspace) had Xenomai 2.4.10 as well. For now =
I have upgraded kernel to origin kernel 3.16.61 (not denx, and I am not abl=
e to use kernel 4.x.x). Also I have upgraded Xenomai to xenomai 3.0.x-stabl=
e for kernel. But I have troubles during upgrading SW (userspace) to new xe=
nomai. I red some documentation - but It does not work for me. Could you pl=
ease explain how I have to upgrade  xenomai in userspace side. My CPU power=
pc(ppc-4xx-) and I use eldk 5.3 for compile kernel and eldk 4.2 for compile=
 SW.
As the second way for resolve issues, I saw that I can migrate from xenomai=
 2.x to xenomai 3.x. if I change Makefile, but I did not find details. Is i=
t possible to use this way?

Thanks,
Alexander
