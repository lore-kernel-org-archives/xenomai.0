Date: Wed, 4 Mar 2015 22:56:11 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150304215611.GI30672@hermes.click-hack.org>
References: <CA+C+_XTfx6fAC3UvATJULBqogpvAOozwNkop=6Vj+jPYondj9Q@mail.gmail.com>
 <20150304174252.GF30672@hermes.click-hack.org>
 <666349AB-944C-4C85-83DE-C37BB9231AB1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <666349AB-944C-4C85-83DE-C37BB9231AB1@gmail.com>
Subject: Re: [Xenomai] Debugger and secondary mode question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mathew Benson <mathew.benson@gmail.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Wed, Mar 04, 2015 at 03:45:09PM -0600, Mathew Benson wrote:
> I'll test it again shortly.  
> 
> What happens when a thread depletes a semaphore or takes a mutex,
> then transitions to secondary mode? Does the semaphore or mutex
> automatically get given back or does the thread keep it for when
> it transitions back to primary mode?

A semaphore has no notion of ownership, so when the counter is 0, it
is impossible to say who should increment it. When not using a
semaphore has a mutex, the one who increments the semaphore may not
be the same as the one who decrements it. And there is little reason
to use semaphores as mutex, because mutex are more convenient for
that.

-- 
					    Gilles.

