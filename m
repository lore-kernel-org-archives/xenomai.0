References: <1399222750.71931.YahooMailNeo@web171601.mail.ir2.yahoo.com>
 <53676902.5050405@xenomai.org> <53679427.90603@xenomai.org> 
Message-ID: <1399360194.79292.YahooMailNeo@web171603.mail.ir2.yahoo.com>
Date: Tue, 6 May 2014 08:09:54 +0100 (BST)
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53679427.90603@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] FreeRTOS skin
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

----- Original Message -----=0A> From: Philippe Gerum <rpm@xenomai.org>=0A>=
 To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <xenom=
ai@xenomai.org>=0A> Cc: =0A> Sent: Monday, May 5, 2014 3:37 PM=0A> Subject:=
 Re: [Xenomai] FreeRTOS skin=0A> =0A> On 05/05/2014 12:33 PM, Philippe Geru=
m wrote:=0A>>=A0 On 05/04/2014 06:59 PM, Matthias Schneider wrote:=0A>>>=A0=
 Hi all,=0A>>> =0A>>>=A0 please find enclosed a patch with a FreeRTOS skin =
for xenomai-forge I=0A>>>=A0 have=0A>>>=A0 been=A0 working on for some time=
. I would like to get some feedback and=0A>>>=A0 advice=0A>>>=A0 what still=
 needs to be done to get it accepted in Xenomai. There is a=0A>>>=A0 set of=
=0A>>>=A0 unit tests included and the possibility to download the original=
=0A>>>=A0 FreeRTOS package=0A>>>=A0 in order to run most of its (platform i=
ndependent) test suite. Until=0A>>>=A0 now I have=0A>>>=A0 been working und=
er mercury only. Documentation is available in form of=0A>>>=A0 a README=0A=
>>>=A0 file in lib/freertos/README, which should also be a good starting =
=0A> point.=0A>> =0A>>=A0 Ok, thanks for this. Let's address issues gradual=
ly, starting with the=0A>>=A0 task module.=0A>> =0A> =0A> In addition to th=
e above, there are a few coding style items:=0A> =0A> - Please always take =
the fastest possible path when exiting on error,=0A> =A0=A0 so that we don'=
t have to cripple the normal processing following the=0A> =A0=A0 failure po=
int with error-specific checks. e.g. what is done with the=0A> =A0=A0 "task=
" variable in vTaskStartScheduler(), within the thread=0A> =A0=A0 cancellat=
ion loop, ends up being convoluted and confusing, compared=0A> =A0=A0 to un=
winding and leaving the routine immediately after the error is=0A> =A0=A0 d=
etected.=0A=0A=0AI will review the code and simplify occurrences of the men=
tioned pattern.=0AHowever I do not see this pattern in this particular code=
 fragment, since it basically does the following:=0A=0A* take the first ent=
ry of the task list=0A* check if the task object can be locked=0A* unlock t=
he scheduler lock=0A* if it was possible to lock the task, cancel it=0A* el=
se wait 1ms and try to lock it again=0A=0ANo error condition leads to leavi=
ng this loop. I do agree however, that the=0Acode is convoluted, mainly due=
 to the erroneous-looking nested locks, one=0Afor protecting freertos_task_=
list and one locking the threadobj. The list should be locked while accessi=
ng it, while holding it when cancelling the threadobj will lead to deadlock=
s (task_finalizer takes freertos_scheduler.lock).=0A=0A=0A> - (void)functio=
n_call() is useless visual pollution and tells nothing=0A> =A0=A0 about the=
 only thing that matters to the reader: were you right in=0A> =A0=A0 omitti=
ng the check? Instead, tagging the called routine with the=0A> =A0=A0 ((war=
n_unused_result)) attribute when problems may likely arise from=0A> =A0=A0 =
not checking the return value, seems a better way to detect=0A> =A0=A0 pote=
ntial bugs at build time, which would cause the (void) cast to=0A> =A0=A0 b=
e ignored when checking the call sites anyway.=0ARemoved the casts.=0A=0A> =
- Prefer C-style comments over C++-style ones.=0AChanged the comments.=0A=
=0A> =0A> =0A> -- =0A> Philippe.=0A>

