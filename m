MIME-Version: 1.0
Date: Thu, 15 May 2008 08:10:46 +0200
From: Matthieu <matthieu.connaulte_xenomai@domain.hid>
In-Reply-To: <18475.12268.192581.316526@domain.hid>
References: <18475.12268.192581.316526@domain.hid>
Message-ID: <7df088046ee0bd577cb7040650d79a05@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] =?utf-8?q?_Re=3A___Re=3A___Re=3A__VxWorks_skin_pro?=
 =?utf-8?q?blem_concerning_WIND=5FTCBstructure?=
Reply-To: matthieu.connaulte_xenomai@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

On Wed, 14 May 2008 20:31:08 +0200, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> Matthie wrote:
>> I still don't have any solution to emulate the fields above listed as =
I
>> don't know if I can use Linux posix services ?
>=20
> Yes, you can use Linux posix services, but they will cause any Xenomai
> thread to switch from primary mode to secondary mode.
>=20
> If you do not understand what I am talking about, you should probably
> read the articles at:
> http://www.xenomai.org/index.php/Publications
>=20
> --
>=20
>=20
> 					    Gilles.

That's the point. Using posix services is pretty much easy, but if this
switches the thread to secondary mode, I'm not sure about using it. I thi=
nk
that VxWorks Task Control Block ,implemeted by  WIND RIVER, is keeping th=
e
context in hard real-time. That's why I would like to know if there are
other possibilities ?

matthieu



