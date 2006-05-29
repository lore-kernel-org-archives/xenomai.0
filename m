From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17530.60656.867991.966403@domain.hid>
Date: Mon, 29 May 2006 14:45:36 +0200
Subject: Re: [Xenomai-help] rt_heap_delete in asynchronous context
In-Reply-To: <1148860914-13365.00015.03228-smmsdV2.1.4@domain.hid>
References: <1148860914-13365.00015.03228-smmsdV2.1.4@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nathaniel.J.Villaume@domain.hid
Cc: xenomai@xenomai.org

Nathaniel J Villaume wrote:
 > Hi, 
 > 
 > I have a simple user-space program (see below) that tries to
 > create a heap. If the heap already exists, then the program tries
 > to delete it. I have no other threads binding to the heap.
 > 
 > I can create, but not delete the heap. The error returned is
 > -EPERM. According to the API manual, this means the call occurred
 > in an asynchronous context. What does this mean, exactly? How
 > should I delete this heap? 
 > 
 > Any advice?

You should not try and delete a heap if you did not succeed in creating
or binding it. The contents of the RT_HEAP object are uninitialized
when rt_heap_create fails, rt_heap_delete call munmap passing the
contents of this uninitialized object, and munmap returns -1 with errno
set to EINVAL. rt_heap_delete should be fixed to return -errno in this
case, but you should bind the heap before deleting it.

-- 


					    Gilles Chanteperdrix.

