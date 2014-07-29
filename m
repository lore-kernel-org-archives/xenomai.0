From: "Reitinger, Peter" <preitinger@carl-valentin.de>
Date: Tue, 29 Jul 2014 13:59:32 +0000
Message-ID: <c0432fe8fb61494588e50b7c7cbf5b17@CVEX13.valentin-carl.de>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Cross compiling include path
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi dear xenomai people,

sorry that I have so many question, but there is already another one... ;-)

I have seen that my output for cflags is as follows:

hico@debian:dimm-am335x:~/workspace/Xenomai/xenomai_from_git/staging_dir/us=
r/xenomai/bin$ xeno-config --skin=3Dnative --cflags
-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__

But it should be -I${staging_dir}/usr/xenomai/include as I guess for cross =
compilation.
Is it -I/usr... because I have made a mis-configuration in any step before?=
 Of course, I can simply fix it by adapting my Makefile and add the right i=
nclude directory, but I would like to prevent later problems as early as po=
ssible...

Kind regards
