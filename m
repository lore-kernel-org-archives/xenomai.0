Message-ID: <4355500B.8090800@domain.hid>
Date: Tue, 18 Oct 2005 13:42:03 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] latency_rt: disagrees about version of symbol
	rt_task_wait_period
References: <435543AD.4010807@domain.hid>
	<17237.17732.539752.179481@domain.hid>
In-Reply-To: <17237.17732.539752.179481@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Gilles Chanteperdrix wrote:

>Jim Cromie wrote:
> > 
> > Im having trouble with built/installed xenomai,
> > 
> > soekris:/usr/realtime/2.6.13-ski7-v1# insmod 
> > testsuite/klatency/latency_rt.ko
> > latency_rt: disagrees about version of symbol rt_task_delete
> > latency_rt: Unknown symbol rt_task_delete
> > latency_rt: disagrees about version of symbol rt_task_wait_period
> > latency_rt: Unknown symbol rt_task_wait_period
> > insmod: error inserting 'testsuite/klatency/latency_rt.ko': -1 Unknown 
> > symbol in module
> > 
> > this has been replicated after deleting old tree,
> > and doing a fresh checkout to -r41
>
>Did you delete your source tree too ? I renamed Kbuild files into
>Makefiles this morning, I can not figure how this could break
>compilation though.
>
>  
>
yes, I moved the old xenomai/ directory to another name, then redid
the svn co http:...  invocation to the gna svn repo. (on gna.org pages).

I did reuse my .xeno_config, but that didnt strike me as a particularly
likely reason for the problem.

