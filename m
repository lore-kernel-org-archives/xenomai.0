Message-ID: <2ff1a98a0802220308k5aa66dddi95aad51b8d6178d2@domain.hid>
Date: Fri, 22 Feb 2008 12:08:55 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <OFBA487F20.21A14F15-ONC12573F7.00329129-C12573F7.00329C76@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <OFBA487F20.21A14F15-ONC12573F7.00329129-C12573F7.00329C76@domain.hid>
Subject: Re: [Xenomai-help] Advice needed: Xenomai / USB access from kernel
	task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "G.P.M. Haagh" <g.p.m.haagh@domain.hid>
Cc: xenomai@xenomai.org

On Fri, Feb 22, 2008 at 10:13 AM, G.P.M. Haagh <g.p.m.haagh@domain.hid> wrote:
>
>
> One of our trainees has written a LKM that accesses the standard Linux
> kernel's usb_core facilities from a Xenomai real-time thread running in
> kernel space.
>  I am doing some follow up on his work and run into problems.
>  I would appreciate some help/advise.
>
>  1)
>  The main question to start with: is it Ok to submit urbs to usb_core
> (usb_submit_urb) from a Xenomai kernel task (task created in a LKM) ?

Without looking at the function implementation, it is hard to answer.
The short answer to this question is "no". In general, it ils not
possible to call regular Linux services from a Xenomai task. Now, it
may happen that it is possible, if the said service does not rely on
any Linux services such as spinlocks, mutex, etc...

Note that there is an USB stack for Xenomai, so, using this stack
could be a better solution:
http://developer.berlios.de/projects/usb4rt

-- 
                                               Gilles Chanteperdrix

