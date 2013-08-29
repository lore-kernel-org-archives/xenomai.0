MIME-Version: 1.0
Date: Thu, 29 Aug 2013 13:06:46 +0200
Message-ID: <CAMZj-5M0tr1Mqc7w10gTnfBwkHnY7xq87NOxNtc4TiPuX2_cvA@mail.gmail.com>
From: Asier Tamayo Arbide <atamayoarbide@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Virtualization with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello all,

My embedded system has two boards running Linux: one runs the user
interface and the other one the critical real-time tasks. Both boards are
running Xenomai on an Atom N270 chipset.



Now, I am planning to compact my system in just one board and have two
options. The first one is to execute everything using Xenomai and the
second one is to port my user interface to Windows and to run both Windows
and Xenomai on top of a hypervisor. My e-mail regards this second option.



I would like to know if anyone has any experience with this. Is the
real-time response affected in any way when using a hypervisor? My current
kernel has been compiled using the ELinOS Embedded Linux distribution. Do I
have to patch it?



I am studying Xen, VmWare, KVM and Enea. Do you recommend any of them? The
board I=92ll use in the new (compact) system will support virtualization
extensions (Intel VT).



Thank you for your help. Best regards,



Ata
