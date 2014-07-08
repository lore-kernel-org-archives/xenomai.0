References: <1404677764.4624.YahooMailNeo@web171603.mail.ir2.yahoo.com>
 <53B9BC6A.9070501@xenomai.org>
Message-ID: <1404835832.96010.YahooMailNeo@web171606.mail.ir2.yahoo.com>
Date: Tue, 8 Jul 2014 17:10:32 +0100
From: Matthias Schneider <ma30002000@yahoo.de>
In-Reply-To: <53B9BC6A.9070501@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Issue with cobalt_monitor_wait()
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

----- Original Message -----=0A=0A> From: Philippe Gerum <rpm@xenomai.org>=
=0A> To: Matthias Schneider <ma30002000@yahoo.de>; "xenomai@xenomai.org" <x=
enomai@xenomai.org>=0A> Cc: =0A> Sent: Sunday, July 6, 2014 11:15 PM=0A> Su=
bject: Re: [Xenomai] Issue with cobalt_monitor_wait()=0A> =0A> On 07/06/201=
4 10:16 PM, Matthias Schneider wrote:=0A> =0A> [snip]=0A> =0A>>  On thing I=
 do not understand is:=0A>> =0A>>  in kernel cobalt_monitor_wait(), the syn=
ch object is unlocked via=0A>>  xnsynch_release(). What happens if this syn=
chobj was locked via=0A>>  mon->gate.fastlock ? Shouldnt that also be relea=
sed?=0A>> =0A> =0A> xnsynch_release() handles fastlocks as well.=0A> =0A> =
=0A>>  What other reason could there be if the synch object was released=0A=
>>  via xnsynch_release, xnsynch_acquire was interrupted for=0A>>  xnsynch_=
release to block?=0A>> =0A> =0A> Since the issue seems to be easily reprodu=
cible, could you send a =0A> self-contained piece of code illustrating it?=
=0A> =0A> Also, please mention if you are seeing this issue only when runni=
ng your =0A> app over GDB, or if it currently happens without any debugger =
attached.=0A> =0A> TIA,=0A=0A=0AIt seems I have not described the problemat=
ic scenario completely -=0A=0Athere were two other threads that call called=
 syncobj_lock()=A0=0A/ cobalt_monitor_enter() at about the same time. (Actu=
ally there=0Aare three concurrent on the queue that is being tested, two re=
ceive=0Aoperation and one send operation). I am pretty sure that the issue =
is=0Aextremely timing dependent.=A0=0A=0AAnyway, the testcase would be=A0=
=0A=0Aqueue_test_receive_peek_multiple_tasks()=A0=0A=0Ain=0A=0Afreertos/lib=
/queue-1.c=A0=0A=0AI have=A0already submitted as a patch. In case it helps,=
 I can=0Atry tro reproduce=A0the issue with another queue implementation=A0=
=0A(e.g. psos) and send=A0a short code snippet.=A0=0A=0AMatthias

