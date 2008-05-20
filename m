MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18482.30269.908779.122750@domain.hid>
Date: Tue, 20 May 2008 08:57:01 +0200
In-Reply-To: <a42b680918d4f3fc74642083e5fbf192@domain.hid>
References: <728e254ea628725216c983d66e391cb5@domain.hid>
	<a42b680918d4f3fc74642083e5fbf192@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] VxWorks mode switching signal SIGXCPU and switch
 operation
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

Matthieu wrote:
 > I found out that it is possible to mix API since SIGXCPU signal, sent when
 > swiching in secondary mode, is obviously only used by Xenomai Native
 > API.

Ok. But you could implement taskOptionsGet/taskOptionsSet to allow
setting a VX_WARNSW option bit, and even setting it in
taskInit/taskSpawn.

 > Well, I tried to implement it in a vxworks context, but I don't have test
 > it yet. I have some problems remaining with rt_task_set_mode(0, T_WARNSW,
 > NULL) that I don't know where to use.
 > Do you have any solution ?

Well, in a usual application only some tasks are really critical, and
only these deserve the T_WARNSW bit. So, yes, you have to know what
tasks are really critical, only set the T_WARNSW bit for these and use
it to remove any switch to secondary mode.

-- 


					    Gilles.

