MIME-Version: 1.0
Sender: madjsw@domain.hid
Date: Thu, 19 May 2011 13:30:29 -0500
Message-ID: <BANLkTinUMLHw_i23WGmcbBrEJiTREnyY6w@domain.hid>
From: Jeff Weber <jwamsc@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6deddd21f682704a3a533ed
Subject: [Xenomai-help] priority coupling and Linux threads
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0016e6deddd21f682704a3a533ed
Content-Type: text/plain; charset=ISO-8859-1

If XENO_OPT_PRIOCPL is enabled, can a non-Xenomai Linux thread, created
via __real_pthread_create() preempt a Xenomai primary-mode or Xenomai
secondary-mode thread?

For example, when the Linux kernel inherits the priority of a primary-mode
thread to run it in secondary mode, can the kernel then discover some other
Linux thread with better priority and preempt the secondary mode thread?

TIA,
Jeff

--0016e6deddd21f682704a3a533ed
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

If=A0XENO_OPT_PRIOCPL is enabled, can a non-Xenomai Linux thread, created v=
ia=A0__real_pthread_create() preempt a Xenomai primary-mode or Xenomai seco=
ndary-mode thread?<div><br></div><div>For example, when the Linux kernel in=
herits the priority of a primary-mode thread to run it in secondary mode, c=
an the kernel then discover some other Linux thread with better priority an=
d preempt the secondary mode thread?</div>
<div><br></div><div>TIA,</div><div>Jeff</div>

--0016e6deddd21f682704a3a533ed--

