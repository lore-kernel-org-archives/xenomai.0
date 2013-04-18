From: Younes CHALABI <y.chalabi@sinters.fr>
Date: Thu, 18 Apr 2013 10:12:18 +0000
Message-ID: <A46EF8CF1BBB8E4B8A27B73E177C4664EDE4E5@MAIL-SINTERS-01.sinters-int.fr>
Content-Language: fr-FR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] xeno-test problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I have installed [ Xenomai-2.6.0 ] with [ adeos-ipipe-2.6.29-arm-1.13-05.pa=
tch ] on the APF27-dev board with the following parameters :

- Buildroot : 2012.02
- gcc : 4.4.6
- libc : uClibc 0.9.33
- busybox : 1.19.4
- U-Boot : (2012.04)
- Linux : 2.6.29.6

Everything goes OK, but when doing the command : [ xeno-test ] I have the f=
ollowing error message :

___________________________________________________________________________=
____________________________________________________________
# xeno-test
Started child 493: /bin/sh /usr/bin/xeno-test-run-wrapper /usr/bin/xeno-tes=
t
+ echo 0
sh: write error: Bad address
+ :
+ /usr/bin/arith
Xenomai: incompatible feature set
(userland requires "kuser_tsc fastsynch nosmp", kernel provides "sa1100 eab=
i fastsynch nosmp", missing=3D"kuser_tsc").
___________________________________________________________________________=
____________________________________________________________

I don't know what is the kuser-tsc !!!

If someone has an idea, it will be welcome :)

Younes.



