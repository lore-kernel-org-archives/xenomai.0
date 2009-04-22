Message-ID: <49EEE9F1.2000204@domain.hid>
Date: Wed, 22 Apr 2009 11:57:05 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <49EEE65E.6060308@domain.hid>
In-Reply-To: <49EEE65E.6060308@domain.hid>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem with mutexes in daemon
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roman Pisl <rpisl@domain.hid>
Cc: xenomai@xenomai.org

Roman Pisl wrote:
> Hello,
> I'm experiencing weird behavior with mutexes in a daemon application. 
> After daemon() is called, unnamed mutexes fail on call 
> rt_mutex_release() with -EPERM. Everything is ok for named mutexes.
> 
> Is there something special with daemon and unnamed mutexes - should all 
> have name? Or is it a bug? I'm using kernel 2.6.28 and Xenomai 2.4.6.1.
> 
> Example showing this problem is attached.

Unnamed mutexes are local to a process. Since forking results in a
different process, mutexes are not preserved.

Yes, Xenomai behaviour is not intuitive, but fixing this requires
internal changes.

-- 
                                                 Gilles.

