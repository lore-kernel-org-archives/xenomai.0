Subject: Re: [PATCH] cobalt: Sort out virtual vs. real pids
References: <af9a744d-9617-ed83-6391-edd5fd9ff26d@siemens.com>
 <c4980c02-5264-811b-f0e0-fb3d336599c2@siemens.com>
 <PR3PR02MB620290F360DCB995056445A1D1189@PR3PR02MB6202.eurprd02.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9d2a0368-c341-e9aa-3d3e-b3b84dea75b8@siemens.com>
Date: Tue, 13 Jul 2021 10:51:17 +0200
MIME-Version: 1.0
In-Reply-To: <PR3PR02MB620290F360DCB995056445A1D1189@PR3PR02MB6202.eurprd02.prod.outlook.com>
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
To: MONTET Julien <julien.montet@reseau.eseo.fr>
Cc: Xenomai <xenomai@xenomai.org>

On 12.07.21 09:18, MONTET Julien wrote:
> Hi Jan,
>=20
> Thanks for your suggestions.
> I tried them last weekend, but it didn't work as expected (compilation
> with modifications is ok). The code still hangs
> on=A0rt_task_set_periodic/rt_task_wait_period.
>=20
> There are still few other ways to try such as installing directly the
> Xenomai library on the target and use "volume" on Docker (no
> cross-compilation... even if it worked on ARM).
> Maybe the issue doesn't come from the pid/vpid, I am not 100% sure.
> In any case, I am going to do some other tests this week.
>=20

Got this reproduced (after fighting the usual fight of "Which config
switches does docker need? And which NOT?"). Seems the periodic timer is
not starting at all. Debugging...

BTW, you have a bug in your test, though that is not affecting the
outcome: PTHREAD_EXPLICIT_SCHED needs to be set in order to lift the
scheduling class. And then you also need --cap-add SYS_NICE for docker run.

Jan

--=20
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

