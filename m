References: <9BA84827B30CBE4996725F98F7DC91236519E75A@SMExchange01.siebmeyer.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <48fabf12-d837-01db-6e5e-0b531ba89db2@xenomai.org>
Date: Wed, 11 Jan 2017 12:24:01 +0100
MIME-Version: 1.0
In-Reply-To: <9BA84827B30CBE4996725F98F7DC91236519E75A@SMExchange01.siebmeyer.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] xenomai.allowed_group=<gid>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?H=c3=a4nel-Baas=2c_Alexander?= <alexander.haenel-baas@sieb-meyer.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 01/11/2017 12:05 PM, H=E4nel-Baas, Alexander wrote:
> Hi,
>=20
> when we running our xenomai3 application as root, always works fine.
> But when we running the application as regular user, the following messag=
e was prompt:
>=20
> WARNING: [main] failed to initialize main shared heap
> WARNING: [main] setup call copperplate failed
> BUG in xenomai_init(): [main] initialization failed, EACCES
>=20
> We have already read the documentation: Running a xenomai appl as a regul=
ar user.
> But neither add "xenomai.allowed_group=3Dgid_nr" to the kernel command li=
ne nor "echo gid_nr > /sys module/xenomai/parameters/allowed_group"
> will be help.
>=20
> Our application is alchemy style with Automatic bootstrap enabled.
>=20
> Anny ideas what is going wrong?
>=20
> The kernel Version is: 4.4.26 with Xenomai 3.03 and it works on the Layer=
scape LS102xa platform.
>=20

Running with a shared heap as a regular user requires additional
settings. The log of commit #cf21e8062959 gives details.

--=20
Philippe.

