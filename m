From: =?utf-8?q?Fran=C3=A7ois_Legal?= <devel@thom.fr.eu.org>
In-Reply-To: <50033e69-b5a8-fffe-4e9e-516a947b70c4@siemens.com>
Content-Type: text/plain; charset="utf-8"
Date: Mon, 15 Mar 2021 08:57:42 +0100
MIME-Version: 1.0
Message-ID: <35a5-604f1380-1a5-48dc0d80@57314281>
Subject: =?utf-8?q?Re=3A?= Get packet timestamp in =?utf-8?q?af=5Fpacket?= or
 other RTNET components
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

Le Lundi, Mars 15, 2021 08:16 CET, Jan Kiszka <jan.kiszka@siemens.com> =
a =C3=A9crit: 
 
> On 12.03.21 23:21, Fran=C3=A7ois Legal via Xenomai wrote:
> > Hello,
> > 
> > working on a data recorder application, I would need to get access =
to each packet receive timestamp (populated during packet reception ISR=
 generally in network drivers).
> > 
> > I figured out, the cleanest way to do it would be using the
> >  "void =5F=5Fuser *msg=5Fcontrol;	/* ancillary data */" / "=5F=5Fke=
rnel=5Fsize=5Ft msg=5Fcontrollen;	/* ancillary data buffer length */"
> > members of the struct user=5Fmsghdr that is carried over when using=
 the recvmsg call, plus possibly an ioctl to enable the timestamp retri=
eving
> > 
> > Did anybody already do something like this in xenomai/RTNET ?
> > Any thought on the proposed vector ?
> > Any chance such modification could become mainline ?
> > 
> 
> I would add SO=5FRCVTIMEO support, like rtipc already has.
> 
> Jan
> 
> -- 
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
 
Hello,

Isn't SO=5FRCVTIMEO used to set receive timeout ?

What I intend to do is retrieve the receive time of the packet.

Fran=C3=A7ois


