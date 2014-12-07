From: "Stoidner, Christoph" <c.stoidner@arvero.de>
Date: Sun, 7 Dec 2014 12:32:56 +0000
Message-ID: <b48811ec5d1e4133b62f60c636fe2785@EX132MBOX1A.de2.local>
References: <471986235a5c47e395ece6b3d18830bd@EX132MBOX1A.de2.local>,
 <20141206142512.GI10014@hermes.click-hack.org>,
 <d1ac795e0c594d279d5c1c9d12cbe90a@EX132MBOX1A.de2.local>
In-Reply-To: <d1ac795e0c594d279d5c1c9d12cbe90a@EX132MBOX1A.de2.local>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Sleeping function called from invalid context
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=
=0A=
>> If you have lockdep enabled, you should disable it, as it currently=0A=
>> does not work with xenomai on arm.=0A=
=0A=
> lockdep is disabled in my kernel config.=0A=
=0A=
>From my understanding the output=0A=
=0A=
[   33.187125] in_atomic(): 1, irqs_disabled(): 128, pid: 87, name: =0A=
[   33.187138] 1 lock held by /87:=0A=
=0A=
tells that preemt_count was unequal to zero and IRQ's were disabled. In tha=
t case sleeping would not be allowed. Am I right here?=0A=
=0A=
That bug detection is enabled by kernel config DEBUG_ATOMIC_SLEEP. Do you t=
hink that debug config has same problem as lockdep and the detected bug is =
not really a bug?=0A=
=0A=
Actually I am searching for a bug that crashs my application program after =
some hours and leading to complete system-freeze. Unfortunately no message =
does appear when the crash happens. That's the reason why I am using the de=
bug config from above. Do you think these problems could be concerned. Our =
do you have some other idea how to figure out what's happening there?=0A=
=0A=
Regards and thanks in advance,=0A=
Christoph =0A=

