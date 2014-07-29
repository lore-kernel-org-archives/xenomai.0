From: "Reitinger, Peter" <preitinger@carl-valentin.de>
Date: Tue, 29 Jul 2014 09:58:15 +0000
Message-ID: <07fa8167a92741288291537ce8719ca3@CVEX13.valentin-carl.de>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Little fault in installation instructions for arm
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear xenomai people,

in README.INSTALL 3.4 Building for ARM, it is:
$xenomai_root/configure CFLAGS=3D"-march=3Darmv4t" LDFLAGS=3D"-march=3Darmv=
4t" \
  --build=3Di686-pc-linux-gnu --host=3Darm-none-linux-gnueabi-

But probably it should be ... --host=3Darm-none-linux-gnueabi instead? (wit=
hout trailing "-")

Kind regards,
Peter Reitinger
