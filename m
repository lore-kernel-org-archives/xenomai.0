From: <dietmar.schindler@domain.hid>
Date: Tue, 4 Oct 2011 10:42:00 +0000
Message-ID: <8236197CA3DA864F9EF20609D988726338B7553A@rrxchngmbx01.mro.roland-man.biz>
References: <CAAXf6LW-HePfMj4F86s-dFoztWN5NLsGm9TxqpHN-EwxEdtiFA@mail.gmail.com>
In-Reply-To: <CAAXf6LW-HePfMj4F86s-dFoztWN5NLsGm9TxqpHN-EwxEdtiFA@mail.gmail.com>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] xenomai-forge [psos] t_start segmentation fault
 when	args == NULL
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai-help@domain.hid

> -----Original Message-----
> On Behalf Of Thomas De Schampheleire
> Sent: Tuesday, October 04, 2011 11:42 AM
> ...
> In the xenomai-forge psos library, t_start() does not allow a NULL
> args pointer, while I think this is allowed in PSOS.

The "pSOSystem System Calls" manual doesn't state the permissibility of a N=
ULL args pointer, as far as I can see:

unsigned long t_start(
   unsigned long tid,      /* task identifier */
   unsigned long mode,     /* initial task attributes */
   void (*start_addr)(),   /* task address */
   unsigned long targs[4]  /* startup task arguments */
   )
...
targs      Specifies four startup values passed to the task (see Startup Va=
lues under Target).

Target
Startup Values
...
A new task can receive up to four long words of input arguments. To facilit=
ate retrieval of these arguments, they are passed to the task as if it is i=
nvoked as a highlevel language procedure or function. For example, if a C t=
ask nice has three input arguments, it can be declared as follows:

nice (unsigned long a, unsigned long b, unsigned long c);

where targs[0] is passed to a, targs[1] to b, and targs[2] to c. In this ca=
se, targs[3] is irrelevant and does not need the calling task to load it.

--
Regards,
Dietmar
________________________________________ manroland AG Vorsitzender des Aufs=
ichtsrates: Hanno C. Fiedler Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. =
Ingo Koch, Dr. Markus Rall, Paul Steidle Sitz der Gesellschaft: Offenbach a=
m Main, Registergericht: Amtsgericht Offenbach HRB-Nr. 42592 USt-Ident-Nr. =
DE 250200933


