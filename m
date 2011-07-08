Message-ID: <4E16EFB5.4000700@domain.hid>
Date: Fri, 08 Jul 2011 13:53:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BE293433-495B-4C50-999A-298131FA6D94@domain.hid>
In-Reply-To: <BE293433-495B-4C50-999A-298131FA6D94@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Anti-memory-fragmentation tricks for my Xenomai
 process?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeremy Friesner <jaf@domain.hid>
Cc: xenomai@xenomai.org

On 07/08/2011 07:48 AM, Jeremy Friesner wrote:
> This all works well, but there is one minor issue where I'd like to
> improve things:  after running for a while, the allocation and
> deallocation of 128kB buffers, interspersed with smaller
> allocations/deallocations, causes fragmentation in the process's
> heap, with the end result that the process appears to be using a lot
> more memory than it actually has allocated.  This doesn't cause real
> problems (AFAICT), but because the GUI for the system has a RAM Usage
> Indicator (that gets its info from /proc/meminfo, and displays total
> memory-usage as a percentage of physical RAM), users are prone to
> wonder why so much RAM is being used even when the program is idle.
> The heap fragmentation makes it look like there is a memory leak,
> even when there technically isn't.

The size allocated by a process is more accurately measured with
/proc/self/maps or /proc/self/smaps than with /proc/meminfo. For the
128k buffers, you can mmap/munmap anonymous memory, this way, you will
only consume what you use. Malloc also has a threshold above which it
uses mmap, maybe you can change that threshold to be 128KiB (I think it
is 4MiB by default). See mallopt documentation.

-- 
					    Gilles.

