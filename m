From: Jeff Weber <jweber@domain.hid>
Subject: Re: [Xenomai-help] enable/disable all interrupts from user space
Date: Fri, 27 Oct 2006 11:08:14 -0500
References: <45420A72.8000700@domain.hid>
In-Reply-To: <45420A72.8000700@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200610271108.14937.jweber@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai Help <xenomai@xenomai.org>

Thanks Jan.

Another thought: is there a direct Adeos =A0call to enable/disable all=20
interrupts, with nesting from user space?

I'm porting some legacy RTAI code to the Xenomai native skin. =A0The RTAI c=
ode=20
has rtai_save_flags_and_cli()/rtai_restore_flags() for enabling/disabling a=
ll=20
interrupts =A0direct from user space, with capability to handle nested call=
s. =A0

Yes, please add this to the native skin "wish list", along with a nesting=20
capability.

=A0=A0=A0=A0=A0=A0=A0=A0thanks,
=A0=A0=A0=A0=A0=A0=A0=A0Jeff

On Friday 27 October 2006 08:32, Jan Kiszka wrote:
> Jeff Weber wrote:
> > How do I enable/disable all interrupts (Linux and Xenomai) from user
>
> space?
>
> > (native skin preferred)
>
> For x86:
>
> iopl(3);
> __asm__ __volatile__("cli/sti");
>
> Ugly hack, typical a sign that something should be moved somewhere
> else... (there are a few exceptions, though)

=2D-=20
Jeff Weber
American Superconductor Corp.

