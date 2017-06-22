From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Thu, 22 Jun 2017 15:12:51 +0000
Message-ID: <DB6PR0701MB2456385BA8BE0C6C1E339682B5DB0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <VI1PR0101MB2000512FB04A44993FDD1AC6B8DA0@VI1PR0101MB2000.eurprd01.prod.exchangelabs.com>,
 <DB6PR0701MB245673214C08183B8E062DDCB5DA0@DB6PR0701MB2456.eurprd07.prod.outlook.com>,
 <VI1PR0101MB20008C1321074C271F56BBA2B8DB0@VI1PR0101MB2000.eurprd01.prod.exchangelabs.com>,
 <DB6PR0701MB2456F0240792DE24F631E5DFB5DB0@DB6PR0701MB2456.eurprd07.prod.outlook.com>,
 <VI1PR0101MB2000C28614FCC6EED3B15A04B8DB0@VI1PR0101MB2000.eurprd01.prod.exchangelabs.com>
In-Reply-To: <VI1PR0101MB2000C28614FCC6EED3B15A04B8DB0@VI1PR0101MB2000.eurprd01.prod.exchangelabs.com>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Toggling GPIO RT Xenomai on Dragonboard 41c
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "eladyaakovi@campus.technion.ac.il" <eladyaakovi@campus.technion.ac.il>, "xenomai@xenomai.org" <xenomai@xenomai.org>

> Is there any other sleep function for real time ?

That is the correct sleep function for real time, and the sleep time is exp=
ressed in nanoseconds, so you are trying to sleep for 1 microsecond, which =
is well beyond Xenomai's capabilities on many (all?) platforms. Minimum lat=
ency values are around 30 - 60 microseconds, if I am not mistaken.

>> Are you using some Xenomai wrappers or is `fprintf` actually calling the=
 stdlib `fprintf` ?

if that is a stdlib `fprintf` then you have no timing guarantees there, bec=
ause your thread switches to secondary mode (linux mode) and so you can exp=
ect ANY delay instead of the requested one. That delay would then be due to=
 the `rt_task_sleep()` but to the `fprintf`.
Then, again, I have no idea what your file descriptor is, what `fprintf` is=
 or how you are measuring this "30ms" delay, so I cannot help further.

