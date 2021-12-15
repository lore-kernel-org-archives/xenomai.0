Subject: Re: Build failure branch 3.1.x
References: <DB9PR05MB77232783D5FBE504E69B2341F6769@DB9PR05MB7723.eurprd05.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <4a0e1ce4-8202-0553-bbeb-5b664d91be21@siemens.com>
Date: Wed, 15 Dec 2021 13:53:05 +0100
MIME-Version: 1.0
In-Reply-To: <DB9PR05MB77232783D5FBE504E69B2341F6769@DB9PR05MB7723.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lange Norbert <norbert.lange@andritz.com>, "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>

On 15.12.21 13:28, Lange Norbert wrote:
> Hello,
>=20
> rebuilding from the 3.1.x branch yields an error:
>=20
> ERROR: "__xnthread_discard" [drivers/xenomai/testing/xeno_switchtest.ko]
> undefined!
>=20
> xeno_switchtest can=92t be compiled as module because of this (works as
> built-in)
>=20

Thanks for reporting. That should affect all branches, in fact. We will
have to export this symbol.

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

