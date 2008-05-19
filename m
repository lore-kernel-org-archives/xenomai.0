Date: Mon, 19 May 2008 12:47:24 -0700 (PDT)
From: George Pitich <george_pitich@domain.hid>
In-Reply-To: <2ff1a98a0805190857s1ad98139h9abe63b743dda35@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <160469.42566.qm@domain.hid>
Subject: [Xenomai-help] Patching order
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi All,

I'm getting Olimex SAM9-L9260, Atmel AT91SAM9260 based
board which initially ships with 2.6.23 patched
kernel. I would like to upgrade to 2.6.24 kernel, so I
can install latest Xenomai. In order to do that, I
need to patch 2.6.24 kernel with 2.6.24-at91.patch.gz
wich has support for the mentioned board. To install
latest Xenomai, adeos-ipipe-2.6.24-arm-1.9-01 patch is
needed. Looks logical to me that 2.6.24-at91.patch.gz
should be applied prior to
adeos-ipipe-2.6.24-arm-1.9-01. Could someone please
confirm if this statement is correct or patching order
is different (or order doesn't matter)?

Reards,

g.


      

