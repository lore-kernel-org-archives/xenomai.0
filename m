MIME-Version: 1.0
In-Reply-To: <4DD562FF.3020909@domain.hid>
References: <BANLkTinUMLHw_i23WGmcbBrEJiTREnyY6w@domain.hid>
	<4DD562FF.3020909@domain.hid>
Date: Fri, 20 May 2011 08:40:09 +0200
Message-ID: <BANLkTikjgb+rrbDNvDT=8L6n4hj0RjNzpA@mail.gmail.com>
From: Henri Roosen <henriroosen@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] priority coupling and Linux threads
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On Thu, May 19, 2011 at 8:35 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 05/19/2011 08:30 PM, Jeff Weber wrote:
>> If XENO_OPT_PRIOCPL is enabled, can a non-Xenomai Linux thread, created
>> via __real_pthread_create() preempt a Xenomai primary-mode or Xenomai
>> secondary-mode thread?
>
> a non-Xenomai Linux thread can preempt a Xenomai thread running in
> secondary mode, independently from XENO_OPT_PRIOCPL. It can not preempt
> a Xenomai thread running in primary mode, again, independently from
> XENO_OPT_PRIOCTL.
>
> What XENO_OPT_PRIOCTL changes, is that a Xenomai thread running in
> secondary mode can preempt a Xenomai thread running in primary mode.
>
>>
>> For example, when the Linux kernel inherits the priority of a
>> primary-mode thread to run it in secondary mode, can the kernel then
>> discover some other Linux thread with better priority and preempt the
>> secondary mode thread?
>
> Yes, it can, but as soon as it decides to switch to this thread, the
> priority coupling ends, and the system switches to primary mode threads,
> if one is runnable.

Be careful to rely on priority coupling though, it cannot always
guarantee the scheduling it specifies. Be sure to read
https://mail.gna.org/public/xenomai-help/2011-03/msg00165.html

>
> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

