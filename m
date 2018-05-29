References: <9c717071-fc03-1ba8-f6ff-9d6f131bd52d@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <a57cb350-387e-fa0b-aad0-94f925a1f54a@xenomai.org>
Date: Tue, 29 May 2018 09:31:27 +0200
MIME-Version: 1.0
In-Reply-To: <9c717071-fc03-1ba8-f6ff-9d6f131bd52d@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] syncobj_wait_grant vs. signals
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <xenomai@xenomai.org>

On 05/28/2018 08:51 PM, Jan Kiszka wrote:
> Hi Philippe,
> 
> struggling with an internal implementation on top of copperplate's
> syncobj_wait_grant, I was wondering if that function is supposed to
> return -EINTR on signal interruptions. It's mercury variant will not
> because it used pthread_cond_wait internally. The cobalt version does,
> and now I need to decide where to handle that best.
> 

The only requirement is to have EINTR honored by wait_grant/wait_drain
calls upon syncobj_flush().

The reason the Cobalt side returns EINTR also on Linux signals is due to
cobalt_monitor_wait() not implementing the prologue/epilogue functional
split pthread_cond_wait() exhibits, which allows to filter out EINTR in
order to match the POSIX spec.

-- 
Philippe.

