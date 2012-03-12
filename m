Date: Mon, 12 Mar 2012 12:12:45 -0700 (PDT)
From: "Doug Brunner" <dbrunner@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-ID: <1331579565.394426122@domain.hid>
Subject: [Xenomai-help] Intermixing native and POSIX skins
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I'd like to be able to use native skin communications services (most import=
antly real time pipes) from a thread created with the POSIX skin. Is this s=
afe?=0A=0AI'm doing this because I'm building a C++ library that can use ei=
ther real-time communications services, when used with a real-time applicat=
ion, or regular Linux pipe I/O, when used with a Linux application; these s=
ervices are called by tasks that need to exist in both cases. I'd like to m=
ake the tasks always POSIX threads to eliminate the need for a bunch of wra=
ppers and preprocessor ugliness that I put there to support either skin, de=
pending on which version of the library is being built.=0A=0AThanks,=0A    =
Doug Brunner=0A


