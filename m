Message-ID: <4EB9C562.9040107@domain.hid>
Date: Wed, 09 Nov 2011 01:12:18 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51962.81.220.196.189.1320786408.squirrel@domain.hid>
In-Reply-To: <51962.81.220.196.189.1320786408.squirrel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.5.6 and Round Robin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: olivier.reynet@domain.hid
Cc: xenomai@xenomai.org

On 11/08/2011 10:06 PM, Olivier Reynet wrote:
> Hi,
> Is it possible to set RR mode with the following functions ??
> rt_task_set_mode(0,T_RRB ,NULL);
> rt_task_slice(task_descr,quantum)
> I have tried with Xenomai 2.5.6, but compiler says that T_RBB is not known.
> Have you got any clue ?

See rt_task_set_mode documentation:
http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__task.html#g915e7edfb0aaddb643794d7abc7093bf

no T_RRB bit.

See also ksrc/skins/native/API.CHANGES in xenomai sources.

-- 
                                                                Gilles.

