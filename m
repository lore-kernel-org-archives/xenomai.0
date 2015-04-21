Message-ID: <55363096.8070400@siemens.com>
Date: Tue, 21 Apr 2015 13:12:22 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <9BA84827B30CBE4996725F98F7DC912342963659@SMExchange01.siebmeyer.org>
In-Reply-To: <9BA84827B30CBE4996725F98F7DC912342963659@SMExchange01.siebmeyer.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Xeno3.x xeno-config --kcflags
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?windows-1252?Q?=22H=E4nel-Baas=2C_Alexander=22?= <alexander.haenel-baas@sieb-meyer.de>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2015-04-21 08:37, H=E4nel-Baas, Alexander wrote:
> Hi,=20
> I run "xeno-config --rtdm --kcflags" to get the cflags when i build my ow=
n kernel modules.
> The script returned:  -Iarch/$(SRCARCH)/xenomai/include
>=20
> My question: who is set $(SRCARCH)?
>=20

That that the directory under linux/arch/ that will be used for the
build. But you don't need to worry about this, kbuild will take care of
resolving it (assuming that you are not trying to reinvent it). Just
feed the output into ccflags-y, e.g.

Jan

--=20
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

