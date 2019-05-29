From: Artem Ipatov <ipatov.a@tecomgroup.ru>
Subject: Xenomai GLIBC_2.4
Date: Wed, 29 May 2019 12:36:21 +0000
Message-ID: <9B01BB3D2A1AA3489B9F144D3354F9E70221DD31@XMAIL.tecom.nnov.ru>
Content-Language: ru-RU
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

Hello! I'm trying to build a project with xenomai 3.0. Previously, xenomai =
2.4 was used in this project. So, I get linking errors associated with the =
version GLIBC. Can I somewhere in the project xenomai change the dependence=
 of xenomai 3.0 on the version of GLIBC? Thank you!
Error example:
arch/ppc/xenomai/lib/libcobalt.so: undefined reference to `fprintf@GLIBC_2.=
4'

