Message-ID: <1395089344.13662.YahooMailNeo@web171602.mail.ir2.yahoo.com>
Date: Mon, 17 Mar 2014 20:49:04 +0000 (GMT)
From: Matthias Schneider <ma30002000@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] header file order in copperplate/registry.c
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi all,=0A=0Ashouldn't fuse.h be include after xeno_config.h in copperplate=
/registry.c=A0=0Aof xenomai-forge/next in order to allow xeno_config.h to s=
et the FUSE_USE_VERSION=0Adefine before it is set to a default value by fus=
e.h? Otherwise I get compile=0Aerrors due to mismatching APIs.=0A=0ARegards=
,=0A=0AMatthias

