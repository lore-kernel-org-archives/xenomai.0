Message-ID: <52931C75.30808@xenomai.org>
Date: Mon, 25 Nov 2013 10:46:29 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <52931AC3.4050103@sigmatek.at>
In-Reply-To: <52931AC3.4050103@sigmatek.at>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_event_pulse  in user space
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: johann.obermayr@sigmatek.at, Xenomai@xenomai.org

On 11/25/2013 10:39 AM, Johann Obermayr wrote:
> Hello,
>
> Is there a way to make a
> rt_event_pulse.
> A kernel function  rtdm_event_pulse is available, but no user space
> function.
>

rtdm_event_pulse() is part of the inter-driver API, which explains why 
there is no userland access to it. Assuming you need to wake up a RTDM 
task waiting on a particular event via rtdm_event_wait(), then you have 
to implement an rt/nrt ioctl handler in your RTDM driver which will send 
the event. Userland can issue this ioctl request from userland.

-- 
Philippe.

