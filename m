From: Michael Haberler <mail17@mah.priv.at>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Date: Sat, 16 Feb 2013 08:22:41 +0100
Message-Id: <AB936CE5-5675-4DA5-85B2-F2DD5A88531B@mah.priv.at>
Mime-Version: 1.0 (Apple Message framework v1283)
Subject: [Xenomai] packaging question: no kernel dependencies?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I'm working to debian-package linuxcnc with Xenomai userland RT threads.

AFAICT building requires only the userland support package, but for =
instance not the kernel headers. The way I read =
http://www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/#_fea=
ture_conflict_resolution it is safe to rely on runtime detection of =
feature compatibility.

goof prevention question: Is it safe to wrap such a package without =
explicit references to some kernel version?

- Michael=20



