Message-ID: <552E612D.9090704@xenomai.org>
Date: Wed, 15 Apr 2015 15:01:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <9BA84827B30CBE4996725F98F7DC912342962E20@SMExchange01.siebmeyer.org>
In-Reply-To: <9BA84827B30CBE4996725F98F7DC912342962E20@SMExchange01.siebmeyer.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] porting issue Xeno2 Xeno3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?windows-1252?Q?=22H=E4nel-Baas=2C_Alexander=22?= <alexander.haenel-baas@sieb-meyer.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/15/2015 10:49 AM, H=E4nel-Baas, Alexander wrote:
> Hi
>=20
> Which headers are right?
>=20
> In Xeno2 i include native/timer.h.
> Now in Xeno3 I have read the alchemy is the formerly native API.
> But when I include alchemy/timer.h some defines are missing.
> When I include trank/native/timer.h the compiler are lucky.
>=20
> Which headers shall I used?
>=20

You may want to start reading this document:

http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/

--=20
Philippe.

