From: "WILES, WILLIAM QUINTON" <WILESW@engr.sc.edu>
Date: Tue, 26 Jun 2007 12:44:57 -0400
Message-ID: <5CBBAC9E1EA66C4E976DDF1D1B55DFE6291B3743EC@MAIL.engr.sc.edu>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Adeos-main] linux 2.6.17 and ARM I-pipe patch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: "adeos-main@gna.org" <adeos-main@gna.org>

I'm currently working with a board that's hardware support is focused mainl=
y on the 2.6.17 kernel revision.  I was wondering if there is a specific re=
ason the ipipe patches jumped from 2.6.14/15 to 2.6.19/20 other than the de=
sire to move to the most up-to-date kernel as possible.  My reasoning is th=
at in an effort to get adeos up on my board I took the most recent prior pa=
tch,

adeos-ipipe-2.6.15-arm-1.5-08.patch

and applied it to my board's functional kernel (2.6.17.9) and manually made=
 the changes that the patch could not apply based on the diff discrepancies=
 between the linux versions.  I had mild success in that I can compile the =
kernel happily, however at runtime it appears to stall.  After reading thro=
ugh the Xenomai wiki for i-pipe porting and a few of the mailing lists I am=
 starting to wonder if my 'shoehorning' approach is too naive, and feedback=
 would be greatly appriciated.

Will Wiles,
wilesw@domain.hid

