Message-ID: <5339B015.3080008@xenomai.org>
Date: Mon, 31 Mar 2014 20:12:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <20140331174555.GO17765@csclub.uwaterloo.ca>
In-Reply-To: <20140331174555.GO17765@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting xenomai 2.6.3 and ipipe to 3.12 kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: xenomai@xenomai.org

On 03/31/2014 07:45 PM, Lennart Sorensen wrote:
> Does anyone have any hints on how to track this down, or even for how
> to properly test that moving to 3.12 is actually working.

On what platform do you get this? If on cortex A8, and the user-space is 
compiled in thumb2 mode, note that an erratum workaround is needed, 
flushing the BTB at each context switch to avoid problem when ARM code 
is replaced by THUMB code at the same (virtual) address when switching 
context.

My advice would be to wait, Philippe is currently merging the I-pipe git 
with 3.14 (you can actually find the 3.12 merge in my git tree, under 
the branch raw/for-ipipe-3.12.0, it has been lightly tested though, as I 
wait for 3.14 to be ready to test more thoroughly).

If you can not wait, then you can enable CONFIG_DEBUG_USER, and pass 
user_debug=29 on the kernel command line, to have a complete a dump upon 
fault (and notably in the case of SIGILL). You can also extend this dump 
by using a hack done in the FCSE patch to print the equivalent of a dump 
of /proc/self/maps with markers indicating where the PC, SP, and fault 
address are when a fault occurs.

-- 
					    Gilles.

