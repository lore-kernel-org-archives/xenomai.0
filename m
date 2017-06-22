From: "eladyaakovi@campus.technion.ac.il" <eladyaakovi@campus.technion.ac.il>
Date: Thu, 22 Jun 2017 15:05:17 +0000
Message-ID: <VI1PR0101MB2000C28614FCC6EED3B15A04B8DB0@VI1PR0101MB2000.eurprd01.prod.exchangelabs.com>
References: <VI1PR0101MB2000512FB04A44993FDD1AC6B8DA0@VI1PR0101MB2000.eurprd01.prod.exchangelabs.com>,
 <DB6PR0701MB245673214C08183B8E062DDCB5DA0@DB6PR0701MB2456.eurprd07.prod.outlook.com>,
 <VI1PR0101MB20008C1321074C271F56BBA2B8DB0@VI1PR0101MB2000.eurprd01.prod.exchangelabs.com>,
 <DB6PR0701MB2456F0240792DE24F631E5DFB5DB0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
In-Reply-To: <DB6PR0701MB2456F0240792DE24F631E5DFB5DB0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Language: he-IL
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1255"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Toggling GPIO RT Xenomai on Dragonboard 41c
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Is there any other sleep function for real time ?

this sleep is not working well

oscilloscope measured 30ms.

and it is not changing when I change the values.

________________________________
=EE=E0=FA: Giulio Moro <g.moro@qmul.ac.uk>
=FE=FE=F0=F9=EC=E7: =E9=E5=ED =E7=EE=E9=F9=E9 22 =E9=E5=F0=E9 2017 15:30:03
=FE=FE=E0=EC: Elad Yaakovi; xenomai@xenomai.org
=FE=FE=F0=E5=F9=E0: Re: Toggling GPIO RT Xenomai on Dragonboard 41c

> Can you explain please why this is not writing to a file:

Is this related to "Re: Toggling GPIO RT Xenomai on Dragonboard 41c" or sho=
uld it go under a separate heading?

> (without the rt_task_sleep(1000) and the while it works fine).

Many things could be wrong with this.
If `time_to_run` is very small (or zero), then the condition is never met. =
On the other hand , I have no idea what time(NULL) does. Why don't you add =
a `printf()` inside the loop to see if it gets called once at least?
Also, I have no idea why you would try to write one byte to disk every 1 mi=
crosecond and how / whether your system would be capable of dealing with it=
.

Are you using some Xenomai wrappers or is `fprintf` actually calling the st=
dlib `fprintf` ? In the latter case, then I see this code as potentially ha=
nging your system if it actually were to run and `time_to_run` is not small=
 enough.

Just guessing, because we do not see a larger portion of your code.
