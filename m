Message-ID: <551D03F9.8050004@xenomai.org>
Date: Thu, 02 Apr 2015 10:55:21 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <9BA84827B30CBE4996725F98F7DC912342961B3D@SMExchange01.siebmeyer.org>
In-Reply-To: <9BA84827B30CBE4996725F98F7DC912342961B3D@SMExchange01.siebmeyer.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] git clone https ipipe.git fetch failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?windows-1252?Q?=22H=E4nel-Baas=2C_Alexander=22?= <alexander.haenel-baas@sieb-meyer.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/31/2015 02:07 PM, H=E4nel-Baas, Alexander wrote:
> Hi all
>=20
> I try
> git clone https://git.xenomai.org/ipipe.git
>=20
> And get:
> Cloning into 'ipipe'...
> error: Unable to get pack index https://git.xenomai.org/ipipe.git/objects=
/pack/pack-be8960f4c7303115aa655b8eec7c29e476a47c6f.idx
> error: Unable to get pack index https://git.xenomai.org/ipipe.git/objects=
/pack/pack-7406c21d6740fa9d3f29d84c78ec1fa2318ea377.idx
> error: Unable to get pack index https://git.xenomai.org/ipipe.git/objects=
/pack/pack-a976e69a09a914de5f70b330c819578fe05a4542.idx
> error: Unable to find 4d58c244f26df8a07fc501cfea550d5902ce329c under http=
s://git.xenomai.org/ipipe.git
> Cannot obtain needed object 4d58c244f26df8a07fc501cfea550d5902ce329c
> while processing commit ea34abcc6db809d3a2c747bb58bb31a23bb61d6b.
> error: Fetch failed.
>=20
> A problem of the git server, or at my side?
>=20

Sorry for the late reply. Could you try pulling from that tree again?

--=20
Philippe.

