Message-ID: <c73373920802150533n4b69c996ief0d542cd760b578@domain.hid>
Date: Fri, 15 Feb 2008 14:33:04 +0100
From: "Salvatore De Astis" <dev.rinux@domain.hid>
In-Reply-To: <2ff1a98a0802150521n1a6688fbm52ecdea910d57702@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5193_27782468.1203082384445"
References: <c73373920802130829r496cfa8au24d6048ae9f50fd3@domain.hid>
	<200802141053.02165.peter.soetens@domain.hid>
	<2ff1a98a0802140233y515a47d8wf8036ff1623311@domain.hid>
	<c73373920802150133h1eae9705qf4ba7bf61ecfcb6d@domain.hid>
	<c73373920802150145g1dccc94ct6bb814150cfc7e4a@domain.hid>
	<2ff1a98a0802150148g6c7f7e78k19a9a2a2b878ef2b@domain.hid>
	<c73373920802150215i7c63f77awe0dca6d8f9a0614e@domain.hid>
	<2ff1a98a0802150218j572f2a2bk6167deb1eb742096@domain.hid>
	<c73373920802150252t4b22000ct2dd5f291f2478a71@domain.hid>
	<2ff1a98a0802150521n1a6688fbm52ecdea910d57702@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_5193_27782468.1203082384445
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Gilles,
but I am new to Xenomai so can you give me more details?

2008/2/15, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>
> On Fri, Feb 15, 2008 at 11:52 AM, Salvatore De Astis
>
> <dev.rinux@domain.hid> wrote:
>
> > The loop which waits for a flag has a collateral effect: if my thread
> block
> > itself in its main routine how can I kill it in asyncronous mode?
>
>
> Another solution would be to use pthread_cancel().
>
> --
>
> Gilles Chanteperdrix
>

------=_Part_5193_27782468.1203082384445
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Gilles,<br>but I am new to Xenomai so can you give me more details?<br><br><div><span class="gmail_quote">2008/2/15, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Fri, Feb 15, 2008 at 11:52 AM, Salvatore De Astis<br> <br>&lt;<a href="mailto:dev.rinux@domain.hid">dev.rinux@domain.hid</a>&gt; wrote:<br> <br>&gt; The loop which waits for a flag has a collateral effect: if my thread block<br>
 &gt; itself in its main routine how can I kill it in asyncronous mode?<br> <br> <br>Another solution would be to use pthread_cancel().<br> <br> --<br> <br> Gilles Chanteperdrix<br> </blockquote></div><br>

------=_Part_5193_27782468.1203082384445--

