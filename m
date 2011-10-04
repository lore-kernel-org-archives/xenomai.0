MIME-Version: 1.0
In-Reply-To: <1317729603.2082.59.camel@domain.hid>
References: <CAAXf6LW-HePfMj4F86s-dFoztWN5NLsGm9TxqpHN-EwxEdtiFA@mail.gmail.com>
	<8236197CA3DA864F9EF20609D988726338B7553A@rrxchngmbx01.mro.roland-man.biz>
	<1317729603.2082.59.camel@domain.hid>
Date: Tue, 4 Oct 2011 23:11:11 +0200
Message-ID: <CAMJ=MEfuYjfYzsoWGL5YXoy4m-GCxd-6KbXj2pSdHxGB-KKh+g@domain.hid>
From: Ronny Meeus <ronny.meeus@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] xenomai-forge [psos] t_start segmentation fault
 when args == NULL
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai-help@domain.hid, dietmar.schindler@domain.hid

On Tue, Oct 4, 2011 at 2:00 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Tue, 2011-10-04 at 10:42 +0000, dietmar.schindler@domain.hid
> wrote:
>> > -----Original Message-----
>> > On Behalf Of Thomas De Schampheleire
>> > Sent: Tuesday, October 04, 2011 11:42 AM
>> > ...
>> > In the xenomai-forge psos library, t_start() does not allow a NULL
>> > args pointer, while I think this is allowed in PSOS.
>>
>> The "pSOSystem System Calls" manual doesn't state the permissibility of =
a NULL args pointer, as far as I can see:
>>
>> unsigned long t_start(
>> =A0 =A0unsigned long tid, =A0 =A0 =A0/* task identifier */
>> =A0 =A0unsigned long mode, =A0 =A0 /* initial task attributes */
>> =A0 =A0void (*start_addr)(), =A0 /* task address */
>> =A0 =A0unsigned long targs[4] =A0/* startup task arguments */
>> =A0 =A0)
>> ...
>> targs =A0 =A0 =A0Specifies four startup values passed to the task (see S=
tartup Values under Target).
>>
>> Target
>> Startup Values
>> ...
>> A new task can receive up to four long words of input arguments. To faci=
litate retrieval of these arguments, they are passed to the task as if it i=
s invoked as a highlevel language procedure or function. For example, if a =
C task nice has three input arguments, it can be declared as follows:
>>
>> nice (unsigned long a, unsigned long b, unsigned long c);
>>
>> where targs[0] is passed to a, targs[1] to b, and targs[2] to c. In this=
 case, targs[3] is irrelevant and does not need the calling task to load it=
.
>>
>
> Accepting NULL was a Xenomai-specific convenience introduced in Xenomai
> 2.x IIRC, then I changed my mind for 3.x. Granted NULL args would not
> work when back on real pSOS, but that does not look like a hot issue. So
> we should probably just accept it anew, and be happy.
>
>> --
>> Regards,
>> Dietmar
>> ________________________________________ manroland AG Vorsitzender des A=
ufsichtsrates: Hanno C. Fiedler Vorstand: Gerd Finkbeiner (Vorsitzender), D=
r. Ingo Koch, Dr. Markus Rall, Paul Steidle Sitz der Gesellschaft: Offenbac=
h am Main, Registergericht: Amtsgericht Offenbach HRB-Nr. 42592 USt-Ident-N=
r. DE 250200933
>>
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>
> --
> Philippe.
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

Hello

I think that it is supported since our application does pass a NULL
pointer as args argument.
The application is originally created in a real pSOS environment 12 years a=
go.

Anyhow thanks for changing it.

Ronny

