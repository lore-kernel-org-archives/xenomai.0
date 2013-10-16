Message-ID: <525E74D8.8060308@xenomai.org>
Date: Wed, 16 Oct 2013 13:13:28 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <525DC044.6090201@steinkuehler.net> <525E6E17.8020103@xenomai.org>
	<525E7433.6070807@steinkuehler.net>
In-Reply-To: <525E7433.6070807@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hung task on Xenomai patched ARM 3.8.13 BeagleBone
 Kernel
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: xenomai@xenomai.org

On 10/16/2013 01:10 PM, Charles Steinkuehler wrote:
> On 10/16/2013 5:44 AM, Gilles Chanteperdrix wrote:
>> It points to several possible problems. So, a question, do you
>> get this while a Xenomai task is running? Or on an otherwise idle
>> system? Second question: is the Linux timer system running
>> correctly, for instance does "sleep 10" sleeps a little bit
>> before returning, or does it fail to return too?
> 
> In the test case, the system is otherwise idle when this happens.
> It is the large amount of "disk" I/O to the SD card that causes the
> mmcqd process to hang.  Also, the grep -r doesn't fail immediately.
> It runs for a while, sometimes getting far enough it finds one or
> two of the four matching files in /usr, then the mmcqd task hangs.
> 
> Other than this occasional glitch, the kernel and system work
> normally. This is the same kernel I am using to run LinuxCNC and
> I've managed to get through many overnight 8+ hour prints, and have
> had uptimes of several weeks.

This proves that Xenomai timer works correctly, not Linux timer. Could
you do the simple "sleep 10" test to verify that Linux timer is
running correctly?

-- 
                                                                Gilles.

