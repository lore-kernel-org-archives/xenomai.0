From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17528.17846.771613.406263@domain.hid>
Date: Sat, 27 May 2006 14:27:34 +0200
Subject: Re: [Xenomai-help] Best way to identify a Xenomai task
In-Reply-To: <44781751.30705@domain.hid>
References: <44781751.30705@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jean-olivier.villemure@domain.hid
Cc: xenomai@xenomai.org

Jean-Olivier Villemure wrote:
 > Hi,
 > 
 > I'm looking for the best to identify a Xenomai Task.
 > 
 > We are running multiple task inside kernel space and I need to identify
 > each of these task. Is there a sort of TaskID ? Otherwise I could look
 > at the address of the thread associated to one task, but is there a
 > better way?

It depends on the skin you are using,
- for posix skin, it is pthread_self()
- for native skin, it is rt_task_self()
- for vxworks skin, it is taskIdSelf()

The task Id of a new task is also returned by the task creation
services:
- pthread_create for the posix skin,
- rt_task_create for the native skin,
- taskSpawn for the vxworks skin.
When using taskInit with the vxworks skin, the task ID is the address of
the tcb passed as first argument.

-- 


					    Gilles Chanteperdrix.

