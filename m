References: <56DEA622.4020107@sigmatek.at>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <56DEA859.2040306@xenomai.org>
Date: Tue, 8 Mar 2016 11:24:25 +0100
MIME-Version: 1.0
In-Reply-To: <56DEA622.4020107@sigmatek.at>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rtdm_event_wait -EINTR error
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: johann.obermayr@sigmatek.at, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 03/08/2016 11:14 AM, Johann Obermayr wrote:
> Hello,
> 
> We have some user space task running into a rtdm driver (ioctl).
> this task are waiting for a event with rtdm_event_wait.
> 
> When our appliction crash, we see that rtdm_event_wait return with -4
> (-EINTR).
> is this a normal behavior ?
> 

Please read your question above again, and ask yourself whether you
actually gave us enough information to figure out what you are talking
about.

-- 
Philippe.

