From: Umair Ali <ali.umair@tut.fi>
Date: Tue, 26 Jan 2016 11:12:07 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A71C978@mb2010-1.intra.tut.fi>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] Rtnet UDP module.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello there,

I have little confusion. In Xenomai 3.0.1, there is rtudp.ko module of Rtne=
t. The confusion is that if UDP packets are needed to send using the rt_813=
9too.ko then rtudp.ko module is needed to be loaded or not. If we do not us=
e rtudp.ko, will it switch to secondary mode when udp packets are send. Wha=
t is the main purpose of the rtudp.ko module and where it can be used in th=
e userspace.

Thanks & Regards
Umair

