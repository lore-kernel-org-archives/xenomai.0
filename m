Message-ID: <45F6E98B.4040803@domain.hid>
Date: Tue, 13 Mar 2007 19:12:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] App with pthreads using rt_task_shadow locks up
References: <448721993@domain.hid>
In-Reply-To: <448721993@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jochen Behnke <JK.Behnke@domain.hid>
Cc: xenomai@xenomai.org

Jochen Behnke wrote:
> Hello Gilles,
> 
> thanks for your response. 
> At the moment I try to cut down my application to the minimum.
> I also will install the latest version of the xenomai 2.2.x branch (2.2.5) and check whether I can reproduce the fault.  As I noticed that some functions have been changed (rt_mutex_lock/unlock no longer exist in Xenomai 2.3.x, they obviously have been renamed for some reason) I would rather stick to the 2.2.x branch. Is that reasonable in your opinion ?
> Will the 2.2.x branch be maintained in the future ?
> 
> Thanks again.
> 
> Jochen

Please do not forget to CC the list.

rt_mutex_lock/rt_mutex_unlock were renamed
rt_mutex_acquire/rt_mutex_release to avoid a conflict, as documented in
API.CHANGES

Please try with Xenomai 2.3.0, or better with trunk. The aim of this
check is for us to avoid chasing bugs that were already solved. For
example if you are using fork() in your application, only I-pipe patches
in the trunk will solve your problem.

-- 
                                                 Gilles Chanteperdrix

