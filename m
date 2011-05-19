Message-ID: <4DD562FF.3020909@domain.hid>
Date: Thu, 19 May 2011 20:35:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTinUMLHw_i23WGmcbBrEJiTREnyY6w@domain.hid>
In-Reply-To: <BANLkTinUMLHw_i23WGmcbBrEJiTREnyY6w@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
To: Jeff Weber <jwamsc@domain.hid>
Cc: xenomai@xenomai.org

On 05/19/2011 08:30 PM, Jeff Weber wrote:
> If XENO_OPT_PRIOCPL is enabled, can a non-Xenomai Linux thread, created
> via __real_pthread_create() preempt a Xenomai primary-mode or Xenomai
> secondary-mode thread?

a non-Xenomai Linux thread can preempt a Xenomai thread running in
secondary mode, independently from XENO_OPT_PRIOCPL. It can not preempt
a Xenomai thread running in primary mode, again, independently from
XENO_OPT_PRIOCTL.

What XENO_OPT_PRIOCTL changes, is that a Xenomai thread running in
secondary mode can preempt a Xenomai thread running in primary mode.

> 
> For example, when the Linux kernel inherits the priority of a
> primary-mode thread to run it in secondary mode, can the kernel then
> discover some other Linux thread with better priority and preempt the
> secondary mode thread?

Yes, it can, but as soon as it decides to switch to this thread, the
priority coupling ends, and the system switches to primary mode threads,
if one is runnable.

-- 
                                                                Gilles.

