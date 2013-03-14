Message-ID: <5141BE16.4080103@siemens.com>
Date: Thu, 14 Mar 2013 13:09:58 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <514092EE.5090406@siemens.com> <5140E735.5050603@xenomai.org>
In-Reply-To: <5140E735.5050603@xenomai.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2013-03-13 21:53, Gilles Chanteperdrix wrote:
> On 03/13/2013 03:53 PM, Jan Kiszka wrote:
> 
>> In case the application already set a SIGDEBUG handler, let that one
>> handle any potential SIGDEBUG_NOMLOCK events and keep our handler
>> (xeno_handle_mlock_alert) out of the loop. This helps in scenarios where
>> skin libraries are loaded belatedly via dlopen.
> 
> 
> Another option would be to save the previous handler, and call it when
> we detect the signal is not due to an mlock alert.

I've no preference. Pushed that variant now into my queue.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

