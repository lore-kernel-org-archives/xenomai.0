Date: Tue, 25 Jan 2011 13:37:14 +0100 (CET)
From: Kolja Waschk <xenoka09@domain.hid>
In-Reply-To: <4D3EB23D.1030500@domain.hid>
Message-ID: <alpine.DEB.1.10.1101251334540.12329@domain.hid>
References: <alpine.DEB.1.10.1101251010320.12329@domain.hid>
	<4D3E97D5.3050609@domain.hid>
	<alpine.DEB.1.10.1101251049460.12329@domain.hid>
	<4D3E9D71.7040008@domain.hid>
	<alpine.DEB.1.10.1101251215520.12329@domain.hid>
	<4D3EB23D.1030500@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: "Kolja Waschk,,," <xenoka09@domain.hid>
Subject: Re: [Xenomai-help] NULL pointer access on bfin when linking with
 xenomai and pthread
Reply-To: xenoka09@domain.hid
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

> Anyway, what you can try to do is to mask the SIGSHADOW signal with
> pthread_sigmask around the call to sigaction, in order to avoid whatever
> race seems to happen with the libpthread library.

You're right: after doing so the problem doesn't occur anymore.

--- xenomai-2.5.5.2/src/skins/common/sigshadow.c.orig	2011-01-25 13:25:01.000000000 +0100
+++ xenomai-2.5.5.2/src/skins/common/sigshadow.c	2011-01-25 13:25:57.000000000 +0100
@@ -62,6 +62,12 @@
  void xeno_sigshadow_install(void)
  {
  	struct sigaction new_sigshadow_action;
+	sigset_t saved_sigset;
+	sigset_t mask_sigset;
+
+	sigemptyset(&mask_sigset);
+	sigaddset(&mask_sigset, SIGSHADOW);
+	pthread_sigmask(SIG_BLOCK, &mask_sigset, &saved_sigset);

  	new_sigshadow_action.sa_flags = SA_SIGINFO | SA_RESTART;
  	new_sigshadow_action.sa_sigaction = xeno_sigshadow_handler;
@@ -71,6 +77,8 @@
  		  &new_sigshadow_action, &xeno_saved_sigshadow_action);
  	if (!(xeno_saved_sigshadow_action.sa_flags & SA_NODEFER))
  		sigaddset(&xeno_saved_sigshadow_action.sa_mask, SIGSHADOW);
+
+	pthread_sigmask(SIG_SETMASK, &saved_sigset, NULL);
  }

  void xeno_sigshadow_install_once(void)






