Date: Mon, 22 Jun 2015 22:36:26 -0400
From: Glen Wernersbach <glen@jetsoftdev.com>
Message-ID: <D1AE3DAE.395E8%glen@jetsoftdev.com>
References: <D1AB0EB3.3950D%glen@jetsoftdev.com>
In-Reply-To: <D1AB0EB3.3950D%glen@jetsoftdev.com>
Mime-version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Error on Installing the Xeno 3 libraries.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi All,

Answered my own question on this. It been a while since I have done a real
time install. I was using /usr/xenomai as my build  root path and it is use=
d
by the script as a common place to install files. It should have been
/usr/src/=8A

Glen

From:  Glen Wernersbach <glen@jetsoftdev.com>
Date:  Saturday, June 20, 2015 at 12:26 PM
To:  "xenomai@xenomai.org" <xenomai@xenomai.org>
Subject:  Error on Installing the Xeno 3 libraries.

Hi All,

I am trying to install the Xenomai libraries on a X86_64 bit system for a 6=
4
target with the following commands:
> sudo $xenomai_root/configure --with-core=3Dcobalt --enable-smp --enable-psh=
ared
> sudo make install
>=20

I keep getting the follow error which I can=B9t find in any previous threads.
Any ideas?
> make[3]: Nothing to be done for `install-exec-am'.
>  /bin/mkdir -p '/usr/xenomai/include'
>  /usr/bin/install -c -m 644 /usr/src/xeno/xenomai-3.0-rc4/include/version=
.h
> '/usr/xenomai/include'
>  /bin/mkdir -p '/usr/xenomai/include'
>  /usr/bin/install -c -m 644 xeno_config.h '/usr/xenomai/include'
> /usr/bin/install: `xeno_config.h' and `/usr/xenomai/include/xeno_config.h=
' are
> the same file
> make[3]: *** [install-nodist_includeHEADERS] Error 1
> make[3]: Leaving directory `/usr/xenomai/include'
> make[2]: *** [install-am] Error 2
> make[2]: Leaving directory `/usr/xenomai/include'
> make[1]: *** [install-recursive] Error 1
> make[1]: Leaving directory `/usr/xenomai/include'
> make: *** [install-recursive] Error 1
>=20

Thanks in Advance.

Glen
--=20
Glen Wernersbach=20
Business, Innovation and Technical Consultant;
President and CEO
Jetsoft Development Co.
629 Old St Rt. 74 =AD Suite 210
Cincinnati, Oh 45244
513-240-9929
glen@jetsoftdev.com


