Message-ID: <2ff1a98a0802150253s404753ffr3bf3e12439e400f6@domain.hid>
Date: Fri, 15 Feb 2008 11:53:29 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <c73373920802150252t4b22000ct2dd5f291f2478a71@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <c73373920802130829r496cfa8au24d6048ae9f50fd3@domain.hid>
	<2ff1a98a0802140142o538a956dva8f7d4f34bfbe415@domain.hid>
	<200802141053.02165.peter.soetens@domain.hid>
	<2ff1a98a0802140233y515a47d8wf8036ff1623311@domain.hid>
	<c73373920802150133h1eae9705qf4ba7bf61ecfcb6d@domain.hid>
	<c73373920802150145g1dccc94ct6bb814150cfc7e4a@domain.hid>
	<2ff1a98a0802150148g6c7f7e78k19a9a2a2b878ef2b@domain.hid>
	<c73373920802150215i7c63f77awe0dca6d8f9a0614e@domain.hid>
	<2ff1a98a0802150218j572f2a2bk6167deb1eb742096@domain.hid>
	<c73373920802150252t4b22000ct2dd5f291f2478a71@domain.hid>
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

On Fri, Feb 15, 2008 at 11:52 AM, Salvatore De Astis
<dev.rinux@domain.hid> wrote:
> The loop which waits for a flag has a collateral effect: if my thread block
> itself in its main routine how can I kill it in asyncronous mode?

Use rt_task_unblock/rt_task_resume to unblock it, and check either
-EINTR or the deletion flag when returning from the blocking call.

-- 
 Gilles Chanteperdrix

