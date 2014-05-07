Message-ID: <DUB121-W500004F6EF131A61A88C03814E0@phx.gbl>
From: mobin Motallebizadeh <mobin.seven@live.com>
Date: Wed, 7 May 2014 11:07:57 +0000
In-Reply-To: <53676B5B.3020409@xenomai.org>
References: <DUB121-W7067785C23E81792E6879816E0@phx.gbl>,
 <533FED48.6000409@xenomai.org>, <DUB121-W25E81E35147A9FAF3D07D81690@phx.gbl>
 <DUB121-W28D0B56879463825E4F1B281690@phx.gbl>,<53418206.1040601@xenomai.org>
 <DUB121-W24F26324C941C6D102E58A814C0@phx.gbl>,<53676B5B.3020409@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] problem with Task management services: Synchronous
 message passing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>



> Date: Mon, 5 May 2014 12:43:39 +0200
> From: gilles.chanteperdrix@xenomai.org
> To: mobin.seven@live.com; xenomai@xenomai.org
> Subject: Re: [Xenomai] problem with Task management services: Synchronous=
 message passing
> =

> On 05/05/2014 11:01 AM, mobin Motallebizadeh wrote:
> > =

> > =

> >> Date: Sun, 6 Apr 2014 18:34:14 +0200
> >> From: gilles.chanteperdrix@xenomai.org
> >> To: mobin.seven@live.com
> >> CC: xenomai@xenomai.org
> >> Subject: Re: [Xenomai] problem with Task management services: Synchron=
ous message passing
> >>
> >> On 04/06/2014 06:19 PM, mobin Motallebizadeh wrote:
> >>> I dont know what to do with kernel console.please explain more.
> >>> I'm running a x86_64 mint Linux pc (core i7)
> >>
> >> Send us to us what the kernel console tell you... we can not guess what
> >> the issue is if you do not send us information about it.
> >>
> >> Also, the xenomai mailing list is an old fashioned mailing list where =
we
> >> do not top post. So please, no top posting.
> >>
> >> -- =

> >>                                                                 Gilles.
> > =

> > The attachment is the log from netconsole.Thanks in advance
> =

> The error is on the first line of the logs:
> =

> [  111.023581] Watchdog detected hard LOCKUP on cpu 0
> [  128.060170] BUG: soft lockup - CPU#1 stuck for 23s! [satch:2028]
> =

> Your program has spinned 23s without relinquishing cpu.
> =

> =

> -- =

>                                                                 Gilles.

I changed the code with bounding  tasks running time with TIMEOUT. this tim=
e log says its a bug at task.c . why this is happening? is it a real bug? 	=
	 	   		  =

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: netconsole-log2.txt
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140507/c77ea6b=
f/attachment.txt>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: satch.c.txt
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140507/c77ea6b=
f/attachment-0001.txt>
