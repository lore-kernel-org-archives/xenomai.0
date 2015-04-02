From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Thu, 2 Apr 2015 10:16:40 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC912342962237@SMExchange01.siebmeyer.org>
Content-Language: de-DE
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] git clone https ipipe.git fetch failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Philippe,

I have tried again, here the error:

git clone https://git.xenomai.org/ipipe.git
Cloning into 'ipipe'...
error: Unable to get pack index https://git.xenomai.org/ipipe.git/objects/p=
ack/pack-fc3c9da4f48cfea58e4448f81f2f88cee2a4c047.idx
error: Unable to find ea34abcc6db809d3a2c747bb58bb31a23bb61d6b under https:=
//git.xenomai.org/ipipe.git
Cannot obtain needed object ea34abcc6db809d3a2c747bb58bb31a23bb61d6b
error: Fetch failed.

By the way,  the http git works fine. It is only the https git that have th=
is trouble.
Now I am at the weekend, back at Tuesday than I can make some git test for =
you.

Best regards
Alexander




