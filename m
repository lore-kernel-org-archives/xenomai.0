From: =?iso-8859-1?Q?Terje_Fr=F8ysa?= <Terje.Froysa@sintef.no>
Date: Mon, 3 Nov 2014 11:44:47 +0000
Message-ID: <314E5ECDAA86314791309FA670550F89C6762243@SINTEFEXMBX05.sintef.no>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Xenoma 2.6.4 missing posix/xeno_config.h ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear forum,

The file xenomai/posix/stdio.h
includes a file named xeno_config.h

This file does not exist in my newly installed 2.6.4 Xenomai environment.

Listing from make:

debian@beaglebone:~/rtdm_dht11-app$ make
gcc -Wall -g -I/lib/modules/3.8.13-bone67/source/include/xenomai -I/lib/mod=
ules/3.8.13-bone67/source/include/xenomai/posix -I/lib/modules/3.8.13-bone6=
7/source/arch/arm/mach-omap2 -c rtdm_dht11-app.c  -o rtdm_dht11-app.o

In file included from rtdm_dht11-app.c:46:0:
/lib/modules/3.8.13-bone67/source/include/xenomai/posix/stdio.h:30:25: fata=
l error: xeno_config.h: No such file or directory
compilation terminated.

Please advice

Best regards
Terje Froysa


Smail: Terje Fr=F8ysa, SINTEF ICT (Information and Communication Technology=
), N-7465 Trondheim, Norway.
Email: terje.froysa@sintef.no<blocked::mailto:terje.froysa@sintef.no> <mail=
to:terje.froysa@sintef.no<blocked::mailto:terje.froysa@sintef.no>>
Phone: +47 930 03603,
Company: Independent R&D, see <http://www.sintef.no/<blocked::http://www.si=
ntef.no/>

