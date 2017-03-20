From: =?iso-8859-1?Q?C=E9dric_Perles?= <cperles@sepro-group.com>
Date: Mon, 20 Mar 2017 08:52:28 +0100 (CET)
Message-ID: <009e01d2a14e$eb682e00$c2388a00$@sepro-group.com>
MIME-Version: 1.0
Content-Language: fr
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Trying to install Xenomai 3.0.3 on i.MX6 Kernel 4.1.15
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi community,



I=92m a Xenomai newby and I=92m trying to install Xenomai 3.0.3 on my i.MX6
based board (kernel 4.1.15 from NXP).



So I followed the =93Installing Xenomai 3.x=94 chapter in Xenomai.org site =
and
began to download ipipe-core-4.1.18-arm-8.patch.

Since my kernel is not 4.1.18 but 4.1.15, I had to slightly adapt the
patch to make it fit.

Then I ran prepare-kernel.sh that tells me everything was OK.

Finally I successfully compiled kernel (and saw a few ipipe and xenomai
source files were built with into kernel).



However, when I boot on that newly built kernel there is absolutely no
xenomai nor ipipe logs into kernel boot logs, and no /proc/xenomai at all.

I must have missed something or doing something wrong, but I don=92t see.



=3D=3D> Did somebody successfully run Xeno 3.0.3 on i.MX6 ?

=3D=3D> What am I doing wrong ?



Regards,



C=E9dric




Sepro

C=E9dric PERLES
Software R&D engineer
SEPRO Robotique - Rue Henry Bessemer - Zone Acti-Est - CS 10084 - 85003 La
Roche sur Yon Cedex (France)

Tel : +33 (0)2 51 45 05 31

  _____

 <http://www.sepro-group.com/fr> www.sepro-group.com |
<https://twitter.com/seprogroup> twitter@SeproGroup




-------------- next part --------------
A non-text attachment was scrubbed...
Name: image001.jpg
Type: image/jpeg
Size: 22984 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20170320/50daa0cf/at=
tachment.jpg>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: image003.png
Type: image/png
Size: 818 bytes
Desc: not available
URL: <http://xenomai.org/pipermail/xenomai/attachments/20170320/50daa0cf/at=
tachment.png>
