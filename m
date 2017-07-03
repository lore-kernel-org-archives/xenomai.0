References: <dff5d476-55b9-f609-ec06-07a3f3c88958@inova.cz>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <14ad8a81-a441-30d8-b158-9c6bb6205efd@xenomai.org>
Date: Mon, 3 Jul 2017 15:52:20 +0200
MIME-Version: 1.0
In-Reply-To: <dff5d476-55b9-f609-ec06-07a3f3c88958@inova.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] High latencies with RT memory heap on xenomai 2.6.5
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?SmnFmcOtIER1xaFlaw==?= <dusek@inova.cz>, xenomai@xenomai.org

On 07/03/2017 03:21 PM, Jiří Dušek wrote:
> Hello,
> 
> We have experienced high latencies when pushing our application to the
> limits. Debugging led me to the realtime heap. Stress testing realtime
> heap has unexpected results. Stressing realtime heap from one task has
> no latency problem. Stressing realtime heap from two tasks bound to the
> same CPU has no latency problem. Stressing realtimne heap from two tasks
> bound to two distinct CPUs causes high latencies. There is nothing
> obvious like mode switches or errors.
> 
> Is this expected behavior of rt_heap_alloc/free? Can we do something to
> prevent this problem?

~1 ms jitter is obviously totally pathological, especially when the
typical latency is under 10 us.

Xenomai 2.6.5 is EOL, and several bugs have been fixed in the pipeline
patch since kernel 3.5, so the priority of digging any issue in such an
outdated context is very low.

To trigger some investigation, you could upgrade your setup. Xenomai
3.0.5 over kernel 4.1 or later would do.

You could also pinpoint the high latency spot by tracing the kernel,
enabling CONFIG_IPIPE_TRACE:
https://xenomai.org/2014/06/using-the-i-pipe-tracer/

-- 
Philippe.

