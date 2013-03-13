Message-ID: <5140E735.5050603@xenomai.org>
Date: Wed, 13 Mar 2013 21:53:09 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <514092EE.5090406@siemens.com>
In-Reply-To: <514092EE.5090406@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] Do not overwrite pre-existing SIGDEBUG
 handler in	xeno_skin_bind
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 03/13/2013 03:53 PM, Jan Kiszka wrote:

> In case the application already set a SIGDEBUG handler, let that one
> handle any potential SIGDEBUG_NOMLOCK events and keep our handler
> (xeno_handle_mlock_alert) out of the loop. This helps in scenarios where
> skin libraries are loaded belatedly via dlopen.


Another option would be to save the previous handler, and call it when
we detect the signal is not due to an mlock alert.

-- 
                                                                Gilles.

