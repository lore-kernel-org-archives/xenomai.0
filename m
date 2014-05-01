References: <1398502711.53016.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <535B8B43.1000109@xenomai.org> <535BDB20.7070100@xenomai.org>
 <1398944980.54240.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <5362437D.2030802@xenomai.org> <53624587.40005@xenomai.org>
Message-ID: <1398954520.83749.YahooMailNeo@web171601.mail.ir2.yahoo.com>
Date: Thu, 1 May 2014 15:28:40 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53624587.40005@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Issue in notifier_callback while threadobj_lock is
	being held (forge/mercury)
Reply-To: Matthias Schneider <ma30002000@yahoo.de>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

=0A=0A=0A=0A----- Original Message -----=0A> From: Philippe Gerum <rpm@xeno=
mai.org>=0A> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai=
.org" <xenomai@xenomai.org>=0A> Cc: =0A> Sent: Thursday, May 1, 2014 3:00 P=
M=0A> Subject: Re: [Xenomai] Issue in notifier_callback while threadobj_loc=
k is being held (forge/mercury)=0A> =0A> On 05/01/2014 02:52 PM, Philippe G=
erum wrote:=0A>>  On 05/01/2014 01:49 PM, Matthias Schneider wrote:=0A>> =
=0A>>>  On a first glance the commit seems to work find - I am still verify=
ing.=0A>>>  Simplifying the suspend handling, would sending a SIGNOTIFY sig=
nal=0A>>>  straight=0A>>>  to the signal handler instead of using pipe read=
/write operations be an=0A>>>  equivalent, even simpler alternative as demo=
nstrated in the attached=0A>>>  patch?=0A>>> =0A>> =0A>>  IIRC, the reason =
to base the logic on fasync handling was primarily to=0A>>  allow for exten=
ding the scheme to multi-processing setups (copperplate=0A>>  provides mech=
anisms for sharing most of its core objects between=0A>>  processes). Typic=
ally, using an AF_UNIX named socket instead of an=0A>>  anonymous pipe woul=
d have made possible to notify threads which belong=0A>>  to different proc=
esses the same way.=0A> =0A> Plus: passing parameters to the notification m=
essages, which we would =0A> not be able to do using plain signaling. There=
 are a few inter-process =0A> requests we still need to implement via the n=
otification system. Once =0A> they are more specifically framed and scoped,=
 we may get back to this =0A> optimization. Maybe we could use a mixed appr=
oach as well.=0A> =0A> =0A> -- =0A> Philippe.=0A> =0AConsidering it a gener=
ic notification mechanism, fasync also allows queueing=0Amultiple notificat=
ion messages, which are then executed consecutively in=0Athe corresponding=
=A0thread's "for (;;)" loop.=0A=0AMy suggestion however was based on the as=
sumption that the notifier-framework=0Awas solely used for suspending threa=
ds - so I agree on revising it once other=0Ausages of the mechanism are bet=
ter defined.

