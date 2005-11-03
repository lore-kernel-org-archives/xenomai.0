From: Romain Lenglet <rlenglet@domain.hid>
Subject: Re: [Xenomai-core] Dev branch 2.1
Date: Thu, 3 Nov 2005 17:51:57 +0900
References: <4368A088.9070906@domain.hid> <4369C3C1.2040302@domain.hid>
	<62.99.195.146.1131007464.wm@domain.hid>
In-Reply-To: <62.99.195.146.1131007464.wm@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511031751.58005.rlenglet@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

> Out of the source tree ?
> I've got everything in /usr/src/xenomai-2.1/ and in this
> directory I did: # ./configure
> # make
>
> Or do you mean in /usr/src/xenomai-2.1/src/ ?
> If the latter: I'd not enforce this as the standard method,
> since people are accustomed to do ./configure and make in the
> tarball-root (?)

What Philippe meant was surely:
mkdir /usr/src/build
cd /usr/src/build
../xenomai-2.1/configure
make

Autotools allow that, and this is a cleaner way of building 
applications.

-- 
Romain Lenglet

