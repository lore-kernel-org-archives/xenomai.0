From: =?iso-8859-1?Q?H=E4nel-Baas=2C_Alexander?=
 <alexander.haenel-baas@sieb-meyer.de>
Date: Wed, 22 Apr 2015 06:14:28 +0000
Message-ID: <9BA84827B30CBE4996725F98F7DC912364F3742C@SMExchange01.siebmeyer.org>
References: <9BA84827B30CBE4996725F98F7DC912342963659@SMExchange01.siebmeyer.org>
 <55363096.8070400@siemens.com>
In-Reply-To: <55363096.8070400@siemens.com>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Xeno3.x xeno-config --kcflags
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi Jan

You are right, kbuild resolve it.

My mistake: I stored the kcflags in a variable and put this variable in the=
 EXTRA_CFLAGS from the make file.
XENOMAI_K_CFLAGS  =3D $(shell /usr/xenomai/bin/xeno-config --rtdm --kcflags=
)
EXTRA_CFLAGS +=3D $(XENOMAI_K_CFLAGS)
The result was: EXTRA_CFLAGS=3D -Iarch/$(SRCARCH)/xenomai/include.

So I need a second expand step from $(SRCARCH).
My solution is the eval function:
$(eval EXTRA_CFLAGS +=3D $(XENOMAI_K_CFLAGS))
And now I get:  EXTRA_CFLAGS=3D -Iarch/arm/xenomai/include=20
and now module builds are success full.

Thank you very much for your post.

Alex




