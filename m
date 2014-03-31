Message-ID: <533951A9.5060307@xenomai.org>
Date: Mon, 31 Mar 2014 13:29:45 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5338834B.5090604@steinkuehler.net> <53388F8A.6030403@xenomai.org>
 <533894D3.8090803@steinkuehler.net>
In-Reply-To: <533894D3.8090803@steinkuehler.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Dedicated Core?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Charles Steinkuehler <charles@steinkuehler.net>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/31/2014 12:04 AM, Charles Steinkuehler wrote:
> On 3/30/2014 4:41 PM, Gilles Chanteperdrix wrote:
>>
>> First, the imx6 is reported to have high latencies, and it is mostly due
>> to cache effects, so isolating the cpus will not help.
>>
>> Second, I would say relying on low user-space latencies to do in
>> user-space things that the kernel should do is a bad design. You would
>> have better success implementing the step motor control low level
>> details as a kernel driver, and only move the high level stuff in
>> user-space.
> 
> I am not looking to migrate something that should be a kernel service,
> instead I'm trying to replace having dedicated hardware.

Actually, this reminds me of a discussion we had some time ago, about 
generating PWM with omap3. You can find it here:
http://veter-project.blogspot.se/2011/09/real-time-enough-about-pwms-and-shaky.html
http://veter-project.blogspot.se/2012/04/precise-pwms-with-gpio-using-xenomai.html
http://comments.gmane.org/gmane.linux.real-time.xenomai.users/14026

In the end, Andrey succeeded to have precise control by using timers,
in kernel-space, instead of threads in user-space, and a little trick:
waking up early and spinning waiting for the target time.

-- 
                                                                Gilles.

