Message-ID: <497A1E95.4080805@domain.hid>
Date: Fri, 23 Jan 2009 20:46:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D5908A3@domain.hid>
	<497A1963.8030902@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D5908A4@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D5908A4@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] shadow task and rt_task_self()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> Gilles, the problem is very simple. The initial task has self->opaque
> set to XN_NO_HANDLE. After you shadow that task, rt_task_self() still
> returns NULL.
> 
> This is either an oversight or you aren't supposed to shadow the initial
> task?

Maybe, but please do the work of writing the simplest example. Maybe you
will discover that it is something else in your bigger example that
causes it. And you still did not tell me if this is a trunk issue or a
v2.4.x branch issue.

-- 
					    Gilles.

