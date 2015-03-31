From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Tue, 31 Mar 2015 12:07:38 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC912342961B3D@SMExchange01.siebmeyer.org>
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

Hi all

I try
git clone https://git.xenomai.org/ipipe.git

And get:
Cloning into 'ipipe'...
error: Unable to get pack index https://git.xenomai.org/ipipe.git/objects/p=
ack/pack-be8960f4c7303115aa655b8eec7c29e476a47c6f.idx
error: Unable to get pack index https://git.xenomai.org/ipipe.git/objects/p=
ack/pack-7406c21d6740fa9d3f29d84c78ec1fa2318ea377.idx
error: Unable to get pack index https://git.xenomai.org/ipipe.git/objects/p=
ack/pack-a976e69a09a914de5f70b330c819578fe05a4542.idx
error: Unable to find 4d58c244f26df8a07fc501cfea550d5902ce329c under https:=
//git.xenomai.org/ipipe.git
Cannot obtain needed object 4d58c244f26df8a07fc501cfea550d5902ce329c
while processing commit ea34abcc6db809d3a2c747bb58bb31a23bb61d6b.
error: Fetch failed.

A problem of the git server, or at my side?

With best regards,
Alexander H=E4nel-Baas
