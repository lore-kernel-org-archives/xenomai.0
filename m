From: BREGARDIS Cedric <cedric.bregardis@transport.alstom.com>
Date: Thu, 9 Jun 2016 16:25:01 +0000
Message-ID: <f7021dcb136f405a82d01c1768bdf96a@AM3PR48MB0130.041d.mgd.msft.net>
Content-Language: fr-FR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Xenomai/Cobalt on ARM64
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I'm studying the possibility to use xenomai/colbalt 3.x for arm64.  It
seems arm64 port of xenomai is not yet released and only available in
"next" branch. In this branch it is indicated (in file
kernel/cobalt/arch/arm64/patches/README) that the ipipe patch is
available in this repository:

git://git.xenomai.org/ipipe.git, branch devel/ipipe-3.18-linaro-arm64.

However it seems this repository does not provide this branch. Do you
know what version of ipipe should be used for arm64?

Furthermore do you have an idea of the stability of xenomai for arm64
and when it could be expected to be released as a stable version?

Best regards,
Cedric Bregardis

________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may =
be privileged. If you are not a named recipient, please notify the sender i=
mmediately and do not disclose the contents to another person, use it for a=
ny purpose or store or copy the information in any medium.

