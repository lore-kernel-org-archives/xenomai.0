From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Wed, 11 Jan 2017 11:05:04 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC91236519E75A@SMExchange01.siebmeyer.org>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] xenomai.allowed_group=<gid>
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

when we running our xenomai3 application as root, always works fine.
But when we running the application as regular user, the following message =
was prompt:

WARNING: [main] failed to initialize main shared heap
WARNING: [main] setup call copperplate failed
BUG in xenomai_init(): [main] initialization failed, EACCES

We have already read the documentation: Running a xenomai appl as a regular=
 user.
But neither add "xenomai.allowed_group=3Dgid_nr" to the kernel command line=
 nor "echo gid_nr > /sys module/xenomai/parameters/allowed_group"
will be help.

Our application is alchemy style with Automatic bootstrap enabled.

Anny ideas what is going wrong?

The kernel Version is: 4.4.26 with Xenomai 3.03 and it works on the Layersc=
ape LS102xa platform.

With best regards
Alexander H=E4nel-Baas


