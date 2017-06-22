From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Thu, 22 Jun 2017 12:30:03 +0000
Message-ID: <DB6PR0701MB2456F0240792DE24F631E5DFB5DB0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <VI1PR0101MB2000512FB04A44993FDD1AC6B8DA0@VI1PR0101MB2000.eurprd01.prod.exchangelabs.com>,
 <DB6PR0701MB245673214C08183B8E062DDCB5DA0@DB6PR0701MB2456.eurprd07.prod.outlook.com>,
 <VI1PR0101MB20008C1321074C271F56BBA2B8DB0@VI1PR0101MB2000.eurprd01.prod.exchangelabs.com>
In-Reply-To: <VI1PR0101MB20008C1321074C271F56BBA2B8DB0@VI1PR0101MB2000.eurprd01.prod.exchangelabs.com>
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

> Can you explain please why this is not writing to a file:

Is this related to "Re: Toggling GPIO RT Xenomai on Dragonboard 41c" or sho=
uld it go under a separate heading?

> (without the rt_task_sleep(1000) and the while it works fine).

Many things could be wrong with this.=20
If `time_to_run` is very small (or zero), then the condition is never met. =
On the other hand , I have no idea what time(NULL) does. Why don't you add =
a `printf()` inside the loop to see if it gets called once at least?=20
Also, I have no idea why you would try to write one byte to disk every 1 mi=
crosecond and how / whether your system would be capable of dealing with it=
.

Are you using some Xenomai wrappers or is `fprintf` actually calling the st=
dlib `fprintf` ? In the latter case, then I see this code as potentially ha=
nging your system if it actually were to run and `time_to_run` is not small=
 enough.

Just guessing, because we do not see a larger portion of your code.

