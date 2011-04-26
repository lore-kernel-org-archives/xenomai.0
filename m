Message-ID: <4DB7098C.9050905@domain.hid>
Date: Tue, 26 Apr 2011 20:06:04 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <21817662.201303825804906.JavaMail.SYSTEM@pc-msalvini>
In-Reply-To: <21817662.201303825804906.JavaMail.SYSTEM@pc-msalvini>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_join() call hangs in shared lib
	destructor
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Mauro Salvini <mauro.salvini@domain.hid>
Cc: xenomai@xenomai.org

Mauro Salvini wrote:
> Hi, 
> 
> as from mail subject, I have an issue with rt_task_join() when called into shared object destructor.
> 
> I run xenomai 2.5.5.2 IPipe patch 2.7-4 on x86 2.6.35.7 kernel, Ubuntu Lucid 10.04.1. 

Do you have the same issue with the latest version of the branch you
use? That is 2.5.6?

Has not pthread_join alone the same behaviour?

-- 
                                                                Gilles.

