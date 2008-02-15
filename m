Message-ID: <2ff1a98a0802150537r15d2d1bbx81155d64218c4349@domain.hid>
Date: Fri, 15 Feb 2008 14:37:52 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <c73373920802150533n4b69c996ief0d542cd760b578@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c73373920802130829r496cfa8au24d6048ae9f50fd3@domain.hid>
	<2ff1a98a0802140233y515a47d8wf8036ff1623311@domain.hid>
	<c73373920802150133h1eae9705qf4ba7bf61ecfcb6d@domain.hid>
	<c73373920802150145g1dccc94ct6bb814150cfc7e4a@domain.hid>
	<2ff1a98a0802150148g6c7f7e78k19a9a2a2b878ef2b@domain.hid>
	<c73373920802150215i7c63f77awe0dca6d8f9a0614e@domain.hid>
	<2ff1a98a0802150218j572f2a2bk6167deb1eb742096@domain.hid>
	<c73373920802150252t4b22000ct2dd5f291f2478a71@domain.hid>
	<2ff1a98a0802150521n1a6688fbm52ecdea910d57702@domain.hid>
	<c73373920802150533n4b69c996ief0d542cd760b578@domain.hid>
Subject: Re: [Xenomai-help] Why Xenomai kill my process?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Salvatore De Astis <dev.rinux@domain.hid>
Cc: xenomai@xenomai.org

On Fri, Feb 15, 2008 at 2:33 PM, Salvatore De Astis <dev.rinux@domain.hid> wrote:
> Thanks Gilles,
> but I am new to Xenomai so can you give me more details?

pthread_cancel is not related to Xenomai, it is the posix way of
killing threads while having them execute a custom cleanup routine.

When pthread_cancel is called for a blocked thread, a signal is sent
to the thread which unblocks it to let it execute in LIFO order the
cleanup routines registered with pthread_cleanup_push.

For more details, see the manpages of pthread_cancel,
pthread_cleanup_push, pthread_cleanup_pop.

-- 
 Gilles Chanteperdrix

