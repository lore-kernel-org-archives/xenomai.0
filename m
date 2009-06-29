Message-ID: <4A48D072.5040400@domain.hid>
Date: Mon, 29 Jun 2009 16:32:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <065A7D06F7D4E546A18E80E08D066E181189FBBDD9@domain.hid>
In-Reply-To: <065A7D06F7D4E546A18E80E08D066E181189FBBDD9@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] pthread_mutex_lock returns 1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Landau, Bracha" <BLandau@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Landau, Bracha wrote:
> I have a xenomai-based application basically working on my mpc8272 based
> board. pthread_mutex_lock generally works (and returns zero), but in
> some cases returns 1 (yes, positive, not negative) which is an unknown
> error.
> Any idea why this may be happening?

1 is not an unknown error, it is EPERM. And the POSIX spec mandates that
errors returned by pthread_* services are the error status. They are not
stored in errno. This is even documented in Xenomai pthread_mutex_lock
documentation:

Returns:
    0 on success

    an error number if:

        * EPERM, the caller context is invalid;
	(...)
        * EPERM, the mutex is not process-shared and does not belong to
the current process;

(...)
Valid contexts:

        * Xenomai kernel-space thread;
        * Xenomai user-space thread (switches to primary mode).

I use the following script to convert back and forth between libc errors
and their value:

#! /bin/sh

sed  "s,#define\t\(.*\b$1\b.*\)/\*\(.*\)\*/,\1\2,;t;d" /usr/include/asm*/errno*



> ------------------------------------------------------------------------
> This e-mail is confidential, the property of NDS Ltd and intended for
> the addressee only. Any dissemination, copying or distribution of this
> message or any attachments by anyone other than the intended recipient
> is strictly prohibited.

If this message is confidential, why do you send it to a public mailing
list in the first place? Should we unsubscribe you from the mailing list
to preserve your confidentiality?

-- 
                                          Gilles


