Message-ID: <552F98FF.8040506@xenomai.org>
Date: Thu, 16 Apr 2015 13:11:59 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <9BA84827B30CBE4996725F98F7DC912342962FE6@SMExchange01.siebmeyer.org>
In-Reply-To: <9BA84827B30CBE4996725F98F7DC912342962FE6@SMExchange01.siebmeyer.org>
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

On 04/16/2015 12:24 PM, H=E4nel-Baas, Alexander wrote:
> Hi Philippe
>=20
> Thank you for your clarifying reply.
>=20
> I have read the document, and you are right i was confused what shall I u=
se: cobalt, alchemy, trank???
>=20
> So, I know: I'm a typical  trank guy:=20
> -D __XENO_COMPAT__=20
> -I/xenomai /include/trank
> -I/xenomai /include/alchemy
> -I/xenomai /include
>=20
> and the most work comes with the implement a UDD driver.
>=20
> Thank you very much.

This doc gives additional details on the API switches:

http://www.xenomai.org/documentation/xenomai-3/html/man1/xeno-config/index.=
html

--=20
Philippe.

