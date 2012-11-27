Message-ID: <50B4C422.6050709@xenomai.org>
Date: Tue, 27 Nov 2012 14:46:10 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <50AE49ED.9020804@ruggedcom.com> <50AE4F97.8030102@xenomai.org>
	<990B36E792F1A4488D3E2B1C46FD62D69A13775FD4@corpmail2>
	<50AF5ADF.4090502@siemens.com>
In-Reply-To: <50AF5ADF.4090502@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Mutex enhancement for Auto relaxed threads
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/23/2012 12:15 PM, Jan Kiszka wrote:
> On 2012-11-22 17:55, Michael Pustylnik wrote:
>> Although you can use mutexes in this order, why would you want to do that? Logically, unlocking mutex1 would mean finishing some operation started when mutex1 was locked. If as a part of the operation you locked mutex2 and haven't unlocked it yet, that would mean you haven't completed your operation yet, and unlocking mutex1 at this point would probably be a bug. Am I wrong?
> 
> I'm not aware that POSIX or some other APIs Xenomai implements forbid
> such an ordering. And you never know if there is weird convoluted legacy
> code out there that depends on exactly this.
> 
> However, I think you can avoid the limitation by attaching the property
> "trap to kernel on mutex lock" to the thread instead of some mutex,
> analogously to xeno_current_mode.

I think the simplest solution to implement this is to share the
resources count between user and kernel, using a pthread_key in
user-space. However, I really do not see how to do this without breaking
the ABI, so, this really is material for xenomai-forge, not for 2.6.

-- 
					    Gilles.

