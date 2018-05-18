References: <C2EC5BA46D13CD44B5915A8FEEB4C44E9BF9E3A2@DDCEXCH.ddc-ny.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <861bc047-1591-c3f4-f282-de772b686517@xenomai.org>
Date: Fri, 18 May 2018 09:04:53 +0200
MIME-Version: 1.0
In-Reply-To: <C2EC5BA46D13CD44B5915A8FEEB4C44E9BF9E3A2@DDCEXCH.ddc-ny.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] 2 potential udd drivers fixes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Pham, Phong" <phamp@ddc-web.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "Hillman, Robert" <hillman@ddc-web.com>

On 05/18/2018 05:34 AM, Pham, Phong wrote:
> 
> Hi,
> 
> Currently, a user space driver write() API does not clear the number of interrupts occurred since the last read() API.  Instead it disable interrupt unless a UDD_RTIOC_IRQEN request comes in to enable interrupt.  The fact that ioctl() does support these requests makes write(UDD_RTIOC_IRQEN/anything) a redundant and inappropriate API.  Code change is to set both event  count and context->event_count to 0.
> 
> The second issue is the event ur->pulse needs to be cleared in udd_read_rt() because a select() on the file descriptor will return immediately as a result of a previous select() call when both select() invocation is on the same file descriptor even when the read() is sandwiched in between the select() calls while no interrupt occurs for the second select() call.
> 
> Below are the suggested code fixes for both issues.  I am using 4.9.51 Linux kernel with patch: ipipe-core-4.9.51-powerpc-3.
> 

Please send separate patches implementing the changes, not the whole
file. The latter is unpractical for the reviewing process.

-- 
Philippe.

