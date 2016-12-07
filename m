References: <50ba3868-6953-faef-5ad5-a650c0c0ea24@numalliance.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e1c90d44-be0d-91a7-98d4-e06ee0007ab1@xenomai.org>
Date: Wed, 7 Dec 2016 17:16:32 +0100
MIME-Version: 1.0
In-Reply-To: <50ba3868-6953-faef-5ad5-a650c0c0ea24@numalliance.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] memory allocation performance in kernel ipipe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 12/07/2016 03:15 PM, St=E9phane Ancelot wrote:
> Hi,
>=20
> I noticed very bad memory allocation performance on some of my graphic
> programs (standard linux applications).
>=20
> If you run any classic program, you won't sea any difference, but it has
> been visible in the following context :
>=20
> I have an application that allocates thousends of graphic widgets,
> label, input fields  at startup (a data editor) .
>=20
> Using the standard kernel, the applications starts very quickly. But=20
> once the ipipe patch is applied to kernel, this application makes lot of
> seconds before appearing.
>=20
> I am using a 3.18 kernel.
>=20

Is there any question?

--=20
Philippe.

