Subject: Re: [PATCH 5/7] cobalt/thread: fix scheduler breakage on thread
 suspension
References: <20191122171949.18021-1-rpm@xenomai.org>
 <20191122171949.18021-6-rpm@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <0b3657a3-78f8-dd8c-5ccf-d99339e8a0c3@xenomai.org>
Date: Sun, 24 Nov 2019 12:17:36 +0100
MIME-Version: 1.0
In-Reply-To: <20191122171949.18021-6-rpm@xenomai.org>
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
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 11/22/19 6:19 PM, Philippe Gerum wrote:
> From: Philippe Gerum <rpm@xenomai.org>
> 
> In the event that xnthread_suspend() adds blocking bit(s) to a thread
> which is running in primary mode on a remote CPU at the time of the
> call, a spurious rescheduling call is performed, causing the local CPU
> to pick its next thread from the remote CPU's runqueue.

I'll send an update asap for this one, removing an unnecessary change.

-- 
Philippe.

