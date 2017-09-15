References: <CAFUnMk=pm2=D5R2maPW-PHTzqFU1H+CWQbY_3ibbS3Bu6PTEdQ@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a59d97c3-c9b7-189a-fa9b-28951dcd2645@xenomai.org>
Date: Fri, 15 Sep 2017 16:49:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAFUnMk=pm2=D5R2maPW-PHTzqFU1H+CWQbY_3ibbS3Bu6PTEdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] xenomai 3.02 hangs in raspberry pi 3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ashok kumar <ashokkumar.bb@gmail.com>, xenomai@xenomai.org

On 09/15/2017 02:08 PM, Ashok kumar wrote:
> Hi,
> 
> I am xenomai 3.0.2 in raspberry pi 3 quad core after starting Real
> time tast the Raspberry pi freezes.
> 
> Can i use Rtprintf in xenomai 3, any api is there to use the printf
> function in xenomai 3.

A rt task managed by the Cobalt co-kernel that runs indefinitely without
suspending/blocking/sleeping in any way will cause your system to
freeze, with the regular Linux kernel starving from CPU time. This is
what you need to check first by code inspection. You can't rely on any
printf service to figure this out, since by definition, the output won't
reach the display because the regular kernel won't be able to deal with it.

Make sure to have CONFIG_XENO_OPT_WATCHDOG enabled, this may help to
detect such kind of rt-induced lockup issues.

printf() requests over the POSIX API in v3 are implicitly routed to the
legacy rt_printf() call. This still requires the rt task not to starve
the Linux kernel though.

-- 
Philippe.

