Message-ID: <1374133636.10239.YahooMailNeo@web172205.mail.ir2.yahoo.com>
Date: Thu, 18 Jul 2013 08:47:16 +0100 (BST)
From: Franz Engel <franz_lambert_engel@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Start Process
Reply-To: Franz Engel <franz_lambert_engel@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,=0A=0AI'm still busy with porting my project from an Linux 2.8 to Lin=
ux 3.5 with Xenomai 2.6.2.1. Now had to change something in my code and it =
looks good. But I have a new problem. I have a main application with an GUI=
 that runs in low prior real time. This program is responsible to start dif=
ferent "clients" and "interfaces". I realized them as programs. On my old s=
ystem I started this programs with QProcess. On the new system it seems to =
be impossible. Is there a best practice to start new process by a running p=
rocess?=0A=0ARegards,=0A=A0 =A0 Franz
