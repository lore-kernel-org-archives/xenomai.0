Subject: Re: compile error about TODO after make
References: <MN2PR11MB428569A16DE7BAB22F23FC9EF29A9@MN2PR11MB4285.namprd11.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <44630db5-a750-1d64-af47-af372ccd8e87@siemens.com>
Date: Wed, 17 Nov 2021 09:50:28 +0100
MIME-Version: 1.0
In-Reply-To: <MN2PR11MB428569A16DE7BAB22F23FC9EF29A9@MN2PR11MB4285.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 17.11.21 09:33, Chen, Hongzhan wrote:
> Hi Jan
> 
> Internally , we try to do some basic validation for linux_dovetail branch. One of test is to
> pass build after make allyesconfig. But it would fail because of enabled CONFIG_XENO_TODO. 
> There is still something NTD in  include/cobalt/kernel/dovetail/pipeline/trace.h and 
> include/cobalt/kernel/dovetail/pipeline/clock.h related to this config. I am tying to 
> look into TODO in include/cobalt/kernel/dovetail/pipeline/clock.h but I do not know how to fix
> TODO in include/cobalt/kernel/dovetail/pipeline/trace.h. Could you suggest something about
> fixing them?
> 

Oh, we missed some conversions...

Some of the features in trace.h are unportable because ftrace does not
provide equivalent functionality to the ipipe tracer (namely double
buffering so that you can continue to record in flight-recorder mode
while a previous recording remains available). We should likely return
-ENOSYS then. xntrace_user_stop is widely similar to
xntrace_user_freeze, namely trace_cobalt_trigger("user-freeze"), and
that could be improved.

For 3.3, dropping the related syscall is the better way - unless it
still contains something that ftrace APIs do not provide AND that can be
mapped on a kernel service.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

