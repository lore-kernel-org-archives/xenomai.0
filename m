Message-ID: <4E3FEF3E.4080803@domain.hid>
Date: Mon, 08 Aug 2011 16:14:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAL+uwv-ccr22BOBTkVUstxxbi7qZjhUQ5062EKYaVVV3yqxkQQ@mail.gmail.com>
In-Reply-To: <CAL+uwv-ccr22BOBTkVUstxxbi7qZjhUQ5062EKYaVVV3yqxkQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Regarding timer services.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: suresh reddy <sureshreddy.balijepalli@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

On 08/08/2011 02:55 PM, suresh reddy wrote:
> Dear all,
> 
> Iam using native skin of xenomai . Iam trying to test some of the services
> of xenomai native skin with my Hardware (pandaboard).
> 
> i have two threads namely t1 and t2 .
> 
> 1. t1 sends a message to t2 using messeage que
> 
> 2. t2 receives message and runs it executions .
> 
> 3. t2 executing is completed it sends a message to t1 that iam completed.
> 
> 4. t1 receives message .
> 
> i would like know the time taken between t1 sends and t1 receives message.
> 
> For this test do i need to synchronise the xenomai timer with my hardware
> timer
> 
> or is it otherway around?

You can use rt_timer_tsc. For a documentation of the native API, see:
http://www.xenomai.org/documentation/xenomai-2.5/html/api/group__native.html
-- 
					    Gilles.

