From: Paul <paul_c@domain.hid>
Date: Tue, 27 Jan 2009 20:06:06 +0000
References: <497F6524.2080601@domain.hid>
In-Reply-To: <497F6524.2080601@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200901272006.06314.paul_c@domain.hid>
Subject: Re: [Xenomai-core] [RFC] FPU support
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


Hi Giles

On Tuesday 27 January 2009, Gilles Chanteperdrix wrote:
> So, the question is: are there people around who either:
> - need FPU support for kernel-space real-time threads;
> - do not want to pay the price of a trap when using the FPU in user-space.

One application that I work on uses floating point math in kernel space, but 
it is a constant source of problems - Being forced to migrate to user space 
would be a welcome move.. The only question is how much of an overhead does 
the trap incur ?


Regards, Paul.

