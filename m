References: <58a70af0.cf0d1c0a.74142.a8ca@mx.google.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <06614ad5-4dd0-45f2-2281-054b3e5621c9@xenomai.org>
Date: Fri, 17 Feb 2017 16:24:05 +0100
MIME-Version: 1.0
In-Reply-To: <58a70af0.cf0d1c0a.74142.a8ca@mx.google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Set CPU Clock Frequency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mobin.motallebizadeh@gmail.com, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 02/17/2017 03:38 PM, mobin.motallebizadeh@gmail.com wrote:
> Hi
> As we are disabling CPU_FREQ system consumes as much energy as it can and it’s undesirable.
> 
> Is there any method to set cpu clock freq to something other than 100%?
> 
> Something like letting CPU_FREQ=y and setting clock freq manually by cpufreq utility and then re-calibrate the cobalt core. I don’t know. Just guessing!

There is no provision for this.

-- 
Philippe.

