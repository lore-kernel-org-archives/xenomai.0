From: Andreas Glatz <AndreasGlatz@domain.hid>
Date: Fri, 15 Jan 2010 09:47:43 -0500
Message-ID: <245373446233674495BCA5CA2FC1EB1733A1170AF7@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai-help] Calling native API in user-space signal handler
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I wrote my on SIGSEGV signal handler which gathers information about the fa=
ult and passes that info to a separate process for post-processing.

I'm wondering if it's always save to call native API functions in a signal =
handler?=20

(As according to man 7 signal', it's just save to call a subset of Glibc fu=
nctions from within a signal handler.)

Andreas


